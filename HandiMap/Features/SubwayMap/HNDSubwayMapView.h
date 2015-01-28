#import <UIKit/UIKit.h>

@class MKMapView;

@interface HNDSubwayMapView : UIView

@property(nonatomic, readonly) MKMapView *mapView;
@property(nonatomic, readonly) UIButton *selectedFilterBtnView;

@end
