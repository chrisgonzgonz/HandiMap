#import "HNDButton.h"

#import "HNDStyleKit.h"

@implementation HNDButton

#pragma mark - Overrides

- (instancetype)init {
  if (self = [super init]) {
    [self initialSetup];
  }
  return self;
}

#pragma mark - Public

- (instancetype)invertColors {
  [self setTitleColor:[HNDColor lightColor] forState:UIControlStateNormal];
  return self;
}

- (instancetype)largeButton {
  self.titleLabel.font = [HNDFont titleFont];
  return self;
}

#pragma mark - Private

- (void)initialSetup {
  // TODO: Do this to all views somewhere else?
  self.translatesAutoresizingMaskIntoConstraints = NO;

  self.titleLabel.font = [HNDFont defaultFont];
  [self setTitleColor:[HNDColor mainColor] forState:UIControlStateNormal];
  [self setTitleColor:[HNDColor highlightColor] forState:UIControlStateHighlighted];
}

@end
