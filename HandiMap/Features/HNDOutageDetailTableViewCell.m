//
//  HNDOutageDetailTableViewCell.m
//  HandiMap
//
//  Created by Chris Gonzales on 1/31/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import "HNDOutageDetailTableViewCell.h"

#import "HNDLabel.h"
#import "HNDManagedOutage.h"
@interface HNDOutageDetailTableViewCell ()
@property (weak, nonatomic) HNDLabel *servingLabel;
@property (weak, nonatomic) HNDLabel *equipmentTypeLabel;
@property (weak, nonatomic) HNDLabel *routesAffectedLabel;
@property (weak, nonatomic) HNDLabel *reasonLabel;
@property (weak, nonatomic) HNDLabel *outageStartDateLabel;
@property (weak, nonatomic) HNDLabel *estimatedReturnOfServiceLabel;
@property (weak, nonatomic) HNDLabel *adaLabel;
@property (weak, nonatomic) HNDLabel *updatedAtLabel;
@end

@implementation HNDOutageDetailTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self autolayoutSubviews];
  }
  return self;
}

- (void)autolayoutSubviews {
  HNDLabel *servingTitle = [[HNDLabel alloc] init];
  servingTitle.text = @"Serving:";
  HNDLabel *equipmentTypeTitle = [[HNDLabel alloc] init];
  equipmentTypeTitle.text = @"Equipment Type:";
  HNDLabel *routesAffectedTitle = [[HNDLabel alloc] init];
  routesAffectedTitle.text = @"Routes Affected:";
  HNDLabel *reasonTitle = [[HNDLabel alloc] init];
  reasonTitle.text = @"Reason:";
  HNDLabel *outageStartTitle = [[HNDLabel alloc] init];
  outageStartTitle.text = @"Outage Start:";
  HNDLabel *estimatedReturnTitle = [[HNDLabel alloc] init];
  estimatedReturnTitle.text = @"Estimated Return to Service:";
  HNDLabel *adaTitle = [[HNDLabel alloc] init];
  adaTitle.text = @"ADA:";
  HNDLabel *updatedAtTitle = [[HNDLabel alloc] init];
  updatedAtTitle.text = @"Updated At:";
  servingTitle.translatesAutoresizingMaskIntoConstraints = NO;
  equipmentTypeTitle.translatesAutoresizingMaskIntoConstraints = NO;
  routesAffectedTitle.translatesAutoresizingMaskIntoConstraints = NO;
  reasonTitle.translatesAutoresizingMaskIntoConstraints = NO;
  outageStartTitle.translatesAutoresizingMaskIntoConstraints = NO;
  estimatedReturnTitle.translatesAutoresizingMaskIntoConstraints = NO;
  adaTitle.translatesAutoresizingMaskIntoConstraints = NO;
  updatedAtTitle.translatesAutoresizingMaskIntoConstraints = NO;
  
  [self.contentView addSubview:servingTitle];
  [self.contentView addSubview:equipmentTypeTitle];
  [self.contentView addSubview:routesAffectedTitle];
  [self.contentView addSubview:reasonTitle];
  [self.contentView addSubview:outageStartTitle];
  [self.contentView addSubview:estimatedReturnTitle];
  [self.contentView addSubview:adaTitle];
  [self.contentView addSubview:updatedAtTitle];
  
  NSDictionary *titleViews = NSDictionaryOfVariableBindings(servingTitle, equipmentTypeTitle, routesAffectedTitle, reasonTitle, outageStartTitle, estimatedReturnTitle, adaTitle, updatedAtTitle);
  NSMutableDictionary *views = [NSMutableDictionary dictionaryWithDictionary:@{@"servingLabel": self.servingLabel, @"equipmentTypeLabel": self.equipmentTypeLabel, @"routesAffectedLabel": self.routesAffectedLabel, @"reasonLabel": self.reasonLabel, @"outageStartDateLabel": self.outageStartDateLabel, @"estimatedReturnOfServiceLabel": self.estimatedReturnOfServiceLabel, @"adaLabel": self.adaLabel, @"updatedAtLabel": self.updatedAtLabel}];
  [views addEntriesFromDictionary:titleViews];
  
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[servingLabel][equipmentTypeLabel][routesAffectedLabel][reasonLabel][outageStartDateLabel][estimatedReturnOfServiceLabel][adaLabel][updatedAtLabel]|" options:0 metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[servingTitle][servingLabel]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[equipmentTypeTitle][equipmentTypeLabel]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[routesAffectedLabel][routesAffectedTitle]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[reasonLabel][reasonTitle]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[outageStartDateLabel][outageStartTitle]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[estimatedReturnOfServiceLabel][estimatedReturnTitle]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[adaLabel][adaTitle]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[updatedAtLabel][updatedAtTitle]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
  
}

