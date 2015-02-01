//
//  HNDStationDetailView.h
//  HandiMap
//
//  Created by Chris Gonzales on 1/30/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HNDButton.h"
@interface HNDStationDetailView : UIView
@property (weak, nonatomic, readonly) UITableView *tableView;
@property (weak, nonatomic, readonly) HNDButton *outageButton;
@end
