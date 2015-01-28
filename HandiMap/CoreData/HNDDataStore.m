//
//  HNDDataStore.m
//  HandiMap
//
//  Created by Chris Gonzales on 1/27/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import "HNDDataStore.h"

#import "HNDJobNetworkManager.h"
#import "HNDCoreDataManager.h"

@implementation HNDDataStore

+ (instancetype)sharedStore
{
    static HNDDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[HNDDataStore   alloc] init];
    });
    return _sharedDataStore;
}

- (void)loadStations {
  
}

- (void)loadOutages {
  
}

@end
