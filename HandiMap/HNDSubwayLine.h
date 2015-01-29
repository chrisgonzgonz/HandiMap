#import <Foundation/Foundation.h>

@class UIColor;

/// A subway line can contain many routes. For example the A,C,E line has three routes.
@interface HNDSubwayLine : NSObject

/// A comma seperated string of all the routes.
@property(nonatomic, readonly, copy) NSString *lineText;

/// The color of a line.
@property(nonatomic, readonly) UIColor *lineColor;

/// A set of strings that each represent a route.
@property(nonatomic, readonly) NSSet *routes;

@end
