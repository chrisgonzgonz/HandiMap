#import <UIKit/UIKit.h>

// TODO: Move these into a category on UIColor.

//RGB color macro
#define UIColorFromHex(rgbValue) [UIColor \
    colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
           green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
            blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromHexWithAlpha(rgbValue,a) [UIColor \
    colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
           green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
            blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface HNDColor : NSObject

/// Background and text colors.
+ (UIColor *)darkColor;
+ (UIColor *)grayColor;
+ (UIColor *)lightColor;

/// Colors used to add emphasis and highlight.
+ (UIColor *)mainColor;
+ (UIColor *)highlightColor;

@end
