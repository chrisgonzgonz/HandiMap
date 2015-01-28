//
//  HNDDataStore.h
//  HandiMap
//
//  Created by Chris Gonzales on 1/27/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNDDataStore : NSObject

+ (instancetype)sharedStore;
- (void)loadStations;
- (void)loadOutages;

@end
