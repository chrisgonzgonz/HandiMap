#import "AFHTTPSessionManager.h"

@interface HNDJobNetworkManager : AFHTTPSessionManager

- (void)getStations;
- (void)getOutages;

@end
