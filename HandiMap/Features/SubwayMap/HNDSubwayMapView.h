#import <UIKit/UIKit.h>

@class MKMapView;
@class HNDStation;

@protocol HNDSubwayMapViewDelegate <NSObject>
@optional
- (void)didSelectStation:(HNDStation *)station;
- (void)didDeselectStation:(HNDStation *)station;
@end

@interface HNDSubwayMapView : UIView
@property(nonatomic) id <HNDSubwayMapViewDelegate> delegate;
@property(nonatomic) UIView *stationDetailView; // Inject me.

/// \param stations is expected to conform to the \protocol MKAnnotation
- (void)updateStations:(NSArray *)stations;

@end
