#import "HNDStationDetailViewController.h"

#import "HNDButton.h" // TODO: Not needed.
#import "HNDOutageDetailTableViewCell.h"
#import "HNDStation.h"
#import "HNDStationDetailView.h"
#import "HNDStationDetailTableViewCell.h"

@interface HNDStationDetailViewController() <UITableViewDataSource,
                                             UITableViewDelegate>
// Casts root view.
@property(nonatomic) HNDStationDetailView *view;
@property(nonatomic, readonly) NSArray *currentOutages;
@end

@implementation HNDStationDetailViewController

- (NSArray *)currentOutages {
  return [self.selectedStation.managedStation.outages allObjects];
}

- (void)loadView {
  self.view = [[HNDStationDetailView alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.tableView.delegate = self;
  self.view.tableView.dataSource = self;
}

#pragma mark - Public

- (void)setSelectedStation:(HNDStation *)selectedStation {
  _selectedStation = selectedStation;
  [self.view.outageButton setTitle:selectedStation.name forState:UIControlStateNormal];
  [self.view.tableView reloadData];
}

#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return section == 0 ? @"Station Information" : @"Outages";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return section ? self.selectedStation.managedStation.outages.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell;
  if (indexPath.section == 0) {
    static NSString *stationCellID = @"stationCell";
    HNDStationDetailTableViewCell *stationCell =
        [tableView dequeueReusableCellWithIdentifier:stationCellID];
    if (!stationCell) {
      stationCell = [[HNDStationDetailTableViewCell alloc] init];
    }
    stationCell.station = self.selectedStation;
    cell = stationCell;
  } else{
    static NSString *outageCellID = @"outageCell";
    HNDOutageDetailTableViewCell *outageCell =
        [tableView dequeueReusableCellWithIdentifier:outageCellID];
    if (!outageCell) {
      outageCell = [[HNDOutageDetailTableViewCell alloc] init];
    }
    outageCell.outage = self.currentOutages[indexPath.row];
    cell = outageCell;
  }
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    HNDStationDetailTableViewCell *sizingCell = [self.view.tableView dequeueReusableCellWithIdentifier:@"stationCell"];
    if (!sizingCell) {
      sizingCell = [[HNDStationDetailTableViewCell alloc] init];
    }
    sizingCell.station = self.selectedStation;
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize size =
        [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f;
  } else {
    HNDOutageDetailTableViewCell *sizingCell =
        [self.view.tableView dequeueReusableCellWithIdentifier:@"outageCell"];
    if (!sizingCell) {
      sizingCell = [[HNDOutageDetailTableViewCell alloc] init];
    }
    sizingCell.outage = self.currentOutages[indexPath.row];
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize size =
        [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f;
  }
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
