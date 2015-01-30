#import "HNDMapFlow.h"

#import "HNDColor.h"
#import "HNDLabel.h"
#import "HNDMapViewController.h"
#import "HNDSubwayLine.h"
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
    _navController.navigationBar.tintColor = [HNDColor lightColor];
  }
  return _navController;
}

#pragma mark - Public

- (UIViewController *)initialViewController {
  [self setNavTitleText:kDefaultNavigationTitle];
  return self.navController;
}

- (void)presentNext:(UIViewController *)sender {
  if ([sender isKindOfClass:[HNDSubwayLineFilterViewController class]]) {
    [self presentMapViewFrom:(HNDSubwayLineFilterViewController *)sender];
  } else {
    NSAssert(NO, @"Flow does not know how to handle %@", [sender class]);
  }
}

#pragma mark - Private

- (void)setNavTitleText:(NSString *)navText {
  HNDLabel *navTitle = [[[[HNDLabel alloc] init] invertTextColor] typeTitle];
  navTitle.text = navText;
  [navTitle sizeToFit];

  self.navController.topViewController.navigationItem.titleView = navTitle;
}

- (UIViewController *)rootVC {
  UIViewController *rootVC = [[HNDSubwayLineFilterViewController alloc] initInFlow:self];
  rootVC.title = @"";
  return rootVC;
}

- (void)presentMapViewFrom:(HNDSubwayLineFilterViewController *)viewController {
  HNDSubwayLine *selectedLine = viewController.selectedLine;
  HNDMapViewController *destinationVC = [[HNDMapViewController alloc] initInFlow:self];
  // set destination.VC's selected line
  destinationVC.title = selectedLine.lineText;
  [self.navController pushViewController:destinationVC animated:YES];
}

@end
