#import "SNRSonarFlow.h"

#import "SNRStartViewController.h"

@implementation SNRSonarFlow

#pragma mark - Public

- (UIViewController *)initialViewController {
  return [[SNRStartViewController alloc] init];
}

- (void)presentNext:(UIViewController *)sender {

}

@end
