#import "HNDDataStore.h"

#import <CoreData/NSManagedObjectContext.h>

#import "HNDCoreDataManager.h"
#import "HNDJobNetworkManager.h"
#import "HNDManagedStation+Convenience.h"

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
        NSEntityDescription *ed = [NSEntityDescription entityForName:@"HNDStation"
                                              inManagedObjectContext:workerContext];
        HNDManagedStation *currentStation = [[HNDManagedStation alloc] initWithEntity:ed
                                         insertIntoManagedObjectContext:workerContext
                                                          andDictionary:dictionary];
      }
      [[HNDCoreDataManager sharedManager] saveContext:workerContext];
    }];
  }];
}

- (void)loadOutages {
  NSManagedObjectContext *workerContext = [[HNDCoreDataManager sharedManager] newWorkerContext];
  [[HNDJobNetworkManager sharedManager] getOutagesWithCompletionBlock:^(id response) {
    [workerContext performBlock:^{
      for (NSDictionary *dictionary in response) {
        NSNumber *stationNumber = dictionary[@"station_id"];
        NSFetchRequest *stationFetch = [NSFetchRequest fetchRequestWithEntityName:@"HNDStation"];
        NSPredicate *stationPredicate = [NSPredicate predicateWithFormat:@"stationId == %@", stationNumber];
        stationFetch.predicate = stationPredicate;
        NSError *fetchError = nil;
        NSArray *stations = [workerContext executeFetchRequest:stationFetch error:&fetchError];
        if (fetchError) {
          NSLog(@"Fetch error: %@", fetchError.localizedDescription);
        }
        
        NSEntityDescription *ed = [NSEntityDescription entityForName:@"HNDStation"
                                              inManagedObjectContext:workerContext];
        HNDStation *currentStation = [[HNDStation alloc] initWithEntity:ed
                                         insertIntoManagedObjectContext:workerContext
                                                          andDictionary:dictionary];
      }
      [[HNDCoreDataManager sharedManager] saveContext:workerContext];
    }];
  }];
}

@end
