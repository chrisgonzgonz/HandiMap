#import "HNDSubwayLine+Protected.h"

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
  NSSortDescriptor *sortDescriptor =
      [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:NO];
  return [[self.routes sortedArrayUsingDescriptors:@[sortDescriptor]]
      componentsJoinedByString:kRouteSeperator];
}

@end
