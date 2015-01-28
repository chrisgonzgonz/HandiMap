//
//  HNDOutage+Convenience.h
//  HandiMap
//
//  Created by Chris Gonzales on 1/27/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import "HNDOutage.h"

@interface HNDOutage (Convenience)

- (instancetype)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context andDictionary:(NSDictionary *)dictionary;

@end
