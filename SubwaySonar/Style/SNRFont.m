#import "SNRFont.h"

static NSString *const kDefaultFont = @"Avenir-Light";
static NSString *const kDefaultBoldFont = @"Avenir-Medium";

@implementation SNRFont

+ (UIFont *)defaultFontWithSize:(CGFloat)size {
  return [UIFont fontWithName:kDefaultFont size:size];
}

+ (UIFont *)defaultBoldFontWithSize:(CGFloat)size {
  return [UIFont fontWithName:kDefaultBoldFont size:size];
}

@end
