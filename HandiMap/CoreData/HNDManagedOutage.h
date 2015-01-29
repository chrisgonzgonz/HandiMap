#import <CoreData/CoreData.h>

@class HNDManagedStation;

@interface HNDManagedOutage : NSManagedObject

@property (nonatomic, retain) NSString * stationId;
@property (nonatomic, retain) NSString * serving;
@property (nonatomic, retain) NSString * equipmentType;
@property (nonatomic, retain) NSString * routesAffected;
@property (nonatomic, retain) NSString * reason;
@property (nonatomic, retain) NSDate * outageStartDate;
@property (nonatomic, retain) NSDate * estimatedReturnOfService;
@property (nonatomic, retain) NSNumber * ada;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) HNDManagedStation *station;

@end