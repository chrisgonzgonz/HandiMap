#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

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
  UIViewController *tmpViewController = [[UIViewController alloc] init];
  tmpViewController.view.backgroundColor = [UIColor greenColor];
  self.window.rootViewController = tmpViewController;
  return YES;
}

@end
