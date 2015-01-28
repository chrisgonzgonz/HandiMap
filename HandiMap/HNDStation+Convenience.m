//
//  HNDStation+Convenience.m
//  HandiMap
//
//  Created by Chris Gonzales on 1/27/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import "HNDStation+Convenience.h"

@implementation HNDStation (Convenience)

- (instancetype)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context andDictionary:(NSDictionary *)dictionary {
  self = [self initWithEntity:entity insertIntoManagedObjectContext:context];
  [self mapJSONwithDictionary:dictionary];
  return self;
}

- (void)mapJSONwithDictionary:(NSDictionary *)dictionary {
  self.stationId = dictionary[@"id"];
  self.stationName = dictionary[@"station_name"];
  self.stationLongitude = dictionary[@"station_longitude"];
  self.stationLatitude = dictionary[@"station_latitude"];
  self.servedRoutes = dictionary[@"served_routes"];
  self.accessibleRoutes = dictionary[@"accessible_routes"];
  self.ada = dictionary[@"ada"];
}

@end
