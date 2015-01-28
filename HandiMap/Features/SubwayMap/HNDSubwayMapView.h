#import <UIKit/UIKit.h>

@class MKMapView;

@interface HNDSubwayMapView : UIView

@property (nonatomic) MKMapView *mapView;
@property (nonatomic) UILabel *selectedFilterView;

@end
