#import "HNDMapViewController.h"

#import <MapKit/MapKit.h>
#import "INTULocationManager.h"

// TODO(gonzo): Remove Dependency on CoreData stuff. Expose models to do the heavy lifting.
#import "HNDCoreDataManager.h"
#import "HNDDataStore.h"
#import "HNDManagedOutage.h"
#import "HNDManagedStation.h"
#import "HNDJobNetworkManager.h"

#import "HNDStation.h"
#import "HNDStationManager.h"
#import "HNDSubwayMapView.h"
#import "ZSPinAnnotation.h"
#import "HNDStationDetailViewController.h"
#import "HNDStationDetailView.h"

static CGFloat const kHNDMapCoordSpan = 0.1f;

@interface HNDMapViewController () <MKMapViewDelegate>
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
  [self.view.mapView addAnnotations:self.stationManager.filteredStations];
  
  [self setupStationDetailVC];
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
  [self.stationDetailVC.view.outtageButton addTarget:self action:@selector(stationDetailButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
  
  [self.stationDetailVC didMoveToParentViewController:self];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
  [self expandDetailsContainer];
}

- (void)stationDetailButtonTapped:(UIButton *)sender {
  self.stationDetailVC.view.outtageButton.selected = !self.stationDetailVC.view.outtageButton.selected;
  [self expandDetailsContainer];
}

- (void)expandDetailsContainer{
  CGFloat newSize = 44.0;
  if (self.stationDetailVC.view.outtageButton.selected) {
    newSize = self.view.frame.size.height * 0.75;
  }
  self.stationDetailHeightConstraint.constant = newSize;
  [UIView animateWithDuration:0.5 animations:^{
    [self.view layoutIfNeeded];
  }];

}

#pragma mark - Protocols
#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
  MKCoordinateRegion mapRegion;
  mapRegion.center = userLocation.coordinate;
  mapRegion.span.latitudeDelta = kHNDMapCoordSpan;
  mapRegion.span.longitudeDelta = kHNDMapCoordSpan;
  [mapView setRegion:mapRegion animated:YES];
}

#pragma mark - Private

- (void)setupViews {
  self.view.mapView.showsUserLocation = YES;
  self.view.mapView.delegate = self;
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  if (![annotation isKindOfClass:[HNDStation class]]) return nil;
  
  HNDStation *currentStation = annotation;
  static NSString *greenPinID = @"greenPin";
  ZSPinAnnotation *pinView = (ZSPinAnnotation *)[self.view.mapView dequeueReusableAnnotationViewWithIdentifier:greenPinID];
  if (!pinView) {
    pinView = [[ZSPinAnnotation alloc] initWithAnnotation:currentStation reuseIdentifier:greenPinID];
  }
  pinView.annotationType = ZSPinAnnotationTypeTag;
  pinView.annotationColor = [UIColor orangeColor];
  pinView.canShowCallout = NO;
  return pinView;
}

@end
