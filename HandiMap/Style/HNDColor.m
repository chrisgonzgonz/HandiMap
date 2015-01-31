#import "HNDColor.h"

/// Uses the following theme from Kuler:
/// \link https://color.adobe.com/Quiet-Cry-color-theme-124171/

/// Uses the following theme for error/success
/// \link https://color.adobe.com/Beetle-Bus-goes-Jamba-Juice-color-theme-1435983/

static const CGFloat kEightBitColorRange = 255.0f;

@implementation HNDColor

+ (UIColor *)darkColor {
  return [self rgbWithRed:28 green:29 blue:33];
}

+ (UIColor *)grayColor {
  return [self rgbWithRed:49 green:53 blue:61];
}

+ (UIColor *)lightColor {
  return [self rgbWithRed:238 green:239 blue:247];
}

+ (UIColor *)mainColor {
  return [self rgbWithRed:68 green:88 blue:120];
}

+ (UIColor *)highlightColor {
  return [self rgbWithRed:146 green:205 blue:207];
}

/// Colors used to convey meaning.
+ (UIColor *)errorColor {
  return UIColorFromHex(0xc93c00);
}

+ (UIColor *)successColor {
  return UIColorFromHex(0xbfbb11);
}

+ (UIColor *)warningColor {
  return UIColorFromHex(0xffc200);
}

#pragma mark - Private

// TODO: Make this a category on UIColor.
/// Uses integers and converts them to a CGFloat to make UIKit happy.
+ (UIColor *)rgbWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue {
  return [UIColor colorWithRed:red / kEightBitColorRange
                         green:green / kEightBitColorRange
                          blue:blue / kEightBitColorRange
                         alpha:1];
}

@end
