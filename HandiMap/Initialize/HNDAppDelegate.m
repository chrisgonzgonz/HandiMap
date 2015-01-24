#import "HNDAppDelegate.h"

#import "HNDSonarFlow.h"

@implementation HNDAppDelegate

- (UIWindow *)window {
  if (!_window) {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
  }
  return _window;
}

#pragma mark - Protocols
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window.rootViewController = [[[HNDSonarFlow alloc] init] initialViewController];
  return YES;
}

@end
