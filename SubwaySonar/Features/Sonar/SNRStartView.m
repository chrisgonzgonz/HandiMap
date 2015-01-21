#import "SNRStartView.h"

#import "SNRColor.h"
#import "SNRLabel.h" // TODO: Create SNRViewsKit for UIKit subclasses.

@interface SNRStartView()
@property(nonatomic) SNRLabel *descriptionLabel;
@end

@implementation SNRStartView

- (SNRLabel *)descriptionLabel {
  if (!_descriptionLabel) {
    _descriptionLabel = [[[[SNRLabel alloc] init] typeTitle] invertTextColor];
    _descriptionLabel.text = @"Are you lost? Find the nearest subway.";
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
    _descriptionLabel.backgroundColor = [SNRColor highlightColor];
    [self addSubview:self.descriptionLabel];
  }
  return _descriptionLabel;
}

- (UIButton *)sonarStart {
  if (!_sonarStart) {
    _sonarStart = [[UIButton alloc] init];
    [_sonarStart setTitle:@"Sonar Me Cap'n" forState:UIControlStateNormal];
    [self addSubview:_sonarStart];
  }
  return _sonarStart;
}

#pragma mark - Overrides

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
  UIButton *sonarStart = self.sonarStart;
  NSDictionary *viewBindings = NSDictionaryOfVariableBindings(descriptionLabel, sonarStart);

  // Horizontal layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|-[descriptionLabel]-|"
      options:NSLayoutFormatAlignAllCenterY
      metrics:nil
      views:viewBindings]];
//  [self addConstraints:[NSLayoutConstraint
//      constraintsWithVisualFormat:@"H:|-[sonarStart]-|"
//      options:NSLayoutFormatAlignAllCenterY
//      metrics:nil
//      views:viewBindings]];

  // Vertical layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|-[descriptionLabel(>=1)]-|"
      options:0
      metrics:nil
      views:viewBindings]];
}

@end
