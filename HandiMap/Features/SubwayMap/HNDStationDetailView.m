#import "HNDStationDetailView.h"

#import "HNDColor.h"
#import "HNDLabel.h"

@interface HNDStationDetailView ()
@property(nonatomic, readwrite, weak) UITableView *tableView;
@property(nonatomic, readwrite, weak) HNDLabel *titleView;
@end

@implementation HNDStationDetailView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self autolayoutSubviews];
  }
  return self;
}

- (HNDLabel *)titleView {
  if (!_titleView) {
    HNDLabel *titleView = [[[[HNDLabel alloc] init] typeSubtitle] invertTextColor];
    _titleView = titleView;
    _titleView.textAlignment = NSTextAlignmentCenter;
    _titleView.translatesAutoresizingMaskIntoConstraints = NO;
    _titleView.backgroundColor = [HNDColor mainColor];
    [self addSubview:_titleView];
  }
  return _titleView;
}

- (UITableView *)tableView {
  if (!_tableView) {
    UITableView *tableView = [[UITableView alloc] init];
    _tableView = tableView;
    _tableView.backgroundColor = [HNDColor lightColor];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_tableView];
  }
  return _tableView;
}

- (void)autolayoutSubviews {
  NSDictionary *views = @{@"titleView" : self.titleView,
                          @"tableView" : self.tableView};
  [self addConstraints:
      [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleView(>=44)][tableView]|"
                                              options:0
                                              metrics:nil
                                                views:views]];
  [self addConstraints:
      [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleView]|"
                                              options:0
                                              metrics:nil
                                              views:views]];
  [self addConstraints:
      [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|"
                                              options:0
                                              metrics:nil
                                              views:views]];
}

@end
