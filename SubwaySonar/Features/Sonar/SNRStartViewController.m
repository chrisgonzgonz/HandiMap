#import "SNRStartViewController.h"

#import "SNRColor.h"

@implementation SNRStartViewController

#pragma mark - Overrides

- (void)loadView {
  self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.view.backgroundColor = [SNRColor mainColor];
}

@end
