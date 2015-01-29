#import "HNDMapFlow.h"

#import "HNDMapViewController.h"
#import "HNDSubwayLineFilterViewController.h"

@implementation HNDMapFlow

#pragma mark - Public

- (UIViewController *)initialViewController {
  return [[HNDSubwayLineFilterViewController alloc] initInFlow:self];
}

- (void)presentNext:(UIViewController *)sender {
//  if ([sender isKindOfClass:[HNDStartViewController class]]) {
//    [self presentNearestSubwaysListFrom:sender];
//  } else {
//    NSAssert(NO, @"Flow does not know how to handle %@", [sender class]);
//  }
}

#pragma mark - Private

- (void)presentNearestSubwaysListFrom:(UIViewController *)viewController {
  UIViewController *tmpViewController = [[UIViewController alloc] init]; // TODO: Pass in self.
  tmpViewController.view.backgroundColor = [UIColor purpleColor];
  [viewController presentViewController:tmpViewController animated:YES completion:nil];
}

@end
