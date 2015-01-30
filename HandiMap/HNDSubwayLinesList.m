#import "HNDSubwayLinesList.h"

#import "HNDColor.h"
#import "HNDSubwayLine+Protected.h"

@implementation HNDSubwayLinesList

@synthesize lines = _lines; // Why is this needed?

#pragma mark - Public

- (NSArray *)lines {
  if (!_lines) {
    _lines = [self hardcodedLines];
  }
  return _lines;
}

#pragma mark - Private

- (NSArray *)hardcodedLines {

  /// Colors from \link http://en.wikipedia.org/wiki/List_of_New_York_City_Subway_lines
  UIColor *aceColor         = UIColorFromHex(0x2850ad);
  UIColor *bdfmColor        = UIColorFromHex(0xff6319);
  UIColor *nqrColor         = UIColorFromHex(0xfccc0a);
  UIColor *oneTwoThreeColor = UIColorFromHex(0xee352e);
  UIColor *fourFiveSixColor = UIColorFromHex(0x00933c);
  UIColor *sevenColor       = UIColorFromHex(0xb933ad);
  UIColor *gColor           = UIColorFromHex(0x6cbe45);
  UIColor *lColor           = UIColorFromHex(0xa7a9ac);
  UIColor *jiggaColor       = UIColorFromHex(0x996633);
  UIColor *sColor           = UIColorFromHex(0x808183);

  // Routes
  NSSet *aceRoutes         = [NSSet setWithArray:@[@"A", @"C", @"E"]];
  NSSet *bdfmRoutes        = [NSSet setWithArray:@[@"B", @"D", @"F", @"M"]];
  NSSet *nqrRoutes         = [NSSet setWithArray:@[@"N", @"Q", @"R"]];
  NSSet *oneTwoThreeRoutes = [NSSet setWithArray:@[@"1", @"2", @"3"]];
  NSSet *fourFiveSixRoutes = [NSSet setWithArray:@[@"4", @"5", @"6"]];
  NSSet *sevenRoutes       = [NSSet setWithArray:@[@"7"]];
  NSSet *gRoutes           = [NSSet setWithArray:@[@"G"]];
  NSSet *lRoutes           = [NSSet setWithArray:@[@"L"]];
  NSSet *jiggaRoutes       = [NSSet setWithArray:@[@"J", @"Z"]];
  NSSet *sRoutes           = [NSSet setWithArray:@[@"S"]];

  return @[[[HNDSubwayLine alloc] initWithLineColor:aceColor         routes:aceRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:bdfmColor        routes:bdfmRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:nqrColor         routes:nqrRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:oneTwoThreeColor routes:oneTwoThreeRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:fourFiveSixColor routes:fourFiveSixRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:sevenColor       routes:sevenRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:gColor           routes:gRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:lColor           routes:lRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:jiggaColor       routes:jiggaRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:sColor           routes:sRoutes]];
}

@end
