#import "HNDSubwayLineList.h"

#import "HNDColor.h"
#import "HNDSubwayLine+Protected.h"

@implementation HNDSubwayLineList

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
  UIColor *ACEColor         = UIColorFromHex(0x2850ad);
  UIColor *BDFMColor        = UIColorFromHex(0xff6319);
  UIColor *NQRColor         = UIColorFromHex(0xfccc0a);
  UIColor *OneTwoThreeColor = UIColorFromHex(0xee352e);
  UIColor *FourFiveSixColor = UIColorFromHex(0x00933c);
  UIColor *SevenColor       = UIColorFromHex(0xb933ad);
  UIColor *GColor           = UIColorFromHex(0x6cbe45);
  UIColor *LColor           = UIColorFromHex(0xa7a9ac);
  UIColor *JiggaColor       = UIColorFromHex(0x996633);
  UIColor *SColor           = UIColorFromHex(0x808183);

  // Routes
  NSSet *ACERoutes         = [NSSet setWithArray:@[@"A", @"C", @"E"]];
  NSSet *BDFMRoutes        = [NSSet setWithArray:@[@"B", @"D", @"F", @"M"]];
  NSSet *NQRRoutes         = [NSSet setWithArray:@[@"N", @"Q", @"R"]];
  NSSet *OneTwoThreeRoutes = [NSSet setWithArray:@[@"1", @"2", @"3"]];
  NSSet *FourFiveSixRoutes = [NSSet setWithArray:@[@"4", @"5", @"6"]];
  NSSet *SevenRoutes       = [NSSet setWithArray:@[@"7"]];
  NSSet *GRoutes           = [NSSet setWithArray:@[@"G"]];
  NSSet *LRoutes           = [NSSet setWithArray:@[@"L"]];
  NSSet *JiggaRoutes       = [NSSet setWithArray:@[@"J", @"Z"]];
  NSSet *SRoutes           = [NSSet setWithArray:@[@"S"]];

  return @[[[HNDSubwayLine alloc] initWithLineColor:ACEColor         routes:ACERoutes],
           [[HNDSubwayLine alloc] initWithLineColor:BDFMColor        routes:BDFMRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:NQRColor         routes:NQRRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:OneTwoThreeColor routes:OneTwoThreeRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:FourFiveSixColor routes:FourFiveSixRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:SevenColor       routes:SevenRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:GColor           routes:GRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:LColor           routes:LRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:JiggaColor       routes:JiggaRoutes],
           [[HNDSubwayLine alloc] initWithLineColor:SColor           routes:SRoutes]];
}

@end
