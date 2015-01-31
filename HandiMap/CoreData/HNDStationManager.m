#import "HNDStationManager.h"

#import <CoreData/CoreData.h>

#import "HNDStation.h"
#import "HNDStationDAO.h"
#import "HNDSubwayLine.h"

@interface HNDStationManager() <NSFetchedResultsControllerDelegate>
@property(nonatomic) NSFetchedResultsController *allStationsController;
@property(nonatomic) NSArray *unfilteredStations;
@end

@implementation HNDStationManager
@synthesize stations = _stations;

- (void)setStations:(NSArray *)stations {
  _stations = stations;
  // TODO: Notify Delegate.
}

- (void)setUnfilteredStations:(NSArray *)unfilteredStations {
  _unfilteredStations = unfilteredStations;
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

- (NSArray *)stations {
  if (!_stations) {
    // _stations = self.allStationsController;
    return @[[[HNDStation alloc] initWithManagedStation:nil]];
  }
  return _stations;
}

- (void)setSubwayLineFilter:(HNDSubwayLine *)subwayLineFilter {
  if ([subwayLineFilter isEqual:_subwayLineFilter]) return;
  _subwayLineFilter = subwayLineFilter;
  [self applySubwayLineFilter];
}

#pragma mark - Protocols
#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  self.unfilteredStations = controller.fetchedObjects;
}

#pragma mark - Private

- (void)applySubwayLineFilter {
  NSMutableArray *filteredStations = [[NSMutableArray alloc] init];
  // TODO: Pass through self.unfilteredStations and pick off ones to keep
  self.stations = filteredStations;
}

@end
