//
//  HNDStationDetailView.m
//  HandiMap
//
//  Created by Chris Gonzales on 1/30/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import "HNDStationDetailView.h"

@interface HNDStationDetailView ()
@property (weak, nonatomic, readwrite) UITableView *tableView;
@property (weak, nonatomic, readwrite) UIButton *outtageButton;
@end
@implementation HNDStationDetailView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self autolayoutSubviews];
  }
  return self;
}

- (void)autolayoutSubviews {
  self.translatesAutoresizingMaskIntoConstraints = NO;
  NSDictionary *views = @{@"outtageButton": self.outtageButton, @"tableView": self.tableView};
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[outtageButton(==44)][tableView]|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[outtageButton]|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views]];
}

- (UIButton *)outtageButton {
  if (!_outtageButton) {
    UIButton *outtageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    outtageButton.translatesAutoresizingMaskIntoConstraints = NO;
    _outtageButton = outtageButton;
    _outtageButton.backgroundColor = [UIColor redColor];
    [self addSubview:_outtageButton];
  }
  return _outtageButton;
}

- (UITableView *)tableView {
  if (!_tableView) {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView = tableView;
    [self addSubview:_tableView];
  }
  return _tableView;
}
@end
