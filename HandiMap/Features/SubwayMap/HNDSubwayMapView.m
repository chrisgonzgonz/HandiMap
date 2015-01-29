#import "HNDSubwayMapView.h"

#import <MapKit/MKMapView.h>

#import "HNDColor.h"
#import "HNDButton.h"

@implementation HNDSubwayMapView

#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _mapView = [[MKMapView alloc] init];

    _selectedFilterBtnView = [[[[HNDButton alloc] init] largeButton] invertColors];
    _selectedFilterBtnView.backgroundColor = [HNDColor mainColor];
    [_selectedFilterBtnView setTitle:@"All MTA Lines" forState:UIControlStateNormal];

    [self addSubview:_mapView];
    [self addSubview:_selectedFilterBtnView];

    [self autolayoutViews];
  }
  return self;
}

// TODO: Extract this into a base class.
#pragma mark - Private

- (void)autolayoutViews {
  _mapView.translatesAutoresizingMaskIntoConstraints = NO;
  _selectedFilterBtnView.translatesAutoresizingMaskIntoConstraints = NO;
  NSDictionary *views = NSDictionaryOfVariableBindings(_mapView,
                                                       _selectedFilterBtnView);

  // Horizontal layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|[_mapView]|"
                          options:0
                          metrics:nil
                            views:views]];
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|[_selectedFilterBtnView]|"
                          options:0
                          metrics:nil
                        views:views]];

  // Vertical layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|[_mapView]|"
                          options:0
                          metrics:nil
                            views:views]];
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|[_selectedFilterBtnView(64)]"
                        options:0
                        metrics:nil
                        views:views]];

}

- (void)turnOffAutoResizing {
  [self turnOffAutoResizingForView:self];
}

- (void)turnOffAutoResizingForView:(UIView *)view {
  for (UIView *subView in view.subviews) {
    [self turnOffAutoResizingForView:subView];
  }
}

@end
