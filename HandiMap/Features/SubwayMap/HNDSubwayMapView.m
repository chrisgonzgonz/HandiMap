#import "HNDSubwayMapView.h"

#import <MapKit/MapKit.h>
#import "MKMapView+ZoomLevel.h"
#import "ZSPinAnnotation.h"

#import "HNDColor.h"
#import "HNDButton.h"
#import "HNDStation.h"

static CGFloat const kAnimationDuration = 0.25f;
static CGFloat const kDetailViewSpan    = 0.60f;
static CGFloat const kMapCoordSpan      = 0.05f;
static CGFloat const kPreviewHeight     = 44.0f; // TODO: Make this dynamic.
static CGFloat const kZoomLevel         = 12; // Higher is more zoomed in.
static NSString *kPinReuseId            = @"ZSPinAnnotation Reuse ID";

typedef NS_ENUM(NSUInteger, HNDDetailViewState) {
  HNDDetailViewStateHidden,
  HNDDetailViewStatePreview,
  HNDDetailViewStateShow
};

@interface HNDSubwayMapView() <MKMapViewDelegate>
@property(nonatomic, readwrite) MKMapView *mapView;
@property(nonatomic) NSLayoutConstraint *detailViewPositionContraint;
@property(nonatomic) MKAnnotationView *selectedAnnotationView;
@property(nonatomic) CGFloat detailViewPositionY;
@property(nonatomic) CGFloat lastTranslation; // translation is always 0 when pan ends.
@property(nonatomic) HNDDetailViewState detailViewState;
@end

@implementation HNDSubwayMapView

#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [HNDColor lightColor];

    _mapView = [[MKMapView alloc] init];
    [self setUpMap:_mapView];

    [self addSubview:_mapView];
    [self autolayoutViews];
  }
  return self;
}

#pragma mark - Public

- (void)setStationDetailView:(UIView *)stationDetailView {
  _stationDetailView = stationDetailView;
  _stationDetailView.userInteractionEnabled = YES;
  _stationDetailView.gestureRecognizers = @[
    [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetailView:)],
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetailView:)]
  ];
  [self addSubview:_stationDetailView];
  [self autoLayoutDetailSubview];
  [self layoutIfNeeded];
}

- (void)updateStations:(NSArray *)stations {
  NSMutableArray *toRemove = [self.mapView.annotations mutableCopy];
  [toRemove removeObject:self.mapView.userLocation];
  [self.mapView removeAnnotations:toRemove];
  [self.mapView addAnnotations:stations];
}

- (void)centerAnnotion:(CLLocation *)location {
  [self centerCoordinate:location.coordinate inMap:self.mapView];
}

- (void)centerUser {
  [self centerCoordinate:self.mapView.userLocation.location.coordinate inMap:self.mapView];
}

#pragma mark - TargetActions

- (void)panDetailView:(UIPanGestureRecognizer *)recognizer {
  CGPoint translation = [recognizer translationInView:self];

  // Don't pan past the bottom.
  CGFloat nextPosY = recognizer.view.center.y + translation.y;
  CGFloat minPosY = self.bounds.size.height - (0.5f *recognizer.view.bounds.size.height);
  nextPosY = nextPosY > minPosY ? nextPosY : minPosY;

  recognizer.view.center = CGPointMake(recognizer.view.center.x, nextPosY);
  [recognizer setTranslation:CGPointZero inView:self];

  // Snap it.
  if (recognizer.state == UIGestureRecognizerStateEnded) {
    if (self.detailViewState == HNDDetailViewStatePreview) {
      if (self.lastTranslation > 0) {
        [self hideStationDetails];
      } else {
        [self showStationDetails];
      }
    } else { // assuming show state.
      if (nextPosY > minPosY) {
        [self hideStationDetails];
      }
    }
  }
  self.lastTranslation = translation.y;
}

- (void)tapDetailView:(UITapGestureRecognizer *)recognizer {
  if (self.detailViewState == HNDDetailViewStatePreview) {
    [self showStationDetails];
  }
}

#pragma mark - Protocols
#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
  // TODO: Make HNDStationAnnotation protocol.
  HNDStation *stationAnnotaion = (HNDStation *)annotation;

  ZSPinAnnotation *pinView = (ZSPinAnnotation *)
      ([mapView dequeueReusableAnnotationViewWithIdentifier:kPinReuseId]
      ?: [[ZSPinAnnotation alloc] initWithAnnotation:stationAnnotaion reuseIdentifier:kPinReuseId]);
  pinView.annotation = stationAnnotaion;
  pinView.annotationType = ZSPinAnnotationTypeTag;
  pinView.annotationColor = stationAnnotaion.annotationColor; // will break with clusters.
  pinView.canShowCallout = NO;
  return pinView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
  if ([self.selectedAnnotationView isEqual:view]) return;
  [self centerCoordinate:view.annotation.coordinate inMap:mapView];
  if (![view.annotation isKindOfClass:[MKUserLocation class]]) {
    self.selectedAnnotationView = view;
    ((ZSPinAnnotation *)view).annotationColor = [HNDColor mainColor];
    [self showStationDetailsPreview];
    [self.delegate didSelectStation:self.selectedAnnotationView.annotation];
  }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
  if (![view.annotation isKindOfClass:[MKUserLocation class]]) {
    self.selectedAnnotationView = nil;
    ((ZSPinAnnotation *)view).annotationColor = ((HNDStation *)view.annotation).annotationColor;
    [self hideStationDetails];
    if ([self.delegate respondsToSelector:@selector(didDeselectStation:)]) {
      [self.delegate didDeselectStation:view.annotation];
    }
  }
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
  id<MKAnnotation> centerView = self.selectedAnnotationView.annotation ?: mapView.userLocation;
  // Should not be comparing floats...whatever...
  BOOL validCenter = centerView.coordinate.latitude != 0.0f;
  if(mapView.zoomLevel < kZoomLevel && validCenter) {
    [mapView setCenterCoordinate:centerView.coordinate zoomLevel:kZoomLevel animated:YES];
  }
}

