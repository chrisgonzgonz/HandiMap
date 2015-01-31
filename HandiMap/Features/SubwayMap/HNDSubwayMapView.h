#import <UIKit/UIKit.h>

@class MKMapView;

@interface HNDSubwayMapView : UIView

/// \param stations is expected to conform to the \protocol MKAnnotation
- (void)updateStations:(NSArray *)stations;

@end
