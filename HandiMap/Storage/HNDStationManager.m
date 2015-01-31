#import "HNDStationManager.h"

#import <CoreData/CoreData.h>

#import "HNDManagedStation.h"
#import "HNDStation.h"
#import "HNDStationDAO.h"
#import "HNDSubwayLine.h"

// TODO: Move this category on onf NSArray later :)
typedef id(^MapBlock)(id);
@interface NSArray (FP)
- (NSArray *)map:(MapBlock)block;
@end

@implementation NSArray (FP)
- (NSArray *)map:(MapBlock)block {
  NSMutableArray *resultArray = [[NSMutableArray alloc] init];
  for (id object in self) { [resultArray addObject:block(object)]; }
  return resultArray;
}
@end

@interface HNDStationManager()<NSFetchedResultsControllerDelegate>
@property(nonatomic) NSFetchedResultsController *allStationsController;
@property(nonatomic) NSArray *allStations;
@end

@implementation HNDStationManager

- (void)setAllStations:(NSArray *)allStations {
  _allStations = [allStations map:^HNDStation *(HNDManagedStation *managedStation) {
    return [[HNDStation alloc] initWithManagedStation:managedStation];
  }];
  [self.delegate filteredStationsDidChange:self.filteredStations];
}

- (instancetype)init {
  if (self = [super init]) {
    _allStationsController = [HNDStationDAO sharedDAO].allStations;
    _allStationsController.delegate = self;

    // Goes through custom setter in order to do the mapping.
    self.allStations = _allStationsController.fetchedObjects;
  }
  return self;
}

#pragma mark - Public

- (NSArray *)filteredStations {
  return self.subwayLineFilter
      ? [self.allStations filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:
          ^BOOL(HNDStation *station, NSDictionary *bindings) {
            return [station isMemberOfSubwayLine:self.subwayLineFilter];
          }]]
      : self.allStations;
}

- (void)setSubwayLineFilter:(HNDSubwayLine *)subwayLineFilter {
  if ([subwayLineFilter isEqual:_subwayLineFilter]) return;
  _subwayLineFilter = subwayLineFilter;
  [self.delegate filteredStationsDidChange:self.filteredStations];
}

#pragma mark - Protocols
#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  self.allStations = controller.fetchedObjects;
}

@end
