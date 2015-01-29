#import "HNDSubwayListView.h"

#import "HNDColor.h"

NSString *const kSubwayLineCellId = @"subway line cell reuse identifier";

@implementation HNDSubwayLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

  }
  return self;
}

@end

@implementation HNDSubwayListView

#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {

    _subwayLinesTableView = [[UITableView alloc] init];
    _subwayLinesTableView.backgroundColor = [HNDColor lightColor];
    [_subwayLinesTableView registerClass:[HNDSubwayLineCell class]
                  forCellReuseIdentifier:kSubwayLineCellId];

    [self addSubview:_subwayLinesTableView];

    [self autolayoutViews];
  }
  return self;
}


#pragma mark - Private

- (void)autolayoutViews {
  [self turnOffAutoResizing];
  NSDictionary *views = NSDictionaryOfVariableBindings(_subwayLinesTableView);

  // Horizontal layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|[_subwayLinesTableView]|"
                          options:0
                          metrics:nil
                            views:views]];

  // Vertical layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|[_subwayLinesTableView]|"
                          options:0
                          metrics:nil
                            views:views]];
}


- (void)turnOffAutoResizing {
  [self turnOffAutoResizingForView:self];
}

- (void)turnOffAutoResizingForView:(UIView *)view {
  view.translatesAutoresizingMaskIntoConstraints = NO;
  for (UIView *subView in view.subviews) {
    [self turnOffAutoResizingForView:subView];
  }
}

@end
