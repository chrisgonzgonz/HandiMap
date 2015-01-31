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
@synthesize filteredStations = _filteredStations;

- (void)setFilteredStations:(NSArray *)filteredStations {
  _filteredStations = filteredStations;
  [self.delegate filteredStationsDidChange:_filteredStations];
}

- (void)setAllStations:(NSArray *)allStations {
  // TODO: Use a category to get rid of the need for a mapping.
  _allStations = [allStations map:^HNDStation *(HNDManagedStation *managedStation) {
    return [[HNDStation alloc] initWithManagedStation:managedStation];
  }];
  [self applySubwayLineFilter];
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
  if (!_filteredStations) {
    self.allStations = self.allStationsController.fetchedObjects;
  }
  return _filteredStations;
}

- (void)setSubwayLineFilter:(HNDSubwayLine *)subwayLineFilter {
  if ([subwayLineFilter isEqual:_subwayLineFilter]) return;
  _subwayLineFilter = subwayLineFilter;
  [self applySubwayLineFilter];
}

#pragma mark - Protocols
#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  self.allStations = controller.fetchedObjects;
}

#pragma mark - Private

- (void)applySubwayLineFilter {
  self.filteredStations = self.subwayLineFilter ?
      [self.allStations filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:
          ^BOOL(HNDStation *station, NSDictionary *bindings) {
            return [station isMemberOfSubwayLine:self.subwayLineFilter];
          }]]
      : self.allStations;
}

@end
