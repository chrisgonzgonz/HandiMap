#import "SNRStartViewController.h"

#import "SNRStartView.h"

@implementation SNRStartViewController

#pragma mark - Overrides

- (void)loadView {
  self.view = [[SNRStartView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

@end
