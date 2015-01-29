#import "HNDStation.h"

@interface HNDStation (Convenience)

- (instancetype)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context andDictionary:(NSDictionary *)dictionary;

@end
