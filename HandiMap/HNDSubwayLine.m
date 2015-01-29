#import "HNDSubwayLine+Protected.h"

@implementation HNDSubwayLine

#pragma mark - Public

- (instancetype)initWithLineColor:(UIColor *)lineColor
                         lineText:(NSString *)lineText
                           routes:(NSSet *)routes {
  if (self = [super init]) {
    _lineColor = lineColor;
    _lineText = lineText;
    _routes = routes;
  }
  return self;
}

@end
