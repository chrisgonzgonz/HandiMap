#import "SNRLabel.h"

#import "SNRStyleKit.h"

@implementation SNRLabel

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

- (instancetype)invertTextColor {
  self.textColor = [SNRColor lightColor];
  return self;
}

- (instancetype)typeTitle {
  self.font = [SNRFont titleFont];
  return self;
}

#pragma mark - Private

- (void)initialSetup {
  // TODO: Do this to all views somewhere else?
  self.translatesAutoresizingMaskIntoConstraints = NO;
  
  self.font = [SNRFont defaultFont];
  self.textColor = [SNRColor darkColor];
  self.numberOfLines = 0;
}

@end
