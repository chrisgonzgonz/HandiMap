#import "HNDSubwayLine.h"

static NSString *const kNoFilterText   = @"All Lines";
static NSString *const kRouteSeperator = @" ";

@implementation HNDSubwayLine

#pragma mark - Public

- (instancetype)initWithLineColor:(UIColor *)lineColor routes:(NSSet *)routes {
  if (self = [super init]) {
    _lineColor = lineColor;
    _routes = routes;
  }
  return self;
}

- (NSString *)lineText {
  if (self.routes) {
    NSSortDescriptor *sortDescriptor =
    [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES];
    return [[self.routes sortedArrayUsingDescriptors:@[sortDescriptor]]
            componentsJoinedByString:kRouteSeperator];
  } else {
    return kNoFilterText;
  }

}

@end
