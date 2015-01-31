//
//  HNDStationDetailViewController.m
//  HandiMap
//
//  Created by Chris Gonzales on 1/30/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import "HNDStationDetailViewController.h"

#import "HNDStationDetailView.h"
@interface HNDStationDetailViewController ()
@end

@implementation HNDStationDetailViewController

- (void)loadView {
  self.view = [[HNDStationDetailView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
