#import "SNRStartView.h"

#import "SNRColor.h"
#import "SNRLabel.h" // TODO: Create SNRViewsKit for UIKit subclasses.

@interface SNRStartView()

@property(nonatomic) SNRLabel *descriptionLabel;

@end

@implementation SNRStartView

- (SNRLabel *)descriptionLabel {
  if (!_descriptionLabel) {
    _descriptionLabel = [[[SNRLabel alloc] init] invertTextColor];
    _descriptionLabel.text = @"Are you lost? Find the nearest subway.";
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.descriptionLabel];
  }
  return _descriptionLabel;
}

#pragma mark - Overrides

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

#pragma mark - Private

- (void)initialSetup {
  self.backgroundColor = [SNRColor mainColor];

  [self autolayoutViews];
}

- (void)autolayoutViews {
  SNRLabel *descriptionLabel = self.descriptionLabel;
  NSDictionary *viewBindings = NSDictionaryOfVariableBindings(descriptionLabel);

  // Horizontal layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|-[descriptionLabel]-|"
      options:NSLayoutFormatAlignAllCenterY
      metrics:nil
      views:viewBindings]];

  // Vertical layout
//  [self addConstraints:[NSLayoutConstraint
//      constraintsWithVisualFormat:@"V:|-[descriptionLabel]-|"
//      options:0
//      metrics:nil
//      views:viewBindings]];
}

@end
