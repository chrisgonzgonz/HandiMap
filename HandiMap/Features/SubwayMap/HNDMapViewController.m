#import "HNDMapViewController.h"

#import "INTULocationManager.h"

#import "HNDColor.h"
#import "HNDStation.h"
#import "HNDStationManager.h"
#import "HNDSubwayMapView.h"
// TODO: Generalize this to UIViewController to break this dependency.
#import "HNDStationDetailViewController.h"
#import "HNDStationDetailView.h"

@interface HNDMapViewController () <HNDStationFilterDelegate,
                                    HNDSubwayMapViewDelegate>
@property(nonatomic) HNDSubwayMapView *view; // Casts root view.
@property(nonatomic) NSLayoutConstraint *stationDetailHeightConstraint;
@property(nonatomic) HNDStation *selectedStation;
@property(nonatomic) HNDStationDetailViewController *stationDetailVC;
@property(nonatomic) HNDStationManager *stationManager;
@end

@implementation HNDMapViewController

- (void)setSubwayLine:(HNDSubwayLine *)subwayLine {
  _subwayLine = subwayLine;
  self.stationManager.subwayLineFilter = subwayLine;
}

- (void)setSelectedStation:(HNDStation *)selectedStation {
  _selectedStation = selectedStation;
}

#pragma mark - Overrides

- (void)loadView {
  self.view = [[HNDSubwayMapView alloc] init];
  [self loadSubviewController];

}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self getCurrentLocation];
  [self loadStations];
  self.view.delegate = self;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

#pragma mark - Protocols
#pragma mark HNDStationFilterDelegate

- (void)filteredStationsDidChange:(NSArray *)filteredStations {
  [self.view updateStations:filteredStations];
}

#pragma mark HNDSubwayMapViewDelegate

- (void)didSelectStation:(HNDStation *)station {
  self.stationDetailVC.selectedStation = station;
}

#pragma mark - Private

- (void)loadSubviewController {
  self.stationDetailVC = [[HNDStationDetailViewController alloc] init];
  [self.stationDetailVC willMoveToParentViewController:self];
  [self addChildViewController:self.stationDetailVC];
  self.view.stationDetailView = self.stationDetailVC.view;
  [self.stationDetailVC didMoveToParentViewController:self];
}

- (void)loadStations {
  self.stationManager = [[HNDStationManager alloc] init];
  self.stationManager.delegate = self;
  self.stationManager.subwayLineFilter = self.subwayLine;
  [self.view updateStations:self.stationManager.filteredStations];
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
