#import <UIKit/UIKit.h>

@interface HNDLabel : UILabel

// Aignment
- (instancetype)alignCenter;
- (instancetype)alignRight;

// Color
- (instancetype)invertTextColor;

// Font
- (instancetype)typeBold;
- (instancetype)typeLargeText;
- (instancetype)typeSubtitle;
- (instancetype)typeTitle;

@end
