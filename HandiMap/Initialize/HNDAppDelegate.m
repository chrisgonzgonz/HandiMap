#import "HNDAppDelegate.h"

#import "HNDDataStore.h"
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
  [self preloadData];

  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
  self.window.rootViewController = [self.currentFlow initialViewController];
  return YES;
}

#pragma mark - Private

- (void)preloadData {
  [[HNDDataStore sharedStore] loadStationsWithSuccess:^{
    [[HNDDataStore sharedStore] loadOutagesWithSuccess:^{

    } failure:^{
      NSLog(@"Failed to load outages fuck me");
    }];
  } failure:^{
    NSLog(@"Failed to load stations fuck me");
  }];
}

@end
