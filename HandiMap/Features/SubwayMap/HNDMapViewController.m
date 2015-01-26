#import "HNDMapViewController.h"

@import MapKit;

#import "HNDCoreDataManager.h"
#import "HNDJobNetworkManager.h"
#import "HNDOutage.h"
#import "HNDStation.h"
#import "HNDSubwayMapView.h"

@interface HNDMapViewController () <MKMapViewDelegate>

@property(nonatomic) HNDMapFlow *flow;

// Casting the root view.
@property(nonatomic) HNDSubwayMapView *view;

// IBOutlet copycats. These need to be set from the root view.
@property(nonatomic, weak) MKMapView *mapView;

@end

@implementation HNDMapViewController

#pragma mark - Overrides

- (void)loadView {
  self.view = [[HNDSubwayMapView alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupOutlets];
  [self bindViews];
}

#pragma mark - Public

- (instancetype)initInFlow:(HNDMapFlow *)flow {
  if (self = [super init]) {
    _flow = flow;
  }
  return self;
}

#pragma mark - Private

- (void)setupOutlets {
  self.mapView = self.view.mapView;
}

- (void)bindViews {
  self.mapView.delegate = self;
}

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
