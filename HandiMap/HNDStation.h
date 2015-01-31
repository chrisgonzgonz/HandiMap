#import "HNDManagedStation.h"
#import <MapKit/MKAnnotation.h>

@class HNDManagedStation;
/// Yeah, I know you are suppose to use categories, but I prefer subclasses :)
@interface HNDStation : NSObject <MKAnnotation>
- (instancetype)initWithManagedStation:(HNDManagedStation *)managedStation NS_DESIGNATED_INITIALIZER;
@end
