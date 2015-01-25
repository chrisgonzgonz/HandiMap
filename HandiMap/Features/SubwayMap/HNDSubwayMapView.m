#import "HNDSubwayMapView.h"

#import <MapKit/MKMapView.h>

@implementation HNDSubwayMapView

- (MKMapView *)mapView {
  if (!_mapView) {
    _mapView = [[MKMapView alloc] init];
    [self addSubview:_mapView];
  }
  return _mapView;
}

#pragma mark - Override
- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self autolayoutViews];
  }
  return self;
}

#pragma mark - Private
- (void)autolayoutViews {
  self.translatesAutoresizingMaskIntoConstraints = NO;
  self.mapView.translatesAutoresizingMaskIntoConstraints = NO;
  
  NSDictionary *views = NSDictionaryOfVariableBindings(_mapView);
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mapView]|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mapView]|" options:0 metrics:nil views:views]];
}
@end
