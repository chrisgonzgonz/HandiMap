#import "SNRLabel.h"

#import "SNRStyle.h"

@implementation SNRLabel

#pragma mark - Overrides

- (instancetype)init {
  if (self = [super init]) {
    [self initialSetup];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self initialSetup];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self initialSetup];
  }
  return self;
}

#pragma mark - Public

- (instancetype)invertTextColor {
  self.textColor = [SNRColor lightColor];
  return self;
}

#pragma mark - Private

- (void)initialSetup {
  // TODO: Do this to all views somewhere else?
  self.translatesAutoresizingMaskIntoConstraints = NO;
  
  self.font = [SNRFont defaultFontWithSize:self.font.pointSize];
  self.textColor = [SNRColor darkColor];
}

@end
