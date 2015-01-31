//
//  HNDStationDetailViewController.h
//  HandiMap
//
//  Created by Chris Gonzales on 1/30/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import "HNDViewController.h"
@class HNDStationDetailView;
@class HNDStation;
@interface HNDStationDetailViewController : HNDViewController
@property (nonatomic, readonly) HNDStationDetailView *view;
@property (nonatomic) HNDStation *selectedStation;
@end
