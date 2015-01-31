#import "HNDStation.h"

#import "HNDManagedStation.h"
@interface HNDStation ()
@property (nonatomic) HNDManagedStation *managedStation;
@end
@implementation HNDStation

- (instancetype)initWithManagedStation:(HNDManagedStation *)managedStation
{
  if (self = [super init]) {
    _managedStation = managedStation;
  }
  return self;
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
  return self.managedStation.servedRoutes;
}

#pragma mark - Mock Data...DELETE THIS!

- (NSNumber *)stationLatitude {
  return @(40.7484); // Empire State Building.
}

- (NSNumber *)stationLongitude {
  return @(-73.9857); // Empire State Building.
}

@end
