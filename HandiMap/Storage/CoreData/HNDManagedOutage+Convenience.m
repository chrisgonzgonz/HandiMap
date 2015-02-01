#import "HNDManagedOutage+Convenience.h"

@implementation HNDManagedOutage (Convenience)

- (instancetype)initWithEntity:(NSEntityDescription *)entity
    insertIntoManagedObjectContext:(NSManagedObjectContext *)context
                     andDictionary:(NSDictionary *)dictionary {
  self = [self initWithEntity:entity insertIntoManagedObjectContext:context];
  [self mapJSONwithDictionary:dictionary];
  return self;
}

- (void)mapJSONwithDictionary:(NSDictionary *)dictionary {
  self.stationId = dictionary[@"station_id"];
  self.serving = dictionary[@"serving"];
  self.equipmentType = dictionary[@"equipment_type"];
  self.routesAffected = dictionary[@"routes_affected"];
  self.reason = dictionary[@"reason"];
  self.outageStartDate = [NSDate dateWithTimeIntervalSince1970:
      [dictionary[@"outage_start_date"] integerValue]];
  self.estimatedReturnOfService = [NSDate dateWithTimeIntervalSince1970:
      [dictionary[@"estimated_return_of_service"] integerValue]];
  self.ada = [NSNumber numberWithBool:[dictionary[@"ada"] boolValue]];
  self.updatedAt = [NSDate date];
}

@end
