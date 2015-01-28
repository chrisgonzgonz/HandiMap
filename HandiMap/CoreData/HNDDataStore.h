#import <Foundation/Foundation.h>

@interface HNDDataStore : NSObject

+ (instancetype)sharedStore;
- (void)loadStations;
- (void)loadOutages;

@end
