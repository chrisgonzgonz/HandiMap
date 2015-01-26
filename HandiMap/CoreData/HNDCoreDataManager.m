#import "HNDCoreDataManager.h"

#import <CoreData/CoreData.h>

static NSString * const kDataModelURL = @"HandiMap";
@interface HNDCoreDataManager ()

@property (nonatomic) NSManagedObjectContext *masterContext;
@property (nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readwrite) NSManagedObjectContext *mainContext;

@end
@implementation HNDCoreDataManager


- (NSManagedObjectContext *)newWorkerContext {
  NSManagedObjectContext *newWorker = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  newWorker.parentContext = self.mainContext;
  return newWorker;
}

- (void)saveContext:(NSManagedObjectContext *)context {
  [context save:nil];
  if (context.parentContext) {
    [self saveContext:context.parentContext];
  }
}

- (NSManagedObjectContext *)mainContext {
  if (!_mainContext) {
    _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _mainContext.parentContext = self.masterContext;
  }
  return _mainContext;
}

#pragma mark - Private
- (NSManagedObjectContext *)masterContext {
    if (!_masterContext) {
        if (self.persistentStoreCoordinator) {
            _masterContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            _masterContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
        }
    }
    
    return _masterContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kDataModelURL withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        NSURL *storeURL = [self persistentStoreURL];
        NSError *error;
        
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
        }
    }
    
    return _persistentStoreCoordinator;
}

- (NSURL *)persistentStoreURL {
    NSURL *storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", kDataModelURL]];
  NSLog(@"%@", storeURL);
    return storeURL;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
