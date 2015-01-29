#import "HNDViewController.h"

#import "HNDMapFlow.h"

@implementation HNDViewController

- (instancetype)initInFlow:(HNDMapFlow *)flow {
  if (self = [super init]) {
    _flow = flow;
  }
  return self;
}

@end
