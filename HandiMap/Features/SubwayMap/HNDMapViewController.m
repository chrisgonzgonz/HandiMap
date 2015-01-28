#import "HNDMapViewController.h"

@import MapKit;
#import "INTULocationManager.h"

#import "HNDCoreDataManager.h"
#import "HNDJobNetworkManager.h"
#import "HNDOutage.h"
#import "HNDStation.h"
#import "HNDSubwayMapView.h"
#import "HNDDataStore.h"

static CGFloat const kHNDMapCoordSpan = 0.5f;

@interface HNDMapViewController () <MKMapViewDelegate>
// TODO: Extract this into a UIViewController base class if you ever feel like it.
@property(nonatomic) HNDMapFlow *flow;
// Casting the root view.
@property(nonatomic) HNDSubwayMapView *view;
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
  
  [[HNDDataStore sharedStore] loadStations];
}

#pragma mark - Public

- (instancetype)initInFlow:(HNDMapFlow *)flow {
  if (self = [super init]) {
    _flow = flow;
  }
  return self;
}

#pragma mark - TargetActions

- (void)showFilterView:(UIButton *)sender {
  NSLog(@"I will show you the filter view");
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

  [self.view.selectedFilterBtnView addTarget:self
                                      action:@selector(showFilterView:)
                            forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - To Delete

// TODO: remove this!
- (void)tempFakeData {
  HNDCoreDataManager *cdManager = [HNDCoreDataManager sharedManager];
  NSManagedObjectContext *workerContext = [cdManager newWorkerContext];
  //  [[HNDJobNetworkManager sharedManager] getOutagesWithCompletionBlock:nil];
  HNDStation *station1 = [NSEntityDescription insertNewObjectForEntityForName:@"HNDStation"
                                                       inManagedObjectContext:workerContext];
  station1.stationName = @"FapKing";
  HNDStation *station2 = [NSEntityDescription insertNewObjectForEntityForName:@"HNDStation"
                                                       inManagedObjectContext:workerContext];
  station2.stationName = @"SchlickQueen";

  HNDOutage *outage1 = [NSEntityDescription insertNewObjectForEntityForName:@"HNDOutage"
                                                     inManagedObjectContext:workerContext];
  outage1.reason = @"Ball Cheez";
  HNDOutage *outage2 = [NSEntityDescription insertNewObjectForEntityForName:@"HNDOutage"
                                                     inManagedObjectContext:workerContext];
  outage2.reason = @"Ball Cheddar";
  [station1 addOutages:[NSSet setWithArray:@[outage1, outage2]]];

  HNDOutage *outage3 = [NSEntityDescription insertNewObjectForEntityForName:@"HNDOutage"
                                                     inManagedObjectContext:workerContext];
  outage3.reason = @"Ball Chizz";
  [station2 addOutagesObject:outage3];
  [workerContext save:nil];

  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HNDStation"];
  NSArray *fetchedObjects = [cdManager.mainContext executeFetchRequest:request error:nil];
  NSLog(@"%@", fetchedObjects);
}

@end
