#import "AFHTTPSessionManager.h"

@interface HNDJobNetworkManager : AFHTTPSessionManager

- (void)getStationsWithCompletionBlock:(void(^)())completion;
- (void)getOutagesWithCompletionBlock:(void(^)())completion;

+ (instancetype)sharedManager;
@end
