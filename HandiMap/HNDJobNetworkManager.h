#import "AFHTTPSessionManager.h"

@interface HNDJobNetworkManager : AFHTTPSessionManager

// TODO(gonzo): Figure out if we need to pass in lat, long into getStations.
- (void)getStationsWithCompletionBlock:(void(^)(id response))completion;
- (void)getOutagesWithCompletionBlock:(void(^)(id response))completion;

+ (instancetype)sharedManager;

@end
