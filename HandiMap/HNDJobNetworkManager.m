#import "HNDJobNetworkManager.h"

static NSString * const kBaseURL = @"https://handimap.herokuapp.com/";
static NSString * const kTestURL = @"https://api.forecast.io/forecast/a2de94fbad075d965ae224240b90f4c9/";

@implementation HNDJobNetworkManager

+ (instancetype)sharedManager {
  static HNDJobNetworkManager *_sharedManager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedManager = [[HNDJobNetworkManager alloc] init];
  });
  
  return _sharedManager;
}

- (instancetype)init {
  if (self = [super initWithBaseURL:[NSURL URLWithString:kBaseURL]]) {}
  return self;
}

- (void)getStationsWithCompletionBlock:(void (^)())completion {
  
  [self GET:@"stations" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    NSLog(@"JSON: %@ TYPE: %@", responseObject, [responseObject class]);
    if (completion) {
      completion();
    }
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    NSLog(@"%@ Error: %@", task.response, error.localizedDescription);
  }];
  
}

- (void)getOutagesWithCompletionBlock:(void (^)())completion {
  
  [self GET:@"outages" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    NSLog(@"JSON: %@ TYPE: %@", responseObject, [responseObject class]);
    if (completion) {
      completion();
    }
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    NSLog(@"%@ Error: %@", task.response, error.localizedDescription);
  }];
}

@end
