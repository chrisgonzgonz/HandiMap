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
#import "HNDSubwayMapView.h"


static CGFloat const kHNDMapCoordSpan = 0.1f;

@interface HNDMapViewController () <MKMapViewDelegate>
// Casts root view.
@property(nonatomic) HNDSubwayMapView *view;

// TODO: Delete this and connect to real data.
@property(nonatomic) HNDStation *mockStation;
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

  // TODO: Delete this.
  self.mockStation = [[HNDStation alloc] init];
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

@end
