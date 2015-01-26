#import "AFHTTPSessionManager.h"

@interface HNDJobNetworkManager : AFHTTPSessionManager

// TODO(gonzo): Figure out if we need to pass in lat, long into getStations.
- (void)getStations;
- (void)getOutages;

@end
