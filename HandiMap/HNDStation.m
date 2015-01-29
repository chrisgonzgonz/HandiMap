#import "HNDStation.h"

#import <CoreLocation/CLLocation.h>

@implementation HNDStation

- (CLLocation *)location {
  return [[CLLocation alloc] initWithLatitude:self.stationLatitude.doubleValue
                                    longitude:self.stationLongitude.doubleValue];
}

@end
