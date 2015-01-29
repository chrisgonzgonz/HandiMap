#import "HNDViewController.h"

#import "HNDMapFlow.h"

@interface HNDViewController ()
@property(nonatomic) HNDMapFlow *flow;
@end

@implementation HNDViewController

- (instancetype)initInFlow:(HNDMapFlow *)flow {
  if (self = [super init]) {
    _flow = flow;
  }
  return self;
}

@end
