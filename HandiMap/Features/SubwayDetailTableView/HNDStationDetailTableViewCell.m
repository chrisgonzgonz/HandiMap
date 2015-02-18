#import "HNDStationDetailTableViewCell.h"

#import "HNDColor.h"
#import "HNDLabel.h"
#import "HNDStation.h" // WOAH! This should not be here...The controller do the binding.
#import "HNDTableViewCell+Protected.h"

@interface HNDStationDetailTableViewCell()
@property(nonatomic) UILabel *subwayLinesLabel;
@property(nonatomic) UILabel *accessibleLinesLabel;
@property(nonatomic) UILabel *adaLabel;
@end

@implementation HNDStationDetailTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.contentView.backgroundColor = [HNDColor lightColor];
    
    _subwayLinesLabel = [[HNDLabel alloc] init];
    _accessibleLinesLabel = [[HNDLabel alloc] init];
    _adaLabel = [[HNDLabel alloc] init];

    [self.contentView addSubview:_subwayLinesLabel];
    [self.contentView addSubview:_accessibleLinesLabel];
    [self.contentView addSubview:_adaLabel];
    [self autolayoutSubviews];
  }
  return self;
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
  HNDLabel *accessibleLinesTitle = [[[HNDLabel alloc] init] typeBold];
  HNDLabel *adaTitle = [[[HNDLabel alloc] init] typeBold];
  
  subwayLinesTitle.text = @"Subway Lines:";
  accessibleLinesTitle.text = @"Accessible Lines:";
  adaTitle.text = @"ADA:";
  
  [self.contentView addSubview:subwayLinesTitle];
  [self.contentView addSubview:accessibleLinesTitle];
  [self.contentView addSubview:adaTitle];
  
  for (UIView *subview in self.subviews) {
    subview.translatesAutoresizingMaskIntoConstraints = NO;
  }

  NSDictionary *views = @{
    @"accessibleLinesTitle": accessibleLinesTitle,
    @"adaTitle": adaTitle,
    @"subwayLinesTitle": subwayLinesTitle,
  };

  NSString *constraint = @"V:|-[subwayLinesTitle][accessibleLinesTitle][adaTitle]-|";
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:constraint
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];

  [self layoutTitle:subwayLinesTitle withSubTitle:self.subwayLinesLabel];
  [self layoutTitle:accessibleLinesTitle withSubTitle:self.accessibleLinesLabel];
  [self layoutTitle:adaTitle withSubTitle:self.adaLabel];
}

@end
