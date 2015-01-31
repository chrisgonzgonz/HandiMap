#import <Foundation/Foundation.h>

@interface HNDDataStore : NSObject

+ (instancetype)sharedStore;
- (void)loadStationsWithSuccess:(void(^)())success failure:(void(^)())failure;
- (void)loadOutagesWithSuccess:(void(^)())success failure:(void(^)())failure;

@end
