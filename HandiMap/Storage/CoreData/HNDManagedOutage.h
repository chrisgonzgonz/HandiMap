//
//  HNDManagedOutage.h
//  HandiMap
//
//  Created by Chris Gonzales on 1/31/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HNDManagedStation;

@interface HNDManagedOutage : NSManagedObject

@property (nonatomic, retain) NSNumber * ada;
@property (nonatomic, retain) NSString * equipmentType;
@property (nonatomic, retain) NSDate * estimatedReturnOfService;
@property (nonatomic, retain) NSDate * outageStartDate;
@property (nonatomic, retain) NSString * reason;
@property (nonatomic, retain) id routesAffected;
@property (nonatomic, retain) NSString * serving;
@property (nonatomic, retain) NSNumber * stationId;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) HNDManagedStation *station;

@end
