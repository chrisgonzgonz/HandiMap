#import "HNDSubwayMapView.h"

#import <MapKit/MapKit.h>
//#import "ZSPinAnnotation.h"

#import "HNDColor.h"
#import "HNDButton.h"

@interface HNDSubwayMapView() <MKMapViewDelegate>
@end

@implementation HNDSubwayMapView

#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _mapView = [[MKMapView alloc] init];
//    _mapView.delegate = self;
    [self addSubview:_mapView];

    [self autolayoutViews];
  }
  return self;
}

//#pragma mark - Protocols
//#pragma mark MKMapViewDelegate
//
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//  static NSString *const kPinReuseID = @"Subway map pin reuse id";
//  // Don't mess with user location
//  if([mapView.userLocation isEqual:annotation]) {
//    NSLog(@"GOT IT");
//    return nil;
//  }
//
//  // Create the ZSPinAnnotation object and reuse it
//  ZSPinAnnotation *pinView =
//      (ZSPinAnnotation *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:kPinReuseID];
//  if (!pinView){
//    pinView = [[ZSPinAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:kPinReuseID];
//  }
//
//  // Set the type of pin to draw and the color
//  pinView.annotationType = ZSPinAnnotationTypeTag;
//  pinView.annotationColor = [HNDColor mainColor];
//  pinView.canShowCallout = NO;
//
//  return pinView;
//}

// TODO: Extract this into a base class.
#pragma mark - Private

- (void)autolayoutViews {
  _mapView.translatesAutoresizingMaskIntoConstraints = NO;
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

@end
