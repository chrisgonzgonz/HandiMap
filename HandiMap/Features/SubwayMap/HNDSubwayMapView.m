#import "HNDSubwayMapView.h"

#import <MapKit/MapKit.h>
#import "CCHMapClusterController.h"
#import "ZSPinAnnotation.h"

#import "HNDColor.h"
#import "HNDButton.h"

static CGFloat const kClusterCellSize = 30.0f;
static CGFloat const kHNDMapCoordSpan = 0.1f;
static NSString *kPinReuseId = @"ZSPinAnnotation Reuse ID";

@interface HNDSubwayMapView() <MKMapViewDelegate>
@property(nonatomic, readonly) CCHMapClusterController *mapClusterController;
@end

@implementation HNDSubwayMapView

#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _mapView = [[MKMapView alloc] init];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;

    _mapClusterController = [[CCHMapClusterController alloc] initWithMapView:_mapView];
    _mapClusterController.cellSize = kClusterCellSize;

    [self addSubview:_mapView];
    [self autolayoutViews];
  }
  return self;
}


#pragma mark - Public

- (void)updateStations:(NSArray *)stations {
  NSMutableArray *annotationsToRemove = [self.mapView.annotations mutableCopy];
  [annotationsToRemove removeObject:self.mapView.userLocation];
  [self.mapClusterController removeAnnotations:annotationsToRemove withCompletionHandler:nil];
  [self.mapClusterController addAnnotations:stations withCompletionHandler:nil];
}

#pragma mark - Protocols
#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;

  ZSPinAnnotation *pinView = (ZSPinAnnotation *)
  ([self.mapView dequeueReusableAnnotationViewWithIdentifier:kPinReuseId]
   ?: [[ZSPinAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:kPinReuseId]);
  pinView.annotation = annotation;
  pinView.annotationType = ZSPinAnnotationTypeTag;
  pinView.annotationColor = [HNDColor highlightColor];
  pinView.canShowCallout = NO;
  return pinView;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
  MKCoordinateRegion mapRegion;
  mapRegion.center = userLocation.coordinate;
  mapRegion.span.latitudeDelta = kHNDMapCoordSpan;
  mapRegion.span.longitudeDelta = kHNDMapCoordSpan;
  [mapView setRegion:mapRegion animated:YES];
}

// TODO: Figure out why this isn't being called.
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
  MKMapPoint point = MKMapPointForCoordinate(view.annotation.coordinate);
  MKMapRect rect = [mapView visibleMapRect];
  rect.origin.x = point.x - rect.size.width * 0.5;
  rect.origin.y = point.y - rect.size.height * 0.5;
  [mapView setVisibleMapRect:rect animated:YES];
}

#pragma mark - Private

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

@end
