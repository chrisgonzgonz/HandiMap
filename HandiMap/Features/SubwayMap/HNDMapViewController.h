#import "HNDViewController.h"

@class HNDMapFlow;
@class HNDSubwayLine;

@interface HNDMapViewController : HNDViewController
// The line that the view controller will scope stations by.
@property(nonatomic) HNDSubwayLine *subwayLine;
@end
