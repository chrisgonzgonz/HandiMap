#import "SNRAppDelegate.h"

#import "SNRColor.h"

@implementation SNRAppDelegate

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
  tmpViewController.view.backgroundColor = [SNRColor mainColor];
  self.window.rootViewController = tmpViewController;
  return YES;
}

@end
