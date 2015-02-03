#import "HNDInfoView.h"

#import "HNDColor.h"

@implementation HNDInfoView

#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [HNDColor lightColor];

  }
  return self;
}

@end
