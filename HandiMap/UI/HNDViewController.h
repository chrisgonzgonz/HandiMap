#import <UIKit/UIKit.h>

@class HNDMapFlow; // TODO: Create an abstract HNDFlow.

@interface HNDViewController : UIViewController
- (instancetype)initInFlow:(HNDMapFlow *)flow NS_DESIGNATED_INITIALIZER;
@end
