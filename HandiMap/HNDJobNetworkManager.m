#import "HNDJobNetworkManager.h"

static NSString * const kBaseURL = @"https://subway-access.herokuapp.com";
static NSString * const kTestURL = @"https://api.forecast.io/forecast/a2de94fbad075d965ae224240b90f4c9";

@implementation HNDJobNetworkManager

- (instancetype)init {
  if (self = [super initWithBaseURL:[NSURL URLWithString:kBaseURL]]) {}
  return self;
}

- (void)getStations {
  [self GET:@"/37.8267,-122.423"
      parameters:nil
      success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"JSON: %@ TYPE: %@", responseObject, [responseObject class]);
      }
      failure:nil];
}

- (void)getOutages {}

@end
