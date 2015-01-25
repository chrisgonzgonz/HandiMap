//
//  HNDOutage.h
//  HandiMap
//
//  Created by Chris Gonzales on 1/24/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HNDStation;

@interface HNDOutage : NSManagedObject

@property (nonatomic, retain) NSString * stationId;
@property (nonatomic, retain) NSString * serving;
@property (nonatomic, retain) NSString * equipmentType;
@property (nonatomic, retain) NSString * routesAffected;
@property (nonatomic, retain) NSString * reason;
@property (nonatomic, retain) NSDate * outageStartDate;
@property (nonatomic, retain) NSDate * estimatedReturnOfService;
@property (nonatomic, retain) NSNumber * ada;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) HNDStation *station;

@end
