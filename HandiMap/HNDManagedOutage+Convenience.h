#import "HNDManagedOutage.h"

@interface HNDManagedOutage (Convenience)

- (instancetype)initWithEntity:(NSEntityDescription *)entity
    insertIntoManagedObjectContext:(NSManagedObjectContext *)context
                     andDictionary:(NSDictionary *)dictionary;

@end
