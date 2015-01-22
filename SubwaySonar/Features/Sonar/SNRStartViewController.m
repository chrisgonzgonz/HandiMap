#import "SNRStartViewController.h"

#import "SNRStartView.h"

@interface SNRStartViewController()
@property(nonatomic) SNRStartView *view;
@end

@implementation SNRStartViewController

#pragma mark - Overrides

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
