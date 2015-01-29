#import "HNDViewController.h"

@class HNDSubwayLine;

@interface HNDSubwayLineFilterViewController : HNDViewController
@property(nonatomic, readonly) HNDSubwayLine *selectedLine;
@property(nonatomic, readonly) UITableViewCell *selectedCell; // Exposed for LCZoomTransition
@end
