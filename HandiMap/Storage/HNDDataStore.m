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

- (void)loadStationsWithSuccess:(void (^)())success failure:(void (^)())failure {
  [self clearStationsWithSuccess:^{

    NSManagedObjectContext *workerContext = [[HNDCoreDataManager sharedManager] newWorkerContext];
    [[HNDJobNetworkManager sharedManager] getStationsWithCompletionBlock:^(id response) {
      [workerContext performBlock:^{
        for (NSDictionary *station in response) {
          NSEntityDescription *ed = [NSEntityDescription entityForName:@"HNDManagedStation"
                                                inManagedObjectContext:workerContext];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-value"
          [[HNDManagedStation alloc] initWithEntity:ed
                     insertIntoManagedObjectContext:workerContext
                                      andDictionary:station];
#pragma clang diagnostic pop
        }
        [[HNDCoreDataManager sharedManager] saveContext:workerContext];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          success();
        }];
      }];
    }];

  } failure:^{
    NSLog(@"Failed to clear stations fuck me");
  }];
}

- (void)clearStationsWithSuccess:(void(^)())success failure:(void(^)())failure {
  NSManagedObjectContext *workerContext = [[HNDCoreDataManager sharedManager] newWorkerContext];
  [workerContext performBlock:^{
    NSFetchRequest *stationFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"HNDManagedStation"];
    NSError *fetchError = nil;
    NSArray *stations = [workerContext executeFetchRequest:stationFetchRequest error:&fetchError];
    if (fetchError) {
      NSLog(@"Fetch error: %@", fetchError.localizedDescription);
    }

    for (HNDManagedOutage *station in stations) {
      [workerContext deleteObject:station];
    }
    [[HNDCoreDataManager sharedManager] saveContext:workerContext];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      success();
    }];
  }];
}

//TODO(gonzo): clear current outages before adding new ones
- (void)loadOutagesWithSuccess:(void (^)())success failure:(void (^)())failure {
  [self clearOutagesWithSuccess:^{

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
          if (currentStation) {
            for (NSDictionary *outage in station[@"outages"]) {
              NSEntityDescription *outageEntityDescription = [NSEntityDescription entityForName:@"HNDManagedOutage" inManagedObjectContext:workerContext];
              HNDManagedOutage *newOutage = [[HNDManagedOutage alloc] initWithEntity:outageEntityDescription insertIntoManagedObjectContext:workerContext andDictionary:outage];
              newOutage.station = currentStation;

            }
          } else {
            NSLog(@"No station: %@ for this outage", currentStation.stationId);
          }
        }
        [[HNDCoreDataManager sharedManager] saveContext:workerContext];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          success();
        }];
      }];
    }];

  } failure:^{
    NSLog(@"Failed to clear outages fuck me");
  }];
}

- (void)clearOutagesWithSuccess:(void(^)())success failure:(void(^)())failure {
  NSManagedObjectContext *workerContext = [[HNDCoreDataManager sharedManager] newWorkerContext];
  [workerContext performBlock:^{
    NSFetchRequest *outageFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"HNDManagedOutage"];
    NSError *fetchError = nil;
    NSArray *outages = [workerContext executeFetchRequest:outageFetchRequest error:&fetchError];
    if (fetchError) {
      NSLog(@"Fetch error: %@", fetchError.localizedDescription);
    }
    
    for (HNDManagedOutage *outage in outages) {
      [workerContext deleteObject:outage];
    }
    [[HNDCoreDataManager sharedManager] saveContext:workerContext];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      success();
    }];
  }];
}

@end
