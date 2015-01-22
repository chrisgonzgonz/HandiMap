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
    [self addSubview:self.descriptionLabel];
  }
  return _descriptionLabel;
}

- (UIButton *)sonarStartButton {
  if (!_sonarStartButton) {
    _sonarStartButton = [[UIButton alloc] init];
    _sonarStartButton.translatesAutoresizingMaskIntoConstraints = NO; // TODO: Create SNRButton.
    [_sonarStartButton setTitle:@"Sonar Me Cap'n" forState:UIControlStateNormal];
    [_sonarStartButton setTitleColor:[SNRColor highlightColor] forState:UIControlStateHighlighted];
    [self addSubview:_sonarStartButton];
  }
  return _sonarStartButton;
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
  UIButton *sonarStartButton = self.sonarStartButton;
  NSDictionary *viewBindings = NSDictionaryOfVariableBindings(descriptionLabel,
                                                              sonarStartButton);

  // Horizontal layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|-[descriptionLabel]-|"
      options:NSLayoutFormatAlignAllCenterY
      metrics:nil
      views:viewBindings]];
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|-[sonarStartButton]-|"
      options:NSLayoutFormatAlignAllCenterY
      metrics:nil
      views:viewBindings]];

  // Vertical layout
  NSString *verticalLayout = @"V:|-[descriptionLabel(sonarStartButton)]-[sonarStartButton(>=1)]-|";
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:verticalLayout
      options:0
      metrics:nil
      views:viewBindings]];
}

@end
