#import "HNDAppDelegate.h"

#import "HNDMapFlow.h"

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
  self.window.rootViewController = [[[HNDMapFlow alloc] init] initialViewController];
  return YES;
}

@end
