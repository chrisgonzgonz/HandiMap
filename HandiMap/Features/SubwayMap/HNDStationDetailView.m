#import "HNDStationDetailView.h"

#import "HNDColor.h"
#import "HNDLabel.h"

@interface HNDStationDetailView ()
@property(nonatomic, readwrite, weak) UITableView *tableView;
@property(nonatomic, readwrite, weak) HNDLabel *titleView;
@property(nonatomic, weak) UIView *containerView;
@end

@implementation HNDStationDetailView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self autolayoutSubviews];
  }
  return self;
}

- (UIView *)containerView {
  if (!_containerView) {
    UIView *containerView = [[UIView alloc] init];
    _containerView = containerView;
    _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    _containerView.backgroundColor = [HNDColor mainColor];

    UIImage *infoImage =
        [[UIImage imageNamed:@"info-32"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *infoView = [[UIImageView alloc] initWithImage:infoImage];
    infoView.tintColor = [HNDColor lightColor];
    infoView.contentMode = UIViewContentModeScaleAspectFit;
    infoView.translatesAutoresizingMaskIntoConstraints = NO;

    [_containerView addSubview:self.titleView];
    [_containerView addSubview:infoView];
    [self addSubview:containerView];

    NSDictionary *views = NSDictionaryOfVariableBindings(containerView,
                                                         _titleView,
                                                         infoView);
    [containerView addConstraints:
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleView]|"
                                                options:0
                                                metrics:nil
                                                  views:views]];
    [containerView addConstraints:
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[infoView]|"
                                                options:0
                                                metrics:nil
                                                  views:views]];
    [containerView addConstraints:
        [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleView]-[infoView(<=20)]-|"
                                                options:0
                                                metrics:nil
                                                  views:views]];
  }
  return _containerView;
}

- (HNDLabel *)titleView {
  if (!_titleView) {
    HNDLabel *titleView = [[[[[HNDLabel alloc] init] typeSubtitle] invertTextColor] alignCenter];
    _titleView = titleView;
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
  NSDictionary *views = @{@"containerView" : self.containerView,
                          @"tableView" : self.tableView};
  [self addConstraints:
      [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView(>=44)][tableView]|"
                                              options:0
                                              metrics:nil
                                                views:views]];
  [self addConstraints:
      [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|"
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
