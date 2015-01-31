#import "HNDStation.h"

#import "HNDSubwayLine.h"
#import "HNDManagedStation.h"

static NSString *kLineCharSeperator = @", ";

@interface HNDStation ()
@property (nonatomic) HNDManagedStation *managedStation;
@end

@implementation HNDStation

#pragma mark - Private

- (instancetype)initWithManagedStation:(HNDManagedStation *)managedStation {
  if (self = [super init]) {
    _managedStation = managedStation;
  }
  return self;
}

- (BOOL)isMemberOfSubwayLine:(HNDSubwayLine *)subwayLine {
  NSMutableSet *routeIntersection = [NSMutableSet setWithArray:self.managedStation.servedRoutes];
  [routeIntersection intersectSet:subwayLine.routes];
  return routeIntersection.count;
}

#pragma mark - Protocols
#pragma mark MKAnnotation

- (CLLocationCoordinate2D)coordinate {
  return CLLocationCoordinate2DMake(self.stationLatitude.doubleValue,
                                    self.stationLongitude.doubleValue);
}

- (NSString *)title {
  return self.managedStation.stationName;
}

- (NSString *)subtitle {
  return [[[self.managedStation.servedRoutes mutableCopy] sortedArrayUsingComparator:
      ^NSComparisonResult(NSString *subwayLineOne, NSString *subwayLineTwo) {
        return [subwayLineOne compare:subwayLineTwo];
      }] componentsJoinedByString:kLineCharSeperator];
}

#pragma mark - Mock Data...DELETE THIS!

- (NSNumber *)stationLatitude {
  return @(40.7484); // Empire State Building.
}

- (NSNumber *)stationLongitude {
  return @(-73.9857); // Empire State Building.
}

@end
