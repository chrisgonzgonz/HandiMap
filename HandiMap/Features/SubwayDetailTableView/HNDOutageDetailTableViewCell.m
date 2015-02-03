#import "HNDOutageDetailTableViewCell.h"

#import "HNDLabel.h"
#import "HNDManagedOutage.h" // WOAH! This should not be here...The controller do the binding.
#import "HNDTableViewCell+Protected.h"

@interface HNDOutageDetailTableViewCell ()
@property (nonatomic) HNDLabel *servingLabel;
@property (nonatomic) HNDLabel *equipmentTypeLabel;
@property (nonatomic) HNDLabel *routesAffectedLabel;
@property (nonatomic) HNDLabel *reasonLabel;
@property (nonatomic) HNDLabel *outageStartDateLabel;
@property (nonatomic) HNDLabel *estimatedReturnOfServiceLabel;
@property (nonatomic) HNDLabel *adaLabel;
@property (nonatomic) HNDLabel *updatedAtLabel;
@end

@implementation HNDOutageDetailTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self autolayoutSubviews];
  }
  return self;
}

- (HNDLabel *)servingLabel {
  if (!_servingLabel) {
    HNDLabel *servingLabel = [[HNDLabel alloc] init];
    _servingLabel = servingLabel;
    _servingLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_servingLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
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
    [self.contentView addSubview:_updatedAtLabel];
  }
  return _updatedAtLabel;
}

// TODO: This needs a view model like station.
- (void)setOutage:(HNDManagedOutage *)outage {
  _outage = outage;
  self.servingLabel.text = outage.serving.lowercaseString;
  self.equipmentTypeLabel.text =
      [outage.equipmentType isEqualToString:@"EL"] ? @"elevator" : @"escalator";
  self.routesAffectedLabel.text =
      [[outage.routesAffected valueForKey:@"description"] componentsJoinedByString:@", "];
  self.reasonLabel.text = outage.reason.lowercaseString;
  self.outageStartDateLabel.text = [[self dateFormatter] stringFromDate:outage.outageStartDate];
  self.estimatedReturnOfServiceLabel.text =
      [[self dateFormatter] stringFromDate:outage.estimatedReturnOfService];
  self.adaLabel.text = outage.ada ? @"Yes" : @"No";
  self.updatedAtLabel.text = [[self dateFormatter] stringFromDate:outage.updatedAt];

  [self.servingLabel sizeToFit];
  [self.equipmentTypeLabel sizeToFit];
  [self.routesAffectedLabel sizeToFit];
  [self.reasonLabel sizeToFit];
  [self.outageStartDateLabel sizeToFit];
  [self.servingLabel sizeToFit];
  [self.estimatedReturnOfServiceLabel sizeToFit];
  [self.adaLabel sizeToFit];
  [self.updatedAtLabel sizeToFit];
  [self layoutIfNeeded];
}

#pragma mark - Private

- (NSDateFormatter *)dateFormatter {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateFormat = @"MMM dd, yyyy',' h:mma";
  return formatter;
}

#pragma mark Autolayout

- (void)autolayoutSubviews {
  HNDLabel *servingTitle = [[[HNDLabel alloc] init] typeBold];
  servingTitle.text = @"Serving:";
  HNDLabel *equipmentTypeTitle = [[[HNDLabel alloc] init] typeBold];
  equipmentTypeTitle.text = @"Equipment Type:";
  HNDLabel *routesAffectedTitle = [[[HNDLabel alloc] init] typeBold];
  routesAffectedTitle.text = @"Routes Affected:";
  HNDLabel *reasonTitle = [[[HNDLabel alloc] init] typeBold];
  reasonTitle.text = @"Reason:";
  HNDLabel *outageStartTitle = [[[HNDLabel alloc] init] typeBold];
  outageStartTitle.text = @"Outage Start:";
  HNDLabel *estimatedReturnTitle = [[[HNDLabel alloc] init] typeBold];
  estimatedReturnTitle.text = @"Estimated Return:";
  HNDLabel *adaTitle = [[[HNDLabel alloc] init] typeBold];
  adaTitle.text = @"ADA:";
  HNDLabel *updatedAtTitle = [[[HNDLabel alloc] init] typeBold];
  updatedAtTitle.text = @"Updated At:";

  servingTitle.translatesAutoresizingMaskIntoConstraints = NO;
  equipmentTypeTitle.translatesAutoresizingMaskIntoConstraints = NO;
  routesAffectedTitle.translatesAutoresizingMaskIntoConstraints = NO;
  reasonTitle.translatesAutoresizingMaskIntoConstraints = NO;
  outageStartTitle.translatesAutoresizingMaskIntoConstraints = NO;
  estimatedReturnTitle.translatesAutoresizingMaskIntoConstraints = NO;
  adaTitle.translatesAutoresizingMaskIntoConstraints = NO;
  updatedAtTitle.translatesAutoresizingMaskIntoConstraints = NO;
  [servingTitle setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                forAxis:UILayoutConstraintAxisHorizontal];
  
  [self.contentView addSubview:servingTitle];
  [self.contentView addSubview:equipmentTypeTitle];
  [self.contentView addSubview:routesAffectedTitle];
  [self.contentView addSubview:reasonTitle];
  [self.contentView addSubview:outageStartTitle];
  [self.contentView addSubview:estimatedReturnTitle];
  [self.contentView addSubview:adaTitle];
  [self.contentView addSubview:updatedAtTitle];
  
  NSDictionary *titleViews = NSDictionaryOfVariableBindings(servingTitle,
                                                            equipmentTypeTitle,
                                                            routesAffectedTitle,
                                                            reasonTitle,
                                                            outageStartTitle,
                                                            estimatedReturnTitle,
                                                            adaTitle,
                                                            updatedAtTitle);
  NSMutableDictionary *views = [@{
    @"servingLabel": self.servingLabel,
    @"equipmentTypeLabel": self.equipmentTypeLabel,
    @"routesAffectedLabel": self.routesAffectedLabel,
    @"reasonLabel": self.reasonLabel,
    @"outageStartDateLabel": self.outageStartDateLabel,
    @"estimatedReturnOfServiceLabel": self.estimatedReturnOfServiceLabel,
    @"adaLabel": self.adaLabel,
    @"updatedAtLabel": self.updatedAtLabel
  } mutableCopy];
  [views addEntriesFromDictionary:titleViews];

  NSString *constraint = @"V:|-[servingLabel][equipmentTypeLabel][routesAffectedLabel][reasonLabel]"
      "[outageStartDateLabel][estimatedReturnOfServiceLabel][adaLabel][updatedAtLabel]-|";
  [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:constraint
                                             options:0
                                             metrics:nil
                                               views:views]];

  [self layoutTitle:servingTitle withSubTitle:self.servingLabel];
  [self layoutTitle:equipmentTypeTitle withSubTitle:self.equipmentTypeLabel];
  [self layoutTitle:routesAffectedTitle withSubTitle:self.routesAffectedLabel];
  [self layoutTitle:reasonTitle withSubTitle:self.reasonLabel];
  [self layoutTitle:outageStartTitle withSubTitle:self.outageStartDateLabel];
  [self layoutTitle:estimatedReturnTitle withSubTitle:self.estimatedReturnOfServiceLabel];
  [self layoutTitle:adaTitle withSubTitle:self.adaLabel];
  [self layoutTitle:updatedAtTitle withSubTitle:self.updatedAtLabel];
}

@end
