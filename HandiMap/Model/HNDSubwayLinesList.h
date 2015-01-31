#import <Foundation/Foundation.h>

@interface HNDSubwayLinesList : NSObject

/// The last line returned will represent no filter.
@property(nonatomic, readonly) NSArray *lines;

@end
