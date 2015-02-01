#import "HNDSubwayMapView.h"

#import <MapKit/MapKit.h>
#import "ZSPinAnnotation.h"

#import "HNDColor.h"
#import "HNDButton.h"
#import "HNDStation.h"

static CGFloat const kHNDMapCoordSpan = 0.07f;
static NSString *kPinReuseId = @"ZSPinAnnotation Reuse ID";

@interface HNDSubwayMapView() <MKMapViewDelegate>

@property(nonatomic, readwrite) MKMapView *mapView;
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
  mapRegion.span.latitudeDelta = kHNDMapCoordSpan;
  mapRegion.span.longitudeDelta = kHNDMapCoordSpan;
  [mapView setRegion:mapRegion animated:YES];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
  MKMapPoint point = MKMapPointForCoordinate(view.annotation.coordinate);
  MKMapRect rect = [mapView visibleMapRect];
  rect.origin.x = point.x - rect.size.width * 0.5;
  rect.origin.y = point.y - rect.size.height * 0.5;
  [mapView setVisibleMapRect:rect animated:YES];
  if (![view.annotation isKindOfClass:[MKUserLocation class]]) {
    [self.delegate didSelectStation:view.annotation];
  }
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
