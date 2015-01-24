@import Foundation;

@class UIViewController;

@interface HNDMapFlow : NSObject
- (UIViewController *)initialViewController;
- (void)presentNext:(UIViewController *)sender;
@end
