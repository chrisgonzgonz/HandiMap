#import "HNDManagedStation.h"

#import <MapKit/MKAnnotation.h>

@class HNDManagedStation;
@class HNDSubwayLine;
@class UIColor;

@interface HNDStation : NSObject <MKAnnotation>

@property(nonatomic, readonly) NSArray *outages;
- (NSString *)name;
- (NSString *)subwayLines;
- (NSString *)accessibleLines;
- (NSString *)adaText;
- (UIColor *)annotationColor; // TODO: add this to a protocol that extends MKAnnotation.
- (instancetype)initWithManagedStation:(HNDManagedStation *)managedStation
    NS_DESIGNATED_INITIALIZER;
- (BOOL)isMemberOfSubwayLine:(HNDSubwayLine *)subwayLine;

@end
