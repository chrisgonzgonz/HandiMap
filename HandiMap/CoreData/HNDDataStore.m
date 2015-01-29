#import "HNDDataStore.h"

#import <CoreData/NSManagedObjectContext.h>

#import "HNDCoreDataManager.h"
#import "HNDJobNetworkManager.h"
#import "HNDManagedStation+Convenience.h"
#import "HNDManagedOutage+Convenience.h"

@implementation HNDDataStore

+ (instancetype)sharedStore {
  static HNDDataStore *_sharedDataStore = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedDataStore = [[HNDDataStore alloc] init];
  });
  return _sharedDataStore;
}

- (void)loadStations {
  NSManagedObjectContext *workerContext = [[HNDCoreDataManager sharedManager] newWorkerContext];
  [[HNDJobNetworkManager sharedManager] getStationsWithCompletionBlock:^(id response) {
    [workerContext performBlock:^{
      for (NSDictionary *dictionary in response) {
        NSEntityDescription *ed = [NSEntityDescription entityForName:@"HNDManagedStation"
                                              inManagedObjectContext:workerContext];
        HNDManagedStation *currentStation = [[HNDManagedStation alloc] initWithEntity:ed
                                         insertIntoManagedObjectContext:workerContext
                                                          andDictionary:dictionary];
      }
      [[HNDCoreDataManager sharedManager] saveContext:workerContext];
    }];
  }];
}

//TODO(gonzo): clear current outages before adding new ones
- (void)loadOutages {
  NSManagedObjectContext *workerContext = [[HNDCoreDataManager sharedManager] newWorkerContext];
  [[HNDJobNetworkManager sharedManager] getOutagesWithCompletionBlock:^(id response) {
    [workerContext performBlock:^{
      for (NSDictionary *station in response) {
        NSString *stationNumber = station[@"station_id"];
        NSFetchRequest *stationFetch = [NSFetchRequest fetchRequestWithEntityName:@"HNDManagedStation"];
        NSPredicate *stationPredicate = [NSPredicate predicateWithFormat:@"stationId == %@", stationNumber];
        stationFetch.predicate = stationPredicate;
        NSError *fetchError = nil;
        NSArray *stations = [workerContext executeFetchRequest:stationFetch error:&fetchError];
        if (fetchError) {
          NSLog(@"Fetch error: %@", fetchError.localizedDescription);
        }
        HNDManagedStation *currentStation = [stations firstObject];
        if (!currentStation) {
          NSLog(@"No station for this outage");
        }
        
        for (NSDictionary *outage in station[@"outages"]) {
          NSEntityDescription *outageEntityDescription = [NSEntityDescription entityForName:@"HNDManagedOutage" inManagedObjectContext:workerContext];
          HNDManagedOutage *newOutage = [[HNDManagedOutage alloc] initWithEntity:outageEntityDescription insertIntoManagedObjectContext:workerContext andDictionary:outage];
          newOutage.station = currentStation;
        }
      }
      [[HNDCoreDataManager sharedManager] saveContext:workerContext];
    }];
  }];
}

@end
