#import "HNDStation.h"

#import "HNDColor.h"
#import "HNDSubwayLine.h"
#import "HNDManagedStation.h"

static NSString *kLineCharSeperator = @", ";

typedef NS_ENUM(NSUInteger, HNDStationStatus) {
  HNDStationStatusAda,
  HNDStationStatusOutage, // Partial vs full outages???
  HNDStationStatusNotAda
};

@interface HNDStation ()
@property(nonatomic, readwrite) HNDManagedStation *managedStation;
@property(nonatomic, readonly) HNDStationStatus stationStatus;
@end

@implementation HNDStation

#pragma mark - Public

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
  return self.managedStation.accessibleRoutes.count ? [self.managedStation.accessibleRoutes componentsJoinedByString:@", "] : @"None";
}

- (NSString *)adaText {
  return [self.managedStation.ada boolValue] ? @"Yes" : @"No";
}

- (UIColor *)annotationColor {
  switch (self.stationStatus) {
    case HNDStationStatusOutage:
      return [HNDColor errorColor];
    case HNDStationStatusNotAda:
      return [HNDColor warningColor];
    default:
      return [HNDColor highlightColor];
  }
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

#pragma mark - Private

- (HNDStationStatus)stationStatus {
  if (self.managedStation.outages.count) {
    return HNDStationStatusOutage;
  } else if (!self.managedStation.ada.boolValue) {
    return HNDStationStatusNotAda;
  }
  return HNDStationStatusAda;
}

@end
