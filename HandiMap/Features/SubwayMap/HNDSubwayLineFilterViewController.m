#import "HNDSubwayLineFilterViewController.h"

#import "HNDColor.h"
#import "HNDMapFlow.h"
#import "HNDSubwayLine.h"
#import "HNDSubwayLinesList.h"
#import "HNDSubwayListView.h"

static NSString *const kNoFilterText = @"All Lines";

@interface HNDSubwayLineFilterViewController() <UITableViewDataSource,
                                                UITableViewDelegate>
@property(nonatomic) HNDSubwayLinesList *subwayList;
// Casts self.view
@property(nonatomic) HNDSubwayListView *view;
// Makes readonly into readwrite.
@property(nonatomic, readwrite) HNDSubwayLine *selectedLine;
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
  return self.subwayList.lines.count + 1; // Adds 1 for no filter.
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HNDSubwayLineCell *cell =
      [self.view.subwayLinesTableView dequeueReusableCellWithIdentifier:kSubwayLineCellId];
  return [self configureCell:cell atIndexPath:indexPath];
}

- (UITableViewCell *)configureCell:(HNDSubwayLineCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row < self.subwayList.lines.count) {
    HNDSubwayLine *subwayLine = self.subwayList.lines[indexPath.row];
    cell.lineLabel.text = subwayLine.lineText;
    cell.lineLabel.textColor = subwayLine.lineColor;
  } else {
    cell.lineLabel.text = kNoFilterText;
    cell.lineLabel.textColor = [HNDColor grayColor];
  }
  return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"I like it when you touch me ;}");
//  [self.flow presentNext:self];
}

#pragma mark - Private

- (void)setupViews {
  self.view.subwayLinesTableView.dataSource = self;
  self.view.subwayLinesTableView.delegate = self;
}

@end
