#import <Foundation/Foundation.h>

@class HNDSubwayLine;

@protocol HNDStationFilterDelegate<NSObject>

/// An \param array of HNDStations is passed for convenience.
- (void)filteredStationsDidChange:(NSArray *)filteredStations;

@end

/// The facade for the entire data stack from Core Data to the server.
@interface HNDStationManager : NSObject

/// This is the most up to date source of filtered stations.
/// Filtering by lines will change this property, and the delegate is notified when this changes.
/// \return an array of HNDStations
@property(nonatomic, readonly) NSArray *filteredStations;

/// Setting this will cause the stations array to be filtered by \param subwayLineFilter.
@property(nonatomic) HNDSubwayLine *subwayLineFilter;

/// This delegate is notified when \param filteredStations is changed.
@property(nonatomic) id<HNDStationFilterDelegate> delegate;

@end
