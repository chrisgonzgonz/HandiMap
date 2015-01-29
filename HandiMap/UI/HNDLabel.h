#import <UIKit/UIKit.h>

@interface HNDLabel : UILabel

- (instancetype)invertTextColor;

// TODO: This should be a subclass (eg: HNDTitleLabel).
- (instancetype)typeTitle;

- (instancetype)typeLargeText;

@end
