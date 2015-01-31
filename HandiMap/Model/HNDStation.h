#import "HNDManagedStation.h"
#import <MapKit/MKAnnotation.h>

@class HNDManagedStation;
@class HNDSubwayLine;

@interface HNDStation : NSObject <MKAnnotation>
@property (nonatomic, readonly) HNDManagedStation *managedStation;
- (instancetype)initWithManagedStation:(HNDManagedStation *)managedStation
    NS_DESIGNATED_INITIALIZER;
- (BOOL)isMemberOfSubwayLine:(HNDSubwayLine *)subwayLine;

@end
