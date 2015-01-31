#import "HNDStationDAO.h"

#import <CoreData/CoreData.h>

#import "HNDCoreDataManager.h"
#import "HNDManagedStation.h"

static NSString *kStationIdKey = @"stationId";
NSString *const kStationEntityName = @"HNDManagedStation";

@interface HNDStationDAO()
@property(nonatomic)NSFetchRequest *allStationsRequest;
@end

@implementation HNDStationDAO

@synthesize allStations = _allStations;

- (NSFetchRequest *)allStationsRequest {
  if (!_allStationsRequest) {
    _allStationsRequest = [NSFetchRequest fetchRequestWithEntityName:kStationEntityName];
    _allStationsRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:kStationIdKey
                                                                          ascending:YES]];
  }
  return _allStationsRequest;
}

#pragma mark - Public

- (NSFetchedResultsController *)allStations {
  if (!_allStations) {
    NSManagedObjectContext *mainContext = [HNDCoreDataManager sharedManager].mainContext;
    _allStations = [[NSFetchedResultsController alloc] initWithFetchRequest:self.allStationsRequest
                                                       managedObjectContext:mainContext
                                                         sectionNameKeyPath:nil
                                                                  cacheName:nil];
    [_allStations performFetch:nil];
  }
  return _allStations;
}

+ (instancetype)sharedDAO {
  static HNDStationDAO *_sharedDataStore = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedDataStore = [[HNDStationDAO alloc] init];
  });
  return _sharedDataStore;
}

@end
