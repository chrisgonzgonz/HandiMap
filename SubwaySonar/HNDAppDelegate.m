#import "HNDAppDelegate.h"

#import "HNDSonarFlow.h"

@interface HNDAppDelegate()

// Putting this here for now so that it does not get released. Is there a better way?
// TODO: Create an HNDFlow base class to remove this dependency.
@property(nonatomic) HNDSonarFlow *rootFlow;

@end

@implementation HNDAppDelegate

- (UIWindow *)window {
  if (!_window) {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
  }
  return _window;
}

- (HNDSonarFlow *)rootFlow {
  if (!_rootFlow) {
    _rootFlow = [[HNDSonarFlow alloc] init];
  }
  return _rootFlow;
}

#pragma mark - Protocols
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window.rootViewController = [self.rootFlow initialViewController];
  return YES;
}

@end