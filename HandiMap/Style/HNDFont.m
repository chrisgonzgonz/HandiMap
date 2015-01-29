#import "HNDFont.h"

static NSString *const kDefaultFont = @"Avenir-Light";
static NSString *const kDefaultBoldFont = @"Avenir-Medium";

static CGFloat const kDefaultSize = 14.0f;
static CGFloat const kTitleSize = 22.0f;


@implementation HNDFont

+ (UIFont *)defaultFont {
  return [UIFont fontWithName:kDefaultFont size:kDefaultSize];
}

+ (UIFont *)titleFont {
  return [UIFont fontWithName:kDefaultFont size:kTitleSize];
}

+ (UIFont *)largeFont {
  return [UIFont fontWithName:kDefaultBoldFont size:kTitleSize];
}

@end
