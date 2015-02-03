#import <Foundation/Foundation.h>

@class UIViewController;

@interface HNDMapFlow : NSObject
- (UIViewController *)initialViewController;
- (void)presentAppInfo:(UIViewController *)sender;
- (void)presentNext:(UIViewController *)sender;
@end
