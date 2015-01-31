#import "HNDStationManager.h"

#import <CoreData/CoreData.h>

#import "HNDCoreDataManager.h"
#import "HNDStation.h"

@interface HNDStationManager() <NSFetchedResultsControllerDelegate>
@end

@implementation HNDStationManager

- (NSArray *)stations {
  // TODO: Actually populate this. This is just mock data for now.
  return @[[[HNDStation alloc] initWithManagedStation:nil]];
}

#pragma mark - Public

- (void)filterStationByLine:(HNDSubwayLine *)subwayLine {

}

- (void)sync {
  // load from server.
  // NSFetchedResultsController will take care of the rest
}

@end
