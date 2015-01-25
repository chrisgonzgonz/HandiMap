//
//  HNDCoreDataManager.h
//  HandiMap
//
//  Created by Chris Gonzales on 1/24/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;

@interface HNDCoreDataManager : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *mainContext;
- (NSManagedObjectContext *)newWorkerContext;

@end
