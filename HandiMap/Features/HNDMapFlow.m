#import "HNDMapFlow.h"

#import "HNDInfoViewController.h"
#import "HNDLabel.h"
#import "HNDMapViewController.h"
#import "HNDStyleKit.h"
#import "HNDSubwayLine.h"
#import "HNDSubwayLineFilterViewController.h"

static NSString *const kDefaultNavigationTitle = @"HandiMap";

@interface HNDMapFlow()
@property(nonatomic) UINavigationController *navController;
@property(nonatomic) HNDMapViewController *mapViewController; // caching
@end

@implementation HNDMapFlow

- (UINavigationController *)navController {
  if (!_navController) {
    _navController = [[UINavigationController alloc] initWithRootViewController:[self rootVC]];
    _navController.navigationBar.translucent = NO;
    _navController.navigationBar.barTintColor = [HNDColor mainColor];
    _navController.navigationBar.tintColor = [HNDColor lightColor];
    _navController.navigationBar.titleTextAttributes = @{
      NSFontAttributeName: [HNDFont titleFont],
      NSForegroundColorAttributeName: [HNDColor lightColor]
    };
  }
  return _navController;
}

- (HNDMapViewController *)mapViewController {
  if (!_mapViewController) {
    _mapViewController = [[HNDMapViewController alloc] initInFlow:self];
  }
  return _mapViewController;
}

#pragma mark - Public

- (UIViewController *)initialViewController {
  return self.navController;
}

- (void)presentAppInfo:(UIViewController *)sender {
  UIViewController *infoViewController = [[HNDInfoViewController alloc] init];
  infoViewController.title = @"HandiMap";
  // TODO: Make this a modal instead...too lazy to implement back button.
  [self.navController pushViewController:infoViewController animated:YES];
}

- (void)presentNext:(UIViewController *)sender {
  if ([sender isKindOfClass:[HNDSubwayLineFilterViewController class]]) {
    [self presentMapViewFrom:(HNDSubwayLineFilterViewController *)sender];
  } else {
    NSAssert(NO, @"Flow does not know how to handle %@", [sender class]);
  }
}

#pragma mark - Private

- (UIViewController *)rootVC {
  UIViewController *rootVC = [[HNDSubwayLineFilterViewController alloc] initInFlow:self];
  rootVC.title = kDefaultNavigationTitle;
  rootVC.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
      initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
  return rootVC;
}

- (void)presentMapViewFrom:(HNDSubwayLineFilterViewController *)viewController {
  HNDSubwayLine *selectedLine = viewController.selectedLine;
  self.mapViewController.title = selectedLine.lineText;
  self.mapViewController.subwayLine = selectedLine;
  [self.navController pushViewController:self.mapViewController animated:YES];
}

@end
