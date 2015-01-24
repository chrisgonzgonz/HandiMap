@import Foundation;

@class UIViewController;

@interface HNDSonarFlow : NSObject
- (UIViewController *)initialViewController;
- (void)presentNext:(UIViewController *)sender;
@end
