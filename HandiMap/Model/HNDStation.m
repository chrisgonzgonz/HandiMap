#import "HNDStation.h"

#import "HNDColor.h"
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
  if (!subwayLine.routes) return YES; // All lines.
  NSMutableSet *routeIntersection = [NSMutableSet setWithArray:self.managedStation.servedRoutes];
  [routeIntersection intersectSet:subwayLine.routes];
  return routeIntersection.count;
}

- (NSString *)name {
  return [self title];
}

- (NSString *)subwayLines {
  return [self.managedStation.servedRoutes componentsJoinedByString:@", "];
}

- (NSString *)accessibleLines {

  return [self.managedStation.accessibleRoutes componentsJoinedByString:@", "];
}

- (NSString *)ada {
  return [self.managedStation.ada boolValue] ? @"Yes" : @"No";
}

- (UIColor *)annotationColor {
  if (self.managedStation.outages.count) {
    return [HNDColor errorColor];
  } else if (!self.managedStation.ada) {
    return [HNDColor warningColor];
  }
  return [HNDColor highlightColor]; // success color?
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
