#import "HNDLabel.h"

#import "HNDStyleKit.h"

@implementation HNDLabel

#pragma mark - Overrides

- (instancetype)init {
  if (self = [super init]) {
    [self initialSetup];
  }
  return self;
}

- (void)layoutSubviews {
  self.preferredMaxLayoutWidth = self.bounds.size.width;
  [super layoutSubviews]; // This allows for multiline labels as long as -numberOfLines == 0.
}

#pragma mark - Public
#pragma mark - Alignment

- (instancetype)alignCenter {
  self.textAlignment = NSTextAlignmentCenter;
  return self;
}

- (instancetype)alignRight {
  self.textAlignment = NSTextAlignmentRight;
  return self;
}

#pragma mark - Color

- (instancetype)invertTextColor {
  self.textColor = [HNDColor lightColor];
  return self;
}

#pragma mark - Font

- (instancetype)typeBold {
  self.font = [HNDFont boldFont];
  return self;
}

- (instancetype)typeLargeText {
  self.font = [HNDFont largeFont];
  return self;
}

- (instancetype)typeSubtitle {
  self.font = [HNDFont subtitleFont];
  return self;
}

- (instancetype)typeTitle {
  self.font = [HNDFont titleFont];
  return self;
}

#pragma mark - Private

- (void)initialSetup {  
  self.font = [HNDFont defaultFont];
  self.textColor = [HNDColor darkColor];
  self.numberOfLines = 0;
}

@end
