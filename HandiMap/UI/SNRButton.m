#import "SNRButton.h"

#import "SNRStyleKit.h"

@implementation SNRButton

#pragma mark - Overrides

- (instancetype)init {
  if (self = [super init]) {
    [self initialSetup];
  }
  return self;
}

#pragma mark - Public

- (instancetype)invertColors {
  [self setTitleColor:[SNRColor lightColor] forState:UIControlStateNormal];
  return self;
}

- (instancetype)largeButton {
  self.titleLabel.font = [SNRFont titleFont];
  return self;
}

#pragma mark - Private

- (void)initialSetup {
  // TODO: Do this to all views somewhere else?
  self.translatesAutoresizingMaskIntoConstraints = NO;

  self.titleLabel.font = [SNRFont defaultFont];
  [self setTitleColor:[SNRColor mainColor] forState:UIControlStateNormal];
  [self setTitleColor:[SNRColor highlightColor] forState:UIControlStateHighlighted];
}

@end
