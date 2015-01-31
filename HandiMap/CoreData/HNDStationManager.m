#import "HNDStationManager.h"

#import <CoreData/CoreData.h>

#import "HNDStation.h"
#import "HNDStationDAO.h"
#import "HNDSubwayLine.h"

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
  _allStations = allStations;
  [self applySubwayLineFilter];
}

- (instancetype)init {
  if (self = [super init]) {
    _allStationsController = [HNDStationDAO sharedDAO].allStations;
    _allStationsController.delegate = self;
  }
  return self;
}

#pragma mark - Public

- (NSArray *)filteredStations {
  if (!_filteredStations) {
    // _stations = self.allStationsController;
    return @[[[HNDStation alloc] initWithManagedStation:nil]];
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
  self.filteredStations =
      [self.allStations filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:
          ^BOOL(HNDStation *station, NSDictionary *bindings) {
            return YES;
          }]];
}

@end
