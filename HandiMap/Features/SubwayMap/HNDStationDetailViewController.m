#import "HNDStationDetailViewController.h"

#import "HNDLabel.h"
#import "HNDOutageDetailTableViewCell.h"
#import "HNDStation.h"
#import "HNDStationDetailView.h"
#import "HNDStationDetailTableViewCell.h"

@interface HNDStationDetailViewController() <UITableViewDataSource,
                                             UITableViewDelegate>
// Casts root view.
@property(nonatomic) HNDStationDetailView *view;
@end

@implementation HNDStationDetailViewController

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
  [self refreshViews];
}

#pragma mark - Protocols
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.selectedStation.outages.count ? 2 : 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return section == 0 ? nil : @"Outages";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return section ? self.selectedStation.outages.count : 1;
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
    outageCell.outage = self.selectedStation.outages[indexPath.row];
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
    sizingCell.outage = self.selectedStation.outages[indexPath.row];
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize size =
        [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f;
  }
}

#pragma mark - Private

- (void)refreshViews {
  self.view.titleView.text = self.selectedStation.name;
  [self.view.tableView reloadData];
}

@end
