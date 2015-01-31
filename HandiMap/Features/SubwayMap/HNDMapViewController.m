#import "HNDMapViewController.h"

#import <MapKit/MapKit.h>
#import "INTULocationManager.h"
#import "ZSPinAnnotation.h"

#import "HNDColor.h"
#import "HNDStation.h"
#import "HNDStationManager.h"
#import "HNDSubwayMapView.h"
// TODO: Generalize this to UIViewController to break this dependency.
#import "HNDStationDetailViewController.h"
#import "HNDStationDetailView.h"

static CGFloat const kHNDMapCoordSpan = 0.1f;
static NSString *kPinReuseId = @"ZSPinAnnotation Reuse ID";

@interface HNDMapViewController () <HNDStationFilterDelegate,
                                    MKMapViewDelegate>
// Casts root view.
@property(nonatomic) HNDSubwayMapView *view;

// TODO: Delete this and connect to real data.
@property(nonatomic) HNDStationManager *stationManager;
@property(nonatomic) HNDStationDetailViewController *stationDetailVC;
@property(nonatomic) NSLayoutConstraint *stationDetailHeightConstraint;
@end

@implementation HNDMapViewController

#pragma mark - Overrides

- (void)loadView {
  self.view = [[HNDSubwayMapView alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupViews];
  [self getCurrentLocation];

  self.stationManager = [[HNDStationManager alloc] init];
  self.stationManager.delegate = self;
  [self.view.mapView addAnnotations:self.stationManager.filteredStations];
  
  [self setupStationDetailVC];
}



- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
  [self expandDetailsContainer];
}

#pragma mark - TargetActions

- (void)showStationDetails:(UIButton *)sender {
  self.stationDetailVC.view.outtageButton.selected = !self.stationDetailVC.view.outtageButton.selected;
  [self expandDetailsContainer];
}

#pragma mark - Protocols
#pragma mark HNDStationFilterDelegate

- (void)filteredStationsDidChange:(NSArray *)filteredStations {
  NSMutableArray *annotationsToRemove = [self.view.mapView.annotations mutableCopy];
  [annotationsToRemove removeObject:self.view.mapView.userLocation];
  [self.view.mapView removeAnnotations: annotationsToRemove];
  [self.view.mapView addAnnotations:filteredStations];
}

#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
  MKCoordinateRegion mapRegion;
  mapRegion.center = userLocation.coordinate;
  mapRegion.span.latitudeDelta = kHNDMapCoordSpan;
  mapRegion.span.longitudeDelta = kHNDMapCoordSpan;
  [mapView setRegion:mapRegion animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  if (![annotation isKindOfClass:[HNDStation class]]) return nil;

  ZSPinAnnotation *pinView = (ZSPinAnnotation *)
      ([self.view.mapView dequeueReusableAnnotationViewWithIdentifier:kPinReuseId]
       ?: [[ZSPinAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:kPinReuseId]);
  pinView.annotation = annotation;
  pinView.annotationType = ZSPinAnnotationTypeTag;
  pinView.annotationColor = [HNDColor highlightColor];
  pinView.canShowCallout = NO;
  return pinView;
}

#pragma mark - Private

- (void)setupViews {
  self.view.mapView.showsUserLocation = YES;
  self.view.mapView.delegate = self;
}

- (void)setupStationDetailVC {
  self.stationDetailVC = [[HNDStationDetailViewController alloc] init];
  [self addChildViewController:self.stationDetailVC];
  [self.view addSubview:self.stationDetailVC.view];
  NSDictionary *views = @{@"detailView": self.stationDetailVC.view};
  self.stationDetailHeightConstraint = [NSLayoutConstraint constraintWithItem:self.stationDetailVC.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44];
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.stationDetailVC.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
  [self.view addConstraint:self.stationDetailHeightConstraint];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[detailView]|" options:0 metrics:nil views:views]];
  [self.stationDetailVC.view.outtageButton addTarget:self
                                              action:@selector(showStationDetails:)
                                    forControlEvents:UIControlEventTouchUpInside];

  [self.stationDetailVC didMoveToParentViewController:self];
}

- (void)getCurrentLocation {
  // INTULocationManager gets CLLocationManager permission in addition to the current location.
  // I think MKMapView automatically will update the current location and call back to
  // it's delegate. If this is confirmed, the INTULocationManager pod can be removed,
  // but we need to manually handle asking for CLLocationManager permissions.
  
  // TODO: Get a stream and update values. If this is not needed, then INTULocationManager,
  // can be deleted.
  [[INTULocationManager sharedInstance]
      requestLocationWithDesiredAccuracy:INTULocationAccuracyHouse
                                 timeout:10
                                   block:^(CLLocation *currentLocation,
                                           INTULocationAccuracy achievedAccuracy,
                                           INTULocationStatus status) {
     if (status == INTULocationStatusSuccess) {
       NSLog(@"Location: %@", currentLocation);
     } else {
       NSLog(@"Could not get location. FML.");
     }
   }];
}

// TODO: Move this into the view.
- (void)expandDetailsContainer{
  self.stationDetailHeightConstraint.constant = self.stationDetailVC.view.outtageButton.selected ?
      self.view.frame.size.height * 0.75f
      : 44.0f;
  [UIView animateWithDuration:0.5 animations:^{
    [self.view layoutIfNeeded];
  }];
}

@end
