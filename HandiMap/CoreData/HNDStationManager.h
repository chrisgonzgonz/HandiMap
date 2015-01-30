#import <Foundation/Foundation.h>

@class HNDSubwayLine;

/// The facade for the entire data stack from Core Data to the server.
@interface HNDStationManager : NSObject

// TODO: Implement delegatation instead of KVO?
/// This is the most up to date source of stations. Filtering by lines will change this property.
/// KVO this to get real time updates.
/// \return an array of HNDStations
@property(nonatomic, readonly) NSArray *stations;

/// Scopes down the \property stations to those with routes on \param subwayLine.
- (void)filterStationByLine:(HNDSubwayLine *)subwayLine;

/// Syncs the to get the latest information from the server.
- (void)sync;

@end
