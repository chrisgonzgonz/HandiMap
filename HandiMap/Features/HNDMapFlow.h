#import <Foundation/Foundation.h>

@class UIViewController;

@interface HNDMapFlow : NSObject
- (UIViewController *)initialViewController;
- (void)presentNext:(UIViewController *)sender;
@end
