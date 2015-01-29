#import "HNDSubwayLineFilterViewController.h"

#import "HNDSubwayLine.h"
#import "HNDSubwayLinesList.h"
#import "HNDSubwayListView.h"

@interface HNDSubwayLineFilterViewController() <UITableViewDataSource,
                                                UITableViewDelegate>

// Casts self.view
@property(nonatomic) HNDSubwayListView *view;

@property(nonatomic) HNDSubwayLinesList *subwayList;

@end

@implementation HNDSubwayLineFilterViewController

#pragma mark - Overrides

- (void)loadView {
  self.view = [[HNDSubwayListView alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  _subwayList = [[HNDSubwayLinesList alloc] init];
  [self setupViews];
}

#pragma mark - Protocols
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.subwayList.lines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HNDSubwayLineCell *cell =
      [self.view.subwayLinesTableView dequeueReusableCellWithIdentifier:kSubwayLineCellId];
  return [self configureCell:cell atIndexPath:indexPath];
}

- (UITableViewCell *)configureCell:(HNDSubwayLineCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  HNDSubwayLine *subwayLine = self.subwayList.lines[indexPath.row];
  cell.lineLabel.text = subwayLine.lineText;
  cell.backgroundColor = subwayLine.lineColor;
  return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"Touch me ;]");
}

#pragma mark - Private

- (void)setupViews {
  self.view.subwayLinesTableView.dataSource = self;
  self.view.subwayLinesTableView.delegate = self;
}

@end
