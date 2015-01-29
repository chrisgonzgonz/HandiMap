#import "HNDMapFlow.h"

#import "UINavigationController+Block.h"
#import "LCZoomTransition.h"

#import "HNDColor.h"
#import "HNDLabel.h"
#import "HNDMapViewController.h"
#import "HNDSubwayLineFilterViewController.h"

static NSString *const kDefaultNavigationTitle = @"HandiMap";

@interface HNDMapFlow()
@property(nonatomic) UINavigationController *navController;
@property(nonatomic) LCZoomTransition *transition;
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
  self.navController.topViewController.title = @"";
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
  return [[HNDSubwayLineFilterViewController alloc] initInFlow:self];
}

- (void)presentMapViewFrom:(HNDSubwayLineFilterViewController *)viewController {
  // Does this need to be instantiated for each transition?
//  self.transition = [[LCZoomTransition alloc] initWithNavigationController:self.navController];
//  self.transition.sourceView = viewController.selectedCell;

  HNDMapViewController *destinationVC = [[HNDMapViewController alloc] initInFlow:self];
//  viewController.selectedLine ... pass this into the map view

  [self.navController pushViewController:destinationVC animated:YES onCompletion:^{
//    UIPinchGestureRecognizer *pinchRecognizer =
//    [[UIPinchGestureRecognizer alloc] initWithTarget:self.transition
//                                              action:@selector(handlePinch:)];
//    [viewController.view addGestureRecognizer:pinchRecognizer];
  }];
}

@end
