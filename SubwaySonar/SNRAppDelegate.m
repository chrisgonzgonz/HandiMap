#import "SNRAppDelegate.h"

#import "SNRColor.h"
#import "SNRSonarFlow.h"

@interface SNRAppDelegate()
// Putting this here for now so that it does not get released. Is there a better way?
// TODO: Create an SNRFlow base class to remove this dependency.
@property(nonatomic) SNRSonarFlow *rootFlow;
@end

@implementation SNRAppDelegate

- (UIWindow *)window {
  if (!_window) {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
  }
  return _window;
}

- (SNRSonarFlow *)rootFlow {
  if (!_rootFlow) {
    _rootFlow = [[SNRSonarFlow alloc] init];
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
