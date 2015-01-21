#import "SNRAppDelegate.h"

// TODO: Delete these dependencies and create a flow object to handle UIViewControllers.
#import "SNRColor.h"
#import "SNRStartViewController.h"

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
  UIViewController *tmpViewController = [[SNRStartViewController alloc] init];
  self.window.rootViewController = tmpViewController;
  return YES;
}

@end