- (HNDLabel *)servingLabel {
  if (!_servingLabel) {
    HNDLabel *servingLabel = [[HNDLabel alloc] init];
    _servingLabel = servingLabel;
    _servingLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_servingLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _servingLabel.preferredMaxLayoutWidth = self.bounds.size.width;
    [self.contentView addSubview:_servingLabel];
  }
  return _servingLabel;
}

- (HNDLabel *)equipmentTypeLabel {
  if (!_equipmentTypeLabel) {
    HNDLabel *equipmentTypeLabel = [[HNDLabel alloc] init];
    _equipmentTypeLabel = equipmentTypeLabel;
    _equipmentTypeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_equipmentTypeLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _equipmentTypeLabel.preferredMaxLayoutWidth = self.bounds.size.width;
    [self.contentView addSubview:_equipmentTypeLabel];
  }
  return _equipmentTypeLabel;
}

- (HNDLabel *)routesAffectedLabel {
  if (!_routesAffectedLabel) {
    HNDLabel *routesAffectedLabel = [[HNDLabel alloc] init];
    _routesAffectedLabel = routesAffectedLabel;
    _routesAffectedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_routesAffectedLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _routesAffectedLabel.preferredMaxLayoutWidth = self.bounds.size.width;
    [self.contentView addSubview:_routesAffectedLabel];
  }
  return _routesAffectedLabel;
}


- (HNDLabel *)reasonLabel {
  if (!_reasonLabel) {
    HNDLabel *reasonLabel = [[HNDLabel alloc] init];
    _reasonLabel = reasonLabel;
    _reasonLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_reasonLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _reasonLabel.preferredMaxLayoutWidth = self.bounds.size.width;
    [self.contentView addSubview:_reasonLabel];
  }
  return _reasonLabel;
}

- (HNDLabel *)outageStartDateLabel {
  if (!_outageStartDateLabel) {
    HNDLabel *outageStartLabel = [[HNDLabel alloc] init];
    _outageStartDateLabel = outageStartLabel;
    _outageStartDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_outageStartDateLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _outageStartDateLabel.preferredMaxLayoutWidth = self.bounds.size.width;
    [self.contentView addSubview:_outageStartDateLabel];
  }
  return _outageStartDateLabel;
}

- (HNDLabel *)estimatedReturnOfServiceLabel {
  if (!_estimatedReturnOfServiceLabel) {
    HNDLabel *estimatedReturnOfService = [[HNDLabel alloc] init];
    _estimatedReturnOfServiceLabel = estimatedReturnOfService;
    _estimatedReturnOfServiceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_estimatedReturnOfServiceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _estimatedReturnOfServiceLabel.preferredMaxLayoutWidth = self.bounds.size.width;
    [self.contentView addSubview:_estimatedReturnOfServiceLabel];
  }
  return _estimatedReturnOfServiceLabel;
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

- (HNDLabel *)updatedAtLabel {
  if (!_updatedAtLabel) {
    HNDLabel *updatedAtLabel = [[HNDLabel alloc] init];
    _updatedAtLabel = updatedAtLabel;
    _updatedAtLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_updatedAtLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _updatedAtLabel.preferredMaxLayoutWidth = self.bounds.size.width;
    [self.contentView addSubview:_updatedAtLabel];
  }
  return _updatedAtLabel;
}

- (void)setOutage:(HNDManagedOutage *)outage {
  _outage = outage;
  self.servingLabel.text = outage.serving;
  self.equipmentTypeLabel.text = outage.equipmentType;
  self.routesAffectedLabel.text = [[outage.routesAffected valueForKey:@"description"] componentsJoinedByString:@", "];
  self.reasonLabel.text = outage.reason;
  self.outageStartDateLabel.text = [[self dateFormatter] stringFromDate: outage.outageStartDate];
  self.estimatedReturnOfServiceLabel.text = [[self dateFormatter] stringFromDate: outage.estimatedReturnOfService];
  self.adaLabel.text = outage.ada ? @"YES" : @"NO";
  self.updatedAtLabel.text = [[self dateFormatter] stringFromDate: outage.updatedAt];
}

- (NSDateFormatter *)dateFormatter {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"MM/dd/yyyy at hh:mm"];
  return formatter;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
  
    // Configure the view for the selected state
}

@end
