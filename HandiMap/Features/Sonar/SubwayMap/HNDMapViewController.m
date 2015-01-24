#import "HNDMapViewController.h"

@interface HNDMapViewController ()

@property(nonatomic) HNDSonarFlow *flow;

@end

@implementation HNDMapViewController

- (instancetype)initInFlow:(HNDSonarFlow *)flow {
  if (self = [super init]) {
    _flow = flow;
  }
  return self;
}

@end