#pragma mark - Private
#pragma mark MapView Helpers

- (void)setUpMap:(MKMapView *)map {
  _mapView.showsUserLocation = YES;
  _mapView.userLocation.title = nil;
  _mapView.delegate = self;

  // Default zoom.
  MKCoordinateRegion mapRegion;
  mapRegion.center = CLLocationCoordinate2DMake(40.759211, -73.984638); // Times Square
  mapRegion.span.latitudeDelta = kMapCoordSpan;
  mapRegion.span.longitudeDelta = kMapCoordSpan;
  [map setRegion:mapRegion animated:NO];
}

- (void)centerCoordinate:(CLLocationCoordinate2D)coordinate inMap:(MKMapView *)mapView {
  if (self.detailViewState == HNDDetailViewStateShow) { // adjust the center
    coordinate.latitude -= self.mapView.region.span.latitudeDelta * (kDetailViewSpan * 0.5f);
  }

  MKMapPoint point = MKMapPointForCoordinate(coordinate);
  MKMapRect rect = [mapView visibleMapRect];
  rect.origin.x = point.x - rect.size.width * 0.5;
  rect.origin.y = point.y - rect.size.height * 0.5;
  [mapView setVisibleMapRect:rect animated:YES];
}

#pragma mark Show and Hide Detail View

- (void)setDetailViewPositionContraint:(NSLayoutConstraint *)detailViewPositionContraint {
  [self removeConstraint:_detailViewPositionContraint];
  _detailViewPositionContraint = detailViewPositionContraint;
  [self addConstraint:_detailViewPositionContraint];
}

- (void)showStationDetailsPreview {
  self.detailViewState = HNDDetailViewStatePreview;
  self.detailViewPositionContraint = [self previewDetailViewContraint];
  [self animateLayoutWithStyle:UIViewAnimationOptionCurveEaseOut onComplete:nil];
}

- (void)showStationDetails {
  self.detailViewState = HNDDetailViewStateShow;
  self.detailViewPositionContraint = [self showDetailViewContraint];
  // Need to readjust the center of the map.
  [self animateLayoutWithStyle:UIViewAnimationOptionCurveEaseInOut onComplete:^(BOOL finished) {
    [self centerCoordinate:self.selectedAnnotationView.annotation.coordinate inMap:self.mapView];
  }];
}

- (void)hideStationDetails {
  self.detailViewState = HNDDetailViewStateHidden;
  self.detailViewPositionContraint = [self hideDetailViewContraint];
  [self animateLayoutWithStyle:UIViewAnimationOptionCurveEaseIn onComplete:nil];
  if (self.selectedAnnotationView) {
//    [self.mapView deselectAnnotation:self.selectedAnnotationView.annotation animated:YES];
    [self mapView:self.mapView didDeselectAnnotationView:self.selectedAnnotationView];
  }
}

#pragma mark AutoLayout

- (void)autolayoutViews {
  _mapView.translatesAutoresizingMaskIntoConstraints = NO;
  NSDictionary *views = NSDictionaryOfVariableBindings(_mapView);
  // Horizontal layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|[_mapView]|"
                          options:0
                          metrics:nil
                            views:views]];
  // Vertical layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|[_mapView]|"
                          options:0
                          metrics:nil
                            views:views]];
}

// Starts out hidden.
- (void)autoLayoutDetailSubview {
  self.stationDetailView.translatesAutoresizingMaskIntoConstraints = NO;
  NSDictionary *views = NSDictionaryOfVariableBindings(_stationDetailView);

  // Horizontal layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|[_stationDetailView]|"
                          options:0
                          metrics:nil
                            views:views]];

  // Vertical layout
  [self addConstraint:[NSLayoutConstraint constraintWithItem:self.stationDetailView
                                                   attribute:NSLayoutAttributeHeight
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self
                                                   attribute:NSLayoutAttributeHeight
                                                  multiplier:kDetailViewSpan
                                                    constant:0]];
  [self hideStationDetails];
}

#pragma mark - Poistion Contraints

- (NSLayoutConstraint *)previewDetailViewContraint {
  return [NSLayoutConstraint constraintWithItem:self.stationDetailView
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1.0
                                       constant:-kPreviewHeight];
}

- (NSLayoutConstraint *)showDetailViewContraint {
  return [NSLayoutConstraint constraintWithItem:self.stationDetailView
                                      attribute:NSLayoutAttributeBottom
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1.0
                                       constant:0];
}

- (NSLayoutConstraint *)hideDetailViewContraint {
  return [NSLayoutConstraint constraintWithItem:self.stationDetailView
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1.0
                                       constant:0];
}


- (void)animateLayoutWithStyle:(UIViewAnimationOptions)animationOption
                    onComplete:(void (^)(BOOL finished))completion {
  [UIView animateWithDuration:kAnimationDuration
                        delay:0
                      options:animationOption
                   animations:^{ [self layoutIfNeeded]; }
                   completion:completion];
}

@end
