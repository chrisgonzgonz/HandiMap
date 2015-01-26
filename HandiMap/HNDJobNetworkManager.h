#import "AFHTTPSessionManager.h"

@interface HNDJobNetworkManager : AFHTTPSessionManager

// TODO(gonzo): Figure out if we need to pass in lat, long into getStations.
- (void)getStationsWithCompletionBlock:(void(^)())completion;
- (void)getOutagesWithCompletionBlock:(void(^)())completion;

+ (instancetype)sharedManager;

@end
