#import "SNRLabel.h"

#import "SNRStyle.h"

@implementation SNRLabel

#pragma mark - Overrides

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {

  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {

  }
  return self;
}

#pragma mark - Public

- (void)invertTextColor {
  self.textColor = [SNRColor lightColor];
}

#pragma mark - Private

- (void)initialSetup {
  self.font = [SNRFont defaultFontWithSize:self.font.pointSize];
  self.textColor = [SNRColor darkColor];
}

@end
