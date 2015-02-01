#import "HNDStationDetailView.h"

#import "HNDButton.h"
#import "HNDColor.h"

@interface HNDStationDetailView ()
@property(nonatomic, readwrite, weak) UITableView *tableView;
@property(nonatomic, readwrite, weak) HNDButton *outageButton;
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
  NSDictionary *views = @{@"outageButton": self.outageButton, @"tableView": self.tableView};
  [self addConstraints:
      [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[outageButton(==44)][tableView]|"
                                              options:0
                                              metrics:nil
                                                views:views]];
  [self addConstraints:
      [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[outageButton]|"
                                              options:0
                                              metrics:nil
                                              views:views]];
  [self addConstraints:
      [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|"
                                              options:0
                                              metrics:nil
                                              views:views]];
}

- (HNDButton *)outageButton {
  if (!_outageButton) {
    HNDButton *outageButton = [[HNDButton alloc] init];
    outageButton.translatesAutoresizingMaskIntoConstraints = NO;
    _outageButton = outageButton;
    _outageButton.backgroundColor = [HNDColor mainColor];
    [_outageButton setTitleColor:[HNDColor lightColor] forState:UIControlStateNormal];
    [self addSubview:_outageButton];
  }
  return _outageButton;
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
