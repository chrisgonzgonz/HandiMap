#import "HNDManagedStation.h"

@interface HNDManagedStation (Convenience)

- (instancetype)initWithEntity:(NSEntityDescription *)entity
    insertIntoManagedObjectContext:(NSManagedObjectContext *)context
                     andDictionary:(NSDictionary *)dictionary;

@end
