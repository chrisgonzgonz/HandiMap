#import "HNDManagedStation.h"
#import <MapKit/MKAnnotation.h>

/// Yeah, I know you are suppose to use categories, but I prefer subclasses :)
@interface HNDStation : HNDManagedStation <MKAnnotation>
@end
