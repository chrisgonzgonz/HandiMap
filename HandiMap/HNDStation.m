#import "HNDStation.h"

@implementation HNDStation

#pragma mark - Protocols
#pragma mark MKAnnotation

- (CLLocationCoordinate2D)coordinate {
  return CLLocationCoordinate2DMake(self.stationLatitude.doubleValue,
                                    self.stationLongitude.doubleValue);
}

- (NSString *)title {
  return self.stationName;
}

- (NSString *)subtitle {
  return self.servedRoutes;
}

#pragma mark - Mock Data...DELETE THIS!

- (NSNumber *)stationLatitude {
  return @(40.7484); // Empire State Building.
}

- (NSNumber *)stationLongitude {
  return @(-73.9857); // Empire State Building.
}

@end
