#import <Foundation/Foundation.h>

@class NSManagedObjectContext;

@interface HNDCoreDataManager : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *mainContext;
- (NSManagedObjectContext *)newWorkerContext;

@end
