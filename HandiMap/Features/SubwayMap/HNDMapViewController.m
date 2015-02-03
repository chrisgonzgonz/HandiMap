#import "HNDMapViewController.h"

#import "INTULocationManager.h"
#import <SVProgressHUD.h>

#import "HNDColor.h"
#import "HNDStation.h"
#import "HNDStationManager.h"
#import "HNDSubwayMapView.h"
// TODO: Generalize this to UIViewController to break this dependency.
// This should be injected and conforms to HNDStationDetail protocol.
#import "HNDStationDetailViewController.h"

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
  [self setupViews];
  if (!self.stationManager.filteredStations.count) {
    [SVProgressHUD setBackgroundColor:[HNDColor mainColor]];
    [SVProgressHUD setForegroundColor:[HNDColor lightColor]];
    [SVProgressHUD show];
  }
}

#pragma mark - TargetAction

- (void)centerUserLocation:(UIBarButtonItem *)sender {
  [self.view centerUser];
}

#pragma mark - Protocols
#pragma mark HNDStationFilterDelegate

- (void)filteredStationsDidChange:(NSArray *)filteredStations {
  [SVProgressHUD dismiss];
  [self.view updateStations:filteredStations];
}

#pragma mark HNDSubwayMapViewDelegate

- (void)didSelectStation:(HNDStation *)station {
  self.stationDetailVC.selectedStation = station;
}

#pragma mark - Private

- (void)setupViews {
  self.view.delegate = self;
  UIImage *gpsImage =
    [[UIImage imageNamed:@"gps-32_skinny"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  UIImageView *infoView = [[UIImageView alloc] initWithImage:gpsImage];
  infoView.tintColor = [HNDColor lightColor];
  infoView.contentMode = UIViewContentModeScaleAspectFit;
  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithImage:gpsImage
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(centerUserLocation:)];
}

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
  [[INTULocationManager sharedInstance]
      requestLocationWithDesiredAccuracy:INTULocationAccuracyHouse
                                 timeout:10
                                   block:^(CLLocation *currentLocation,
                                           INTULocationAccuracy achievedAccuracy,
                                           INTULocationStatus status) {
     if (status == INTULocationStatusSuccess) {
       [self.view centerAnnotion:currentLocation];
     } else {
       NSLog(@"Could not get location. FML.");
     }
   }];
}

@end
