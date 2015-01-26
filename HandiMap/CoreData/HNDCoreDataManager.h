#import <Foundation/Foundation.h>

@class NSManagedObjectContext;

/// A class used to manage the core data stack. Concurrency is handled via nested contexts as
/// described in \link http://floriankugler.com/2013/04/02/the-concurrent-core-data-stack/.
@interface HNDCoreDataManager : NSObject

/// A context that is associated with the main thread. Use this context for fetches and objects
/// used on the main thread. Do not do write operations with this context.
@property (nonatomic, readonly) NSManagedObjectContext *mainContext;

/// \return a new context to be used with write operations. Is is child context of the main context.
- (NSManagedObjectContext *)newWorkerContext;

/// Saves the context, which will propogate changes through the main context, and saves the
/// changes to disk. Once the context has been saved, it is safe to deallocate the context.
/// \param context is expected to be a worker context.
- (void)saveContext:(NSManagedObjectContext *)context;

@end
