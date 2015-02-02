#import "HNDStationDetailTableViewCell.h"

#import "HNDLabel.h"
#import "HNDStation.h"

@interface HNDStationDetailTableViewCell ()
@property (nonatomic, weak) HNDLabel *subwayLinesLabel;
@property (nonatomic, weak) HNDLabel *accessibleLinesLabel;
@property (nonatomic, weak) HNDLabel *adaLabel;
@end

@implementation HNDStationDetailTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self autolayoutSubviews];
  }
  return self;
}

- (void)autolayoutSubviews {
  HNDLabel *subwayLinesTitle = [[[HNDLabel alloc] init] typeBold];
  subwayLinesTitle.text = @"Subway Lines:";
  HNDLabel *accessibleLinesTitle = [[[HNDLabel alloc] init] typeBold];
  accessibleLinesTitle.text = @"Accessible Lines:";
  HNDLabel *adaTitle = [[[HNDLabel alloc] init] typeBold];
  adaTitle.text = @"ADA:";
  subwayLinesTitle.translatesAutoresizingMaskIntoConstraints = NO;
  accessibleLinesTitle.translatesAutoresizingMaskIntoConstraints = NO;
  adaTitle.translatesAutoresizingMaskIntoConstraints = NO;
  
  [self.contentView addSubview:subwayLinesTitle];
  [self.contentView addSubview:accessibleLinesTitle];
  [self.contentView addSubview:adaTitle];
  
  NSDictionary *views = @{
    @"accessibleLinesLabel": self.accessibleLinesLabel,
    @"accessibleLinesTitle": accessibleLinesTitle,
    @"adaLabel": self.adaLabel,
    @"adaTitle": adaTitle,
    @"subwayLinesLabel": self.subwayLinesLabel,
    @"subwayLinesTitle": subwayLinesTitle,
  };

  NSString *constraint;
  constraint = @"V:|[subwayLinesLabel][accessibleLinesLabel][adaLabel]|";
  [self.contentView addConstraints:
      [NSLayoutConstraint constraintsWithVisualFormat:constraint
                                              options:0
                                              metrics:nil
                                                views:views]];

  constraint = @"H:|-(15)-[subwayLinesTitle]-[subwayLinesLabel]-(>=15)-|";
  [self.contentView addConstraints:
      [NSLayoutConstraint constraintsWithVisualFormat:constraint
                                              options:NSLayoutFormatAlignAllTop
                                              metrics:nil
                                                views:views]];
  constraint = @"H:|-(15)-[accessibleLinesTitle]-[accessibleLinesLabel]-(>=15)-|";
  [self.contentView addConstraints:
      [NSLayoutConstraint constraintsWithVisualFormat:constraint
                                              options:NSLayoutFormatAlignAllTop
                                              metrics:nil
                                                views:views]];
  constraint =  @"H:|-(15)-[adaTitle]-[adaLabel]-(>=15)-|";
  [self.contentView addConstraints:
      [NSLayoutConstraint constraintsWithVisualFormat:constraint
                                              options:NSLayoutFormatAlignAllTop
                                              metrics:nil
                                                views:views]];
  [self.contentView addConstraint:
      [NSLayoutConstraint constraintWithItem:adaTitle
                                   attribute:NSLayoutAttributeHeight
                                   relatedBy:NSLayoutRelationGreaterThanOrEqual
                                      toItem:self.adaLabel
                                   attribute:NSLayoutAttributeHeight
                                  multiplier:1.0
                                    constant:0]];
}

- (HNDLabel *)subwayLinesLabel {
  if (!_subwayLinesLabel) {
    HNDLabel *subwayLinesLabel = [[HNDLabel alloc] init];
    _subwayLinesLabel = subwayLinesLabel;
    _subwayLinesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_subwayLinesLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                       forAxis:UILayoutConstraintAxisVertical];
    _subwayLinesLabel.preferredMaxLayoutWidth = self.bounds.size.width;
    [self.contentView addSubview:_subwayLinesLabel];
  }
  return _subwayLinesLabel;
}

- (HNDLabel *)accessibleLinesLabel {
  if (!_accessibleLinesLabel) {
    HNDLabel *accessibleLinesLabel = [[HNDLabel alloc] init];
    _accessibleLinesLabel = accessibleLinesLabel;
    _accessibleLinesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_accessibleLinesLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                           forAxis:UILayoutConstraintAxisVertical];
    _accessibleLinesLabel.preferredMaxLayoutWidth = self.bounds.size.width;
    [self.contentView addSubview:_accessibleLinesLabel];
  }
  return _accessibleLinesLabel;
}

- (HNDLabel *)adaLabel {
  if (!_adaLabel) {
    HNDLabel *adaLabel = [[HNDLabel alloc] init];
    _adaLabel = adaLabel;
    _adaLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_adaLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _adaLabel.preferredMaxLayoutWidth = self.bounds.size.width;
    [self.contentView addSubview:_adaLabel];
  }
  return _adaLabel;
}

- (void)setStation:(HNDStation *)station {
  _station = station;
  self.subwayLinesLabel.text = station.subwayLines;
  self.accessibleLinesLabel.text = station.accessibleLines;
  self.adaLabel.text = station.adaText;
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end