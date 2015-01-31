#import <UIKit/UIKit.h>

@class MKMapView;
@class HNDStation;

@protocol HNDSubwayMapViewDelegate <NSObject>
@optional
- (void)didSelectAnnotationWithStation:(HNDStation *)station;
@end

@interface HNDSubwayMapView : UIView
@property(nonatomic) id <HNDSubwayMapViewDelegate> delegate;
/// \param stations is expected to conform to the \protocol MKAnnotation
- (void)updateStations:(NSArray *)stations;

@end
