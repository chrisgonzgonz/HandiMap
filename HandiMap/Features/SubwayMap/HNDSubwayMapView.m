#import "HNDSubwayMapView.h"

#import <MapKit/MapKit.h>
#import "ZSPinAnnotation.h"

#import "HNDColor.h"
#import "HNDButton.h"
#import "HNDStation.h"

static CGFloat const kAnimationDuration = 0.2f; // This is copy and pasted...define globaly.
static CGFloat const kMapCoordSpan      = 0.07f;
static CGFloat const kPreviewHeight     = 44.0f; // TODO: Make this dynamic.
static NSString *kPinReuseId            = @"ZSPinAnnotation Reuse ID";

@interface HNDSubwayMapView() <MKMapViewDelegate>
@property(nonatomic, readwrite) MKMapView *mapView;
@property(nonatomic) NSLayoutConstraint *detailViewPositionContraint;
@property(nonatomic) MKAnnotationView *selectedAnnotationView;
@end

@implementation HNDSubwayMapView

#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [HNDColor lightColor];

    _mapView = [[MKMapView alloc] init];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;

    [self addSubview:_mapView];
    [self autolayoutViews];
  }
  return self;
}


#pragma mark - Public

- (void)setStationDetailView:(UIView *)stationDetailView {
//  _stationDetailView = stationDetailView;
  _stationDetailView = [[UIView alloc] init];
  _stationDetailView.backgroundColor = [UIColor purpleColor];
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

// TODO: Handle this better...should not always center user. Only the first time.
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
  MKCoordinateRegion mapRegion;
  mapRegion.center = userLocation.coordinate;
  mapRegion.span.latitudeDelta = kMapCoordSpan;
  mapRegion.span.longitudeDelta = kMapCoordSpan;
  [mapView setRegion:mapRegion animated:YES];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
  if ([self.selectedAnnotationView isEqual:view]) {
    return;
  } else {
    self.selectedAnnotationView = view;
  }
  MKMapPoint point = MKMapPointForCoordinate(view.annotation.coordinate);
  MKMapRect rect = [mapView visibleMapRect];
  rect.origin.x = point.x - rect.size.width * 0.5;
  rect.origin.y = point.y - rect.size.height * 0.5;
  [mapView setVisibleMapRect:rect animated:YES];
  if (view.annotation != [MKUserLocation class]) {
    [self showStationDetailsPreview];
    [self.delegate didSelectStation:view.annotation];
  }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
  if (view.annotation != [MKUserLocation class]) {
    [self hideStationDetails];
    [self.delegate didSelectStation:view.annotation];
  }
}

#pragma mark - Private
#pragma mark Show and Hide Detail View

- (void)setDetailViewPositionContraint:(NSLayoutConstraint *)detailViewPositionContraint {
  [self removeConstraint:_detailViewPositionContraint];
  _detailViewPositionContraint = detailViewPositionContraint;
  [self addConstraint:_detailViewPositionContraint];
}

- (void)showStationDetailsPreview {
  self.detailViewPositionContraint = [self previewDetailViewContraint];
  [self animateLayoutWithStyle:UIViewAnimationOptionCurveEaseIn];
}

- (void)showStationDetails {

}

- (void)hideStationDetails {
  self.detailViewPositionContraint = [self hideDetailViewContraint];
  [self animateLayoutWithStyle:UIViewAnimationOptionCurveEaseOut];
}

#pragma mark - autoLayout

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
                                                      toItem:self.mapView
                                                   attribute:NSLayoutAttributeHeight
                                                  multiplier:0.75f
                                                    constant:0]
  ];
  self.detailViewPositionContraint = [self hideDetailViewContraint];
}

#pragma mark - Poistion Contraints

- (NSLayoutConstraint *)previewDetailViewContraint {
  return [NSLayoutConstraint constraintWithItem:self.stationDetailView
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self.mapView
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1.0
                                       constant:-kPreviewHeight];
}

- (NSLayoutConstraint *)hideDetailViewContraint {
  return [NSLayoutConstraint constraintWithItem:self.stationDetailView
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self.mapView
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1.0
                                       constant:0];
}

- (NSLayoutConstraint *)showDetailViewContraint {
  return [NSLayoutConstraint constraintWithItem:self.stationDetailView
                                      attribute:NSLayoutAttributeBottom
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self.mapView
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1.0
                                       constant:0];
}

- (void)animateLayoutWithStyle:(UIViewAnimationOptions)animationOption {
  [UIView animateWithDuration:kAnimationDuration
                        delay:0
                      options:animationOption
                   animations:^{ [self layoutIfNeeded]; }
                   completion:nil];
}

@end
