//
//  HNDOutageDetailTableViewCell.h
//  HandiMap
//
//  Created by Chris Gonzales on 1/31/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNDManagedOutage;
@interface HNDOutageDetailTableViewCell : UITableViewCell
@property (nonatomic) HNDManagedOutage *outage;
@end
