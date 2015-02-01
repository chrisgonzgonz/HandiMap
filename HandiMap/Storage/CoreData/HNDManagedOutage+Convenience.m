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
  
  double outageDate = [dictionary[@"outage_start_date"] doubleValue];
  self.outageStartDate = [NSDate dateWithTimeIntervalSince1970:outageDate];
  double estimatedReturnOfService = [dictionary[@"estimated_return_of_service"] doubleValue];
  self.estimatedReturnOfService = [NSDate dateWithTimeIntervalSince1970:estimatedReturnOfService];
  
  self.ada = [NSNumber numberWithBool:[dictionary[@"ada"] boolValue]];
  self.updatedAt = [NSDate date];
}

@end
