//
//  HNDOutage+Convenience.m
//  HandiMap
//
//  Created by Chris Gonzales on 1/27/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import "HNDOutage+Convenience.h"

@implementation HNDOutage (Convenience)

- (instancetype)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context andDictionary:(NSDictionary *)dictionary {
  self = [self initWithEntity:entity insertIntoManagedObjectContext:context];
  [self mapJSONwithDictionary:dictionary];
  return self;
}

- (void)mapJSONwithDictionary:(NSDictionary *)dictionary {
  self.stationId = dictionary[@"station_id"];
  self.serving = dictionary[@"served_routes"];
  self.equipmentType = dictionary[@"equipmentType"];
  self.routesAffected = dictionary[@"routes_affected"];
  self.reason = dictionary[@"reason"];
  self.outageStartDate = dictionary[@"outage_start_date"];
  self.estimatedReturnOfService = dictionary[@"estimated_return_of_service"];
  self.ada = dictionary[@"ada"];
  self.updatedAt = [NSDate date];
}

@end
