#import "HNDStartViewController.h"

#import "HNDSonarFlow.h"
#import "HNDStartView.h"

@interface HNDStartViewController()

// TODO: Create HNDViewController base class. It should have a weak reference to a generic flow.
@property(nonatomic, weak) HNDSonarFlow *flow;

@property(nonatomic) HNDStartView *view;

@end

@implementation HNDStartViewController

#pragma mark - Overrides

- (instancetype)initInFlow:(HNDSonarFlow *)flow {
  if (self = [super init]) {
    self.flow = flow;
  }
  return self;
}

- (void)loadView {
  self.view = [[HNDStartView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self bindViews];
}

#pragma mark - Target Actions

- (void)startSonar:(UIButton *)sender {
  [self.flow presentNext:self];
}

#pragma mark - Private

- (void)bindViews {
  [self.view.sonarStartButton addTarget:self
                                 action:@selector(startSonar:)
                       forControlEvents:UIControlEventTouchUpInside];
}

@end
