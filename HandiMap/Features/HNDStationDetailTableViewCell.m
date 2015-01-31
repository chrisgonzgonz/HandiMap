//
//  HNDStationDetailTableViewCell.m
//  HandiMap
//
//  Created by Chris Gonzales on 1/31/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

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
  NSDictionary *views = @{@"subwayLinesLabel": self.subwayLinesLabel, @"accessibleLinesLabel": self.accessibleLinesLabel, @"adaLabel": self.adaLabel};
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subwayLinesLabel][accessibleLinesLabel][adaLabel]|" options:0 metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subwayLinesLabel]|" options:0 metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[accessibleLinesLabel]|" options:0 metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[adaLabel]|" options:0 metrics:nil views:views]];
}

- (HNDLabel *)subwayLinesLabel {
  if (!_subwayLinesLabel) {
    HNDLabel *subwayLinesLabel = [[HNDLabel alloc] init];
    _subwayLinesLabel = subwayLinesLabel;
    _subwayLinesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_subwayLinesLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
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
    [_accessibleLinesLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
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
  self.subwayLinesLabel.text = station.subwayLines;
  self.accessibleLinesLabel.text = station.accessibleLines;
  self.adaLabel.text = station.ada;
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
