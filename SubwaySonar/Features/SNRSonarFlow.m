#import "SNRSonarFlow.h"

#import "SNRStartViewController.h"

@implementation SNRSonarFlow

#pragma mark - Public

- (UIViewController *)initialViewController {
  return [[SNRStartViewController alloc] initInFlow:self];
}

- (void)presentNext:(UIViewController *)sender {
  if ([sender isKindOfClass:[SNRStartViewController class]]) {
    [self presentNearestSubwaysListFrom:sender];
  } else {
    NSAssert(NO, @"Flow does not know how to handle %@", [sender class]);
  }
}

#pragma mark - Private

- (void)presentNearestSubwaysListFrom:(UIViewController *)viewController {
  UIViewController *tmpViewController = [[UIViewController alloc] init]; // TODO: Pass in self.
  tmpViewController.view.backgroundColor = [UIColor purpleColor];
  [viewController presentViewController:tmpViewController animated:YES completion:nil];
}

@end
