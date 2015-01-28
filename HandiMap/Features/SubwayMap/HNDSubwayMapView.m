#import "HNDSubwayMapView.h"

#import <MapKit/MKMapView.h>

#import "HNDLabel.h"

@implementation HNDSubwayMapView

#pragma mark - Override
- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _mapView = [[MKMapView alloc] init];
    _selectedFilterView = [[HNDLabel alloc] init];

    [self addSubview:_mapView];
    [self addSubview:_selectedFilterView];

    [self autolayoutViews];
  }
  return self;
}

#pragma mark - Private

- (void)autolayoutViews {
  [self turnOffAutoResizing];
  NSDictionary *views = NSDictionaryOfVariableBindings(_mapView);

  // Horizontal layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|[_mapView]|"
                          options:0
                          metrics:nil
                            views:views]];

  // Vertical layout
  [self addConstraints:[NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|[_mapView]|"
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
