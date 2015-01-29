#import "HNDMapFlow.h"

#import "HNDColor.h"
#import "HNDMapViewController.h"
#import "HNDSubwayLineFilterViewController.h"

static NSString *const kDefaultNavigationTitle = @"HandiMap";

@interface HNDMapFlow()
@property(nonatomic) UINavigationController *navController;
@end

@implementation HNDMapFlow

- (UINavigationController *)navController {
  if (!_navController) {
    _navController = [[UINavigationController alloc]
        initWithRootViewController:[self rootVC]];
    _navController.navigationBar.translucent = NO;
    _navController.navigationBar.barTintColor = [HNDColor mainColor];
  }
  return _navController;
}

#pragma mark - Public

- (UIViewController *)initialViewController {
  return self.navController;
}

- (void)presentNext:(UIViewController *)sender {
//  if ([sender isKindOfClass:[HNDStartViewController class]]) {
//    [self presentNearestSubwaysListFrom:sender];
//  } else {
//    NSAssert(NO, @"Flow does not know how to handle %@", [sender class]);
//  }
}

#pragma mark - Private

- (UIViewController *)rootVC {
  return [[HNDSubwayLineFilterViewController alloc] initInFlow:self];
}

- (void)presentNearestSubwaysListFrom:(UIViewController *)viewController {
  UIViewController *tmpViewController = [[UIViewController alloc] init]; // TODO: Pass in self.
  tmpViewController.view.backgroundColor = [UIColor purpleColor];
  [viewController presentViewController:tmpViewController animated:YES completion:nil];
}

@end
