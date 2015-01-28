#import "HNDDataStore.h"

#import "HNDJobNetworkManager.h"
#import "HNDCoreDataManager.h"
#import <CoreData/NSManagedObjectContext.h>
#import "HNDStation+Convenience.h"

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
  HNDJobNetworkManager *networkManager = [HNDJobNetworkManager sharedManager];
  [networkManager getStationsWithCompletionBlock:^(id response) {
    [workerContext performBlock:^{
      for (NSDictionary *dictionary in response) {
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

- (void)loadOutages {
  
}

@end
