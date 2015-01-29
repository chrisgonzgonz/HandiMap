#import "HNDManagedStation.h"

@class CLLocation;

/// Yeah, I know you are suppose to use categories, but I prefer subclasses :)
@interface HNDStation : HNDManagedStation
@property(nonatomic, readonly) CLLocation *location;
@end
