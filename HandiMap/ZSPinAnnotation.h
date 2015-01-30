#import <MapKit/MKAnnotationView.h>

typedef enum {
  ZSPinAnnotationTypeStandard,
  ZSPinAnnotationTypeDisc,
  ZSPinAnnotationTypeTag,
  ZSPinAnnotationTypeTagStroke
} ZSPinAnnotationType;


/// Provides custom pin view. Updated on 1/24/15.
/// Source \link https://github.com/nnhubbard/ZSPinAnnotation
@interface ZSPinAnnotation : MKAnnotationView

/// The annotation type to draw
@property(nonatomic) ZSPinAnnotationType annotationType;

/// The color to draw the annotation
@property(nonatomic) UIColor *annotationColor;

@end
