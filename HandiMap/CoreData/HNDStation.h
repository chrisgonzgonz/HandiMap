//
//  HNDStation.h
//  HandiMap
//
//  Created by Chris Gonzales on 1/24/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HNDOutage;

@interface HNDStation : NSManagedObject

@property (nonatomic, retain) NSString * stationId;
@property (nonatomic, retain) NSString * stationName;
@property (nonatomic, retain) NSNumber * stationLongitude;
@property (nonatomic, retain) NSNumber * stationLatitude;
@property (nonatomic, retain) NSString * servedRoutes;
@property (nonatomic, retain) NSString * accessibleRoutes;
@property (nonatomic, retain) NSNumber * ada;
@property (nonatomic, retain) NSSet *outages;
@end

@interface HNDStation (CoreDataGeneratedAccessors)

- (void)addOutagesObject:(HNDOutage *)value;
- (void)removeOutagesObject:(HNDOutage *)value;
- (void)addOutages:(NSSet *)values;
- (void)removeOutages:(NSSet *)values;

@end
