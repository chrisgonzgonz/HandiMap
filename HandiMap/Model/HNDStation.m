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
  return !subwayLine || routeIntersection.count;
}

- (NSString *)name {
  return [self title];
}

- (NSString *)subwayLines {
  return [[self.managedStation.servedRoutes valueForKey:@"description"] componentsJoinedByString:@", "];
}

- (NSString *)accessibleLines {
  return [[self.managedStation.accessibleRoutes valueForKey:@"description"] componentsJoinedByString:@", "];
}

- (NSString *)ada {
  return [self.managedStation.ada boolValue] ? @"YES" : @"NO";
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
