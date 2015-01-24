#import "HNDStartView.h"

#import "HNDStyleKit.h"
#import "HNDViewsKit.h"

@interface HNDStartView()
@property(nonatomic) HNDLabel *descriptionLabel;
@end

@implementation HNDStartView

- (HNDLabel *)descriptionLabel {
  if (!_descriptionLabel) {
    _descriptionLabel = [[[[HNDLabel alloc] init] typeTitle] invertTextColor];
    _descriptionLabel.text = @"Are you lost? Find the nearest subway.";
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
    _descriptionLabel.backgroundColor = [HNDColor highlightColor];
    [self addSubview:self.descriptionLabel];
  }
  return _descriptionLabel;
}

- (UIButton *)sonarStartButton {
  if (!_sonarStartButton) {
    _sonarStartButton = [[[[HNDButton alloc] init] largeButton] invertColors];
    [_sonarStartButton setTitle:@"Sonar Me Cap'n" forState:UIControlStateNormal];
    _sonarStartButton.backgroundColor = [HNDColor grayColor];
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
  self.backgroundColor = [HNDColor mainColor];
  [self autolayoutViews];
}

- (void)autolayoutViews {
  HNDLabel *descriptionLabel = self.descriptionLabel;
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
