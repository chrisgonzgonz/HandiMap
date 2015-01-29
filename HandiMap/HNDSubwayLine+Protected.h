#import "HNDSubwayLine.h"

@interface HNDSubwayLine()

// Make readonly readwrite
@property(nonatomic, readwrite) UIColor *lineColor;
@property(nonatomic, readwrite) NSSet *routes;

- (instancetype)initWithLineColor:(UIColor *)lineColor routes:(NSSet *)routes
    NS_DESIGNATED_INITIALIZER;

@end