#import "HNDStationDetailTableViewCell.h"

#import "HNDLabel.h"
#import "HNDStation.h"

static NSUInteger const kStandardPadding = 16;

@interface HNDStationDetailTableViewCell()
@property(nonatomic) UILabel *subwayLinesLabel;
@property(nonatomic) UILabel *accessibleLinesLabel;
@property(nonatomic) UILabel *adaLabel;
@end

@implementation HNDStationDetailTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self.contentView addSubview:self.subwayLinesLabel];
    [self.contentView addSubview:self.accessibleLinesLabel];
    [self.contentView addSubview:self.adaLabel];
    [self autolayoutSubviews];
  }
  return self;
}

- (UILabel *)subwayLinesLabel {
  if (!_subwayLinesLabel) {
    _subwayLinesLabel = [[HNDLabel alloc] init];
  }
  return _subwayLinesLabel;
}

- (UILabel *)accessibleLinesLabel {
  if (!_accessibleLinesLabel) {
    _accessibleLinesLabel = [[HNDLabel alloc] init];
  }
  return _accessibleLinesLabel;
}

- (UILabel *)adaLabel {
  if (!_adaLabel) {
    _adaLabel = [[HNDLabel alloc] init];;
  }
  return _adaLabel;
}

- (void)setStation:(HNDStation *)station {
  _station = station;
  self.subwayLinesLabel.text = station.subwayLines;
  self.accessibleLinesLabel.text = station.accessibleLines;
  self.adaLabel.text = station.adaText;
}

#pragma mark - Private
#pragma mark Autolayout

- (void)autolayoutSubviews {
  HNDLabel *subwayLinesTitle = [[[HNDLabel alloc] init] typeBold];
  subwayLinesTitle.text = @"Subway Lines:";
  HNDLabel *accessibleLinesTitle = [[[HNDLabel alloc] init] typeBold];
  accessibleLinesTitle.text = @"Accessible Lines:";
  HNDLabel *adaTitle = [[[HNDLabel alloc] init] typeBold];
  adaTitle.text = @"ADA:";

  self.subwayLinesLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.accessibleLinesLabel.translatesAutoresizingMaskIntoConstraints  = NO;
  self.adaLabel.translatesAutoresizingMaskIntoConstraints = NO;
  subwayLinesTitle.translatesAutoresizingMaskIntoConstraints = NO;
  accessibleLinesTitle.translatesAutoresizingMaskIntoConstraints = NO;
  adaTitle.translatesAutoresizingMaskIntoConstraints = NO;

  [self.contentView addSubview:subwayLinesTitle];
  [self.contentView addSubview:accessibleLinesTitle];
  [self.contentView addSubview:adaTitle];

  NSDictionary *views = @{
    @"accessibleLinesTitle": accessibleLinesTitle,
    @"adaTitle": adaTitle,
    @"subwayLinesTitle": subwayLinesTitle,
  };

  NSString *constraint;
  constraint = @"V:|-[subwayLinesTitle][accessibleLinesTitle][adaTitle]-|";
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:constraint
                                                                          options:0
                                                                           metrics:nil
                                                                             views:views]];

  [self layoutTitle:subwayLinesTitle withSubTitle:self.subwayLinesLabel];
  [self layoutTitle:accessibleLinesTitle withSubTitle:self.accessibleLinesLabel];
  [self layoutTitle:adaTitle withSubTitle:self.adaLabel];
}

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
