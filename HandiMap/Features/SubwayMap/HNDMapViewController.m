#import "HNDMapViewController.h"

#import "INTULocationManager.h"

#import "HNDColor.h"
#import "HNDStation.h"
#import "HNDStationManager.h"
#import "HNDSubwayMapView.h"
// TODO: Generalize this to UIViewController to break this dependency.
#import "HNDStationDetailViewController.h"
#import "HNDStationDetailView.h"
#import <MapKit/MKMapView.h>

@interface HNDMapViewController () <HNDStationFilterDelegate, HNDSubwayMapViewDelegate>
// Casts root view.
@property(nonatomic) HNDSubwayMapView *view;

// TODO: Delete this and connect to real data.
@property(nonatomic) HNDStationManager *stationManager;
@property(nonatomic) HNDStationDetailViewController *stationDetailVC;
@property(nonatomic) NSLayoutConstraint *stationDetailHeightConstraint;
@end

@implementation HNDMapViewController

- (void)setSubwayLine:(HNDSubwayLine *)subwayLine {
  _subwayLine = subwayLine;
  self.stationManager.subwayLineFilter = subwayLine;
}

#pragma mark - Overrides

- (void)loadView {
  self.view = [[HNDSubwayMapView alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self getCurrentLocation];

  self.stationManager = [[HNDStationManager alloc] init];
  self.stationManager.delegate = self;
  self.stationManager.subwayLineFilter = self.subwayLine;
  [self.view updateStations:self.stationManager.filteredStations];
  
  [self setupStationDetailVC];
  
  self.view.delegate = self;
}

//- (void)setDefaultZoom {
////  REMOVE THIS
//  CLLocationCoordinate2D fakeLocation = CLLocationCoordinate2DMake(40.7358, -74.0036);
//  MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(fakeLocation, 500000, 500000);
//  MKCoordinateRegion adjustedRegion = [self.view.mapView regionThatFits:viewRegion];
//  [self.view.mapView setRegion:adjustedRegion animated:YES];
//}

- (void)didSelectAnnotationWithStation:(HNDStation *)station {
  self.stationDetailVC.selectedStation = station;
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
  [self.view updateStations:filteredStations];
}

#pragma mark - Private

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
  self.stationDetailHeightConstraint.constant = self.stationDetailVC.view.outtageButton.selected
      ? self.view.frame.size.height * 0.75f
      : 44.0f;
  [UIView animateWithDuration:0.5 animations:^{
    [self.view layoutIfNeeded];
  }];
}

@end
