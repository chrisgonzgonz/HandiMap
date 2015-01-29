#import "HNDOutage.h"

@interface HNDOutage (Convenience)

- (instancetype)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context andDictionary:(NSDictionary *)dictionary;

@end
