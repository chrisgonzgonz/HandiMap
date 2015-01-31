#import <UIKit/UIKit.h>

@class HNDMapFlow; // TODO: Create an abstract HNDFlow.

@interface HNDViewController : UIViewController
@property(nonatomic, readonly, weak) HNDMapFlow *flow;
- (instancetype)initInFlow:(HNDMapFlow *)flow NS_DESIGNATED_INITIALIZER;
@end
