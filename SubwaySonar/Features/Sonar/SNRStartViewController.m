#import "SNRStartViewController.h"

#import "SNRSonarFlow.h"
#import "SNRStartView.h"

@interface SNRStartViewController()

// TODO: Create SNRViewController base class. It should have a weak reference to a generic flow.
@property(nonatomic, weak) SNRSonarFlow *flow;

@property(nonatomic) SNRStartView *view;

@end

@implementation SNRStartViewController

#pragma mark - Overrides

- (instancetype)initInFlow:(SNRSonarFlow *)flow {
  if (self = [super init]) {
    self.flow = flow;
  }
  return self;
}

- (void)loadView {
  self.view = [[SNRStartView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self bindViews];
}

#pragma mark - Target Actions

- (void)startSonar:(UIButton *)sender {
  NSLog(@"butter.");
}

#pragma mark - Private

- (void)bindViews {
  [self.view.sonarStartButton addTarget:self
                                 action:@selector(startSonar:)
                       forControlEvents:UIControlEventTouchUpInside];
}

@end
