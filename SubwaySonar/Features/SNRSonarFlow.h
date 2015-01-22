@import Foundation;

@class UIViewController;

@interface SNRSonarFlow : NSObject
- (UIViewController *)initialViewController;
- (void)presentNext:(UIViewController *)sender;
@end
