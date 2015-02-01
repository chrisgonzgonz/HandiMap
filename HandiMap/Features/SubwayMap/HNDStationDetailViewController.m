//
//  HNDStationDetailViewController.m
//  HandiMap
//
//  Created by Chris Gonzales on 1/30/15.
//  Copyright (c) 2015 FSDC. All rights reserved.
//

#import "HNDStationDetailViewController.h"

#import "HNDStationDetailView.h"
#import "HNDStationDetailTableViewCell.h"
#import "HNDStation.h"
#import "HNDOutageDetailTableViewCell.h"
@interface HNDStationDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, readwrite) HNDStationDetailView *view;
@property (nonatomic) NSArray *currentOutages;
@end

@implementation HNDStationDetailViewController


- (void)loadView {
  self.view = [[HNDStationDetailView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.tableView.delegate = self;
  self.view.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSelectedStation:(HNDStation *)selectedStation {
  _selectedStation = selectedStation;
  self.currentOutages = [selectedStation.managedStation.outages allObjects];
  [self.view.outageButton setTitle:selectedStation.name forState:UIControlStateNormal];
  [self.view.tableView reloadData];
}

#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return section ? self.selectedStation.managedStation.outages.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell;
  if (indexPath.section == 0) {
    static NSString *stationCellID = @"stationCell";
    HNDStationDetailTableViewCell *stationCell = [tableView dequeueReusableCellWithIdentifier:stationCellID];
    if (!stationCell) {
      stationCell = [[HNDStationDetailTableViewCell alloc] init];
    }
    stationCell.station = self.selectedStation;
    cell = stationCell;
  } else{
    static NSString *outageCellID = @"outageCell";
    HNDOutageDetailTableViewCell *outageCell = [tableView dequeueReusableCellWithIdentifier:outageCellID];
    if (!outageCell) {
      outageCell = [[HNDOutageDetailTableViewCell alloc] init];
    }
    outageCell.outage = self.currentOutages[indexPath.row];
    cell = outageCell;
  }
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    HNDStationDetailTableViewCell *sizingCell = [self.view.tableView dequeueReusableCellWithIdentifier:@"stationCell"];
    if (!sizingCell) {
      sizingCell = [[HNDStationDetailTableViewCell alloc] init];
    }
    sizingCell.station = self.selectedStation;
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f;
  }
  return 90;
}

//
//- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
//  static HNDStationDetailTableViewCell *sizingCell = nil;
//  static dispatch_once_t onceToken;
//  dispatch_once(&onceToken, ^{
//    sizingCell = [self.view.tableView dequeueReusableCellWithIdentifier:stationCellID];
//  });
// 
////  [self configureBasicCell:sizingCell atIndexPath:indexPath];
//  return [self calculateHeightForConfiguredSizingCell:sizingCell];
//}
// 
//- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
//  [sizingCell setNeedsLayout];
//  [sizingCell layoutIfNeeded];
// 
//  CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//  return size.height + 1.0f; // Add 1.0f for the cell separator height
//}

@end
