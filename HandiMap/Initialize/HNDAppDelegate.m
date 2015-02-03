#import "HNDAppDelegate.h"

#import <HockeySDK.h>

#import "HNDDataStore.h"
#import "HNDMapFlow.h"
#import <SVProgressHUD/SVProgressHUD.h>

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
  self.window.rootViewController = [self.currentFlow initialViewController];
  return YES;
}

#pragma mark - Private

- (void)preloadData {
  NSLog(@"daaaaaaaaaaang");
  [[HNDDataStore sharedStore] loadStationsWithSuccess:^{
    [[HNDDataStore sharedStore] loadOutagesWithSuccess:^{
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [SVProgressHUD dismiss];
      }];
    } failure:^{ NSLog(@"Failed to load outages fuck me"); }];
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [SVProgressHUD dismiss];
      }];
  } failure:^{ NSLog(@"Failed to load stations fuck me"); }];
  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    [SVProgressHUD dismiss];
  }];
}

- (void)startHockey {
  [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:kHockeyId];
  [[BITHockeyManager sharedHockeyManager] startManager];
  [[BITHockeyManager sharedHockeyManager].authenticator authenticateInstallation];
}

@end
