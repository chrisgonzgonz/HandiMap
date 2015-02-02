#import <UIKit/UIKit.h>

@class CLLocation;
@class MKMapView;
@class HNDStation;

@protocol HNDSubwayMapViewDelegate <NSObject>
@optional
- (void)didSelectStation:(HNDStation *)station;
- (void)didDeselectStation:(HNDStation *)station; // Not stable, do not use yet.
@end

@interface HNDSubwayMapView : UIView
@property(nonatomic) id <HNDSubwayMapViewDelegate> delegate;
@property(nonatomic) UIView *stationDetailView; // Inject me.

/// \param stations is expected to conform to the \protocol MKAnnotation
- (void)updateStations:(NSArray *)stations;
- (void)centerAnnotion:(CLLocation *)location;
- (void)centerUser;

@end
