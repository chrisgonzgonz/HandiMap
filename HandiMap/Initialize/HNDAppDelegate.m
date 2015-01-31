#import "HNDAppDelegate.h"

#import "HNDMapFlow.h"

@interface HNDAppDelegate()
@property(nonatomic) HNDMapFlow *currentFlow;
@end
@implementation HNDAppDelegate

- (UIWindow *)window {
  if (!_window) {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
  }
  return _window;
}

- (HNDMapFlow *)currentFlow {
  if (!_currentFlow) {
    _currentFlow = [[HNDMapFlow alloc] init];
  }
  return _currentFlow;
}

#pragma mark - Protocols
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
  self.window.rootViewController = [self.currentFlow initialViewController];
  return YES;
}

@end
