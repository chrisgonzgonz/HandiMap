#import "HNDMapViewController.h"

#import "HNDSubwayMapView.h"

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

- (void)loadView {
  self.view = [[HNDSubwayMapView alloc] init];
}

@end
