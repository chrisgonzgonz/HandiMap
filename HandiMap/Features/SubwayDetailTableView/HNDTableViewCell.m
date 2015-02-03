#import "HNDTableViewCell.h"

static NSUInteger const kStandardPadding = 16;

@implementation HNDTableViewCell

- (void)layoutTitle:(UIView *)title withSubTitle:(UIView *)subtitle {
  NSString *constraint = [NSString stringWithFormat:
      @"H:|-(%lu)-[title]-[subtitle]-(>=%lu)-|", kStandardPadding, kStandardPadding];
  [self.contentView addConstraints:
      [NSLayoutConstraint constraintsWithVisualFormat:constraint
                                              options:NSLayoutFormatAlignAllTop
                                              metrics:nil
                                                views:NSDictionaryOfVariableBindings(title,
                                                                                     subtitle)]];
}

@end
