#import "HNDCoreDataManager.h"

#import <CoreData/CoreData.h>

static NSString *const kDataModelURL = @"HandiMap";

@interface HNDCoreDataManager ()

@property (nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic) NSManagedObjectModel *managedObjectModel;
@property (nonatomic) NSManagedObjectContext *masterContext;

// Changes readonly properties to readwrite.
@property (nonatomic, readwrite) NSManagedObjectContext *mainContext;

@end

@implementation HNDCoreDataManager

#pragma mark - Public

+ (instancetype)sharedManager {
  static HNDCoreDataManager *_sharedManager= nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedManager = [[HNDCoreDataManager alloc] init];
  });
  
  return _sharedManager;
}

- (NSManagedObjectContext *)mainContext {
  if (!_mainContext) {
    _mainContext =
        [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _mainContext.parentContext = self.masterContext;
  }
  return _mainContext;
}

- (NSManagedObjectContext *)newWorkerContext {
  NSManagedObjectContext *newWorker =
      [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  newWorker.parentContext = self.mainContext;
  return newWorker;
}

- (void)saveContext:(NSManagedObjectContext *)context {
  NSManagedObjectContext *__weak weakContext = context;
  [context performBlock:^{
    [weakContext save:nil];
    if (weakContext.parentContext) {
      [self saveContext:weakContext.parentContext];
    }
  }];
}

#pragma mark - Core Data Stack

- (NSManagedObjectContext *)masterContext {
  if (!_masterContext) {
    _masterContext =
        [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    _masterContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
  }
  return _masterContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        _managedObjectModel = [[NSManagedObjectModel alloc]
            initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:kDataModelURL
                                                          withExtension:@"momd"]];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  if (!_persistentStoreCoordinator) {
    _persistentStoreCoordinator =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSError *error = nil;
    NSDictionary *persistentStoreConnectionOptions = @{
      NSMigratePersistentStoresAutomaticallyOption: @YES,
      NSInferMappingModelAutomaticallyOption: @YES
    };
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:self.persistentStoreURL
                                                         options:persistentStoreConnectionOptions
                                                           error:&error]) {
      // TODO(gonzo): Increment the managedObjectModel and re-attempt to create the
      // persistentStoreCoordinator once. Then throw an exception if still failing.
      NSLog(@"Could not create persistent store with error: %@, %@", error, error.userInfo);
    }
  }
  return _persistentStoreCoordinator;
}

#pragma mark - Private

- (NSURL *)applicationDocumentsDirectory {
  return [[[NSFileManager defaultManager]
           URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (NSURL *)persistentStoreURL {
  NSURL *storeURL = [[self applicationDocumentsDirectory]
      URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", kDataModelURL]];
  NSLog(@"Core data storage path: %@", storeURL);
  return storeURL;
}

@end
