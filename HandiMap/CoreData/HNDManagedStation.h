#import <CoreData/CoreData.h>

@class HNDManagedOutage;

@interface HNDManagedStation : NSManagedObject

@property (nonatomic, retain) NSString * stationId;
@property (nonatomic, retain) NSString * stationName;
@property (nonatomic, retain) NSNumber * stationLongitude;
@property (nonatomic, retain) NSNumber * stationLatitude;
@property (nonatomic, retain) NSString * servedRoutes;
@property (nonatomic, retain) NSString * accessibleRoutes;
@property (nonatomic, retain) NSNumber * ada;
@property (nonatomic, retain) NSSet *outages;
@end

@interface HNDManagedStation (CoreDataGeneratedAccessors)

- (void)addOutagesObject:(HNDManagedOutage *)value;
- (void)removeOutagesObject:(HNDManagedOutage *)value;
- (void)addOutages:(NSSet *)values;
- (void)removeOutages:(NSSet *)values;

@end
