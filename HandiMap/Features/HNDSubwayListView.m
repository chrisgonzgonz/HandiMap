#import "HNDSubwayListView.h"

#import "HNDColor.h"
#import "HNDLabel.h"

NSString *const kSubwayLineCellId = @"subway line cell reuse identifier";

@implementation HNDSubwayLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    self.backgroundColor = [HNDColor lightColor];

    _lineLabel = [[[[HNDLabel alloc] init] typeTitle] invertTextColor];
    _lineLabel.textAlignment = NSTextAlignmentCenter;

    [self addSubview:_lineLabel];
    [self autoLayoutViews];
  }
  return self;
}

- (void)autoLayoutViews {
  _lineLabel.translatesAutoresizingMaskIntoConstraints = NO;
  NSDictionary *viewBindings = NSDictionaryOfVariableBindings(_lineLabel);

  // Horizontal layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|-20-[_lineLabel]-20-|"
                          options:0
                          metrics:nil
                            views:viewBindings]];

  // Vertical layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|[_lineLabel(44)]|"
                          options:0
                          metrics:nil
                            views:viewBindings]];
}

@end

@implementation HNDSubwayListView

#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {

    _subwayLinesTableView = [[UITableView alloc] init];
    _subwayLinesTableView.backgroundColor = [HNDColor lightColor];
    _subwayLinesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
  NSDictionary *viewBindings = NSDictionaryOfVariableBindings(_subwayLinesTableView);

  // Horizontal layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|[_subwayLinesTableView]|"
                          options:0
                          metrics:nil
                            views:viewBindings]];

  // Vertical layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|[_subwayLinesTableView]|"
                          options:0
                          metrics:nil
                            views:viewBindings]];
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
