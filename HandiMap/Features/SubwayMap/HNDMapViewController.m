#import "HNDMapViewController.h"

#import "HNDSubwayMapView.h"
#import <MapKit/MapKit.h>
#import "HNDCoreDataManager.h"
#import "HNDOutage.h"
#import "HNDStation.h"
#import "HNDJobNetworkManager.h"

@interface HNDMapViewController () <MKMapViewDelegate>

@property(nonatomic) HNDMapFlow *flow;
@property(nonatomic) HNDSubwayMapView *view;

@end

@implementation HNDMapViewController

- (instancetype)initInFlow:(HNDMapFlow *)flow {
  if (self = [super init]) {
    _flow = flow;
  }
  return self;
}

- (void)loadView {
  self.view = [[HNDSubwayMapView alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.mapView.delegate = self;
  
  HNDCoreDataManager *cdManager = [HNDCoreDataManager sharedManager];
  NSManagedObjectContext *workerContext = [cdManager newWorkerContext];
//  [[HNDJobNetworkManager sharedManager] getOutagesWithCompletionBlock:nil];
  HNDStation *station1 = [NSEntityDescription insertNewObjectForEntityForName:@"HNDStation" inManagedObjectContext:workerContext];
  station1.stationName = @"FapKing";
  HNDStation *station2 = [NSEntityDescription insertNewObjectForEntityForName:@"HNDStation" inManagedObjectContext:workerContext];
  station2.stationName = @"FapQueen";
  
  HNDOutage *outage1 = [NSEntityDescription insertNewObjectForEntityForName:@"HNDOutage" inManagedObjectContext:workerContext];
  outage1.reason = @"Ball Cheez";
  HNDOutage *outage2 = [NSEntityDescription insertNewObjectForEntityForName:@"HNDOutage" inManagedObjectContext:workerContext];
  outage2.reason = @"Ball Cheddar";
  [station1 addOutages:[NSSet setWithArray:@[outage1, outage2]]];
  
  HNDOutage *outage3 = [NSEntityDescription insertNewObjectForEntityForName:@"HNDOutage" inManagedObjectContext:workerContext];
  outage3.reason = @"Ball Ghouda";
  [station2 addOutagesObject:outage3];
  [workerContext save:nil];
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HNDStation"];
  NSArray *fetchedObjects = [cdManager.mainContext executeFetchRequest:request error:nil];
  NSLog(@"%@", fetchedObjects);
}

@end
