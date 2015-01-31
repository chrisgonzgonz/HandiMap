#import <Foundation/Foundation.h>

extern NSString *const kStationEntityName;

@class NSFetchedResultsController;

@interface HNDStationDAO : NSObject

// This will perform a fetch when it is first accessed.
@property(nonatomic, readonly) NSFetchedResultsController *allStations;

+ (instancetype)sharedDAO;

@end
