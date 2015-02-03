#import "HNDInfoView.h"

#import "ZSPinAnnotation.h"

#import "HNDColor.h"
#import "HNDLabel.h"

@interface HNDInfoView()
@property(nonatomic) UILabel *subTitleLabel;
@property(nonatomic) ZSPinAnnotation *normalPin;
@property(nonatomic) ZSPinAnnotation *warningPin;
@property(nonatomic) ZSPinAnnotation *errorPin;
@property(nonatomic) UILabel *normalDescription;
@property(nonatomic) UILabel *warningDescription;
@property(nonatomic) UILabel *errorDescription;
@end

@implementation HNDInfoView

#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [HNDColor lightColor];

    _subTitleLabel = [[[[HNDLabel alloc] init] typeTitle] alignCenter];
    _normalPin = [[ZSPinAnnotation alloc] initWithAnnotation:nil reuseIdentifier:nil];
    _warningPin = [[ZSPinAnnotation alloc] initWithAnnotation:nil reuseIdentifier:nil];
    _errorPin = [[ZSPinAnnotation alloc] initWithAnnotation:nil reuseIdentifier:nil];
    _normalPin.annotationType = ZSPinAnnotationTypeTag;
    _warningPin.annotationType = ZSPinAnnotationTypeTag;
    _errorPin.annotationType = ZSPinAnnotationTypeTag;
    _normalPin.annotationColor = [HNDColor highlightColor];
    _warningPin.annotationColor = [HNDColor warningColor];
    _errorPin.annotationColor = [HNDColor errorColor];
    _normalPin.contentMode = UIViewContentModeScaleAspectFit;
    _warningPin.contentMode = UIViewContentModeScaleAspectFit;
    _errorPin.contentMode = UIViewContentModeScaleAspectFit;
    _normalDescription = [[[HNDLabel alloc] init] alignCenter];
    _warningDescription = [[[HNDLabel alloc] init] alignCenter];
    _errorDescription = [[[HNDLabel alloc] init] alignCenter];

    [self addSubview:_subTitleLabel];
    [self addSubview:_normalPin];
    [self addSubview:_warningPin];
    [self addSubview:_errorPin];
    [self addSubview:_normalDescription];
    [self addSubview:_warningDescription];
    [self addSubview:_errorDescription];

    [self fillWithText];
    [self autoLayoutViews];
  }
  return self;
}

#pragma mark - Private

- (void)fillWithText {
  _subTitleLabel.text = @"HandiMap is a handy map that helps people with handicap.";
  _normalDescription.text = @"This station is ADA and is operating normally.";
  _warningDescription.text = @"This station is not ADA.";
  _errorDescription.text = @"This station has at least one outage of an ADA equipment.";

  [_subTitleLabel sizeToFit];
  [_normalDescription sizeToFit];
  [_warningDescription sizeToFit];
  [_errorDescription sizeToFit];
}

- (void)applyFullWidthTo:(UIView *)view {
  NSDictionary *viewBindings = NSDictionaryOfVariableBindings(view);
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|"
                                                               options:0
                                                               metrics:nil
                                                                 views:viewBindings]];
}

#pragma AutoLayout

- (void)autoLayoutViews {
  for (UIView *view in self.subviews) {
    view.translatesAutoresizingMaskIntoConstraints = NO;
  }

  NSDictionary *viewBindings = NSDictionaryOfVariableBindings(_subTitleLabel,
                                                              _normalPin,
                                                              _warningPin,
                                                              _errorPin,
                                                              _normalDescription,
                                                              _warningDescription,
                                                              _errorDescription);

  NSString *constraint = @"V:|-(30)-[_subTitleLabel]-[_normalPin(44)]-[_normalDescription]"
      "-[_warningPin(44)]-[_warningDescription]-[_errorPin(44)]-[_errorDescription]";
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:constraint
                                                               options:0
                                                               metrics:nil
                                                                 views:viewBindings]];
  for (UIView *view in self.subviews) {
    [self applyFullWidthTo:view];
  }

}

@end
