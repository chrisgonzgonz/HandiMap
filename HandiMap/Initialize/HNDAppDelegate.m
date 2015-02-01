#import "HNDAppDelegate.h"

#import <HockeySDK.h>

#import "HNDDataStore.h"
#import "HNDMapFlow.h"

// TODO: This should not be checked in...
static NSString *const kHockeyId = @"f7b9bbd12bb0d75390f8dd8894f8f70a";

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
  [self startHockey];
  [self preloadData];
  [self setupDefaults];
  self.window.rootViewController = [self.currentFlow initialViewController];
  return YES;
}

#pragma mark - Private

- (void)setupDefaults {
  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)preloadData {
  [[HNDDataStore sharedStore] loadStationsWithSuccess:^{
    [[HNDDataStore sharedStore] loadOutagesWithSuccess:^{
    } failure:^{ NSLog(@"Failed to load outages fuck me"); }];
  } failure:^{ NSLog(@"Failed to load stations fuck me"); }];
}

- (void)startHockey {
  [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:kHockeyId];
  [[BITHockeyManager sharedHockeyManager] startManager];
  [[BITHockeyManager sharedHockeyManager].authenticator authenticateInstallation];
}

@end
