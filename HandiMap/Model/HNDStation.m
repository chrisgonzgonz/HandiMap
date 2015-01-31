#import "HNDStation.h"

#import "HNDSubwayLine.h"
#import "HNDManagedStation.h"

static NSString *kLineCharSeperator = @", ";

@interface HNDStation ()
@property (nonatomic, readwrite) HNDManagedStation *managedStation;
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
  return CLLocationCoordinate2DMake(self.managedStation.stationLatitude.doubleValue,
                                    self.managedStation.stationLongitude.doubleValue);
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

@end
