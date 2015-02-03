#import "HNDSubwayLineFilterViewController.h"

#import "HNDColor.h"
#import "HNDMapFlow.h"
#import "HNDSubwayLine.h"
#import "HNDSubwayLinesList.h"
#import "HNDSubwayListView.h"
@interface HNDSubwayLineFilterViewController() <UITableViewDataSource,
                                                UITableViewDelegate>
@property(nonatomic) HNDSubwayLinesList *subwayList;
// Casts self.view
@property(nonatomic) HNDSubwayListView *view;
// Makes readonly into readwrite.
@property(nonatomic, readwrite) HNDSubwayLine *selectedLine;
@property(nonatomic, readwrite) UITableViewCell *selectedCell;
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
  HNDSubwayLine *subwayLine = self.subwayList.lines[indexPath.row];
  return [self configureCell:cell withLine:subwayLine];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.selectedLine = (indexPath.row < self.subwayList.lines.count)
      ? self.subwayList.lines[indexPath.row] : nil;
  self.selectedCell = [self.view.subwayLinesTableView cellForRowAtIndexPath:indexPath];
  [self.flow presentNext:self];
}

#pragma mark - TargetActions

- (void)showAppInfo:(UIButton *)sender {
  [self.flow presentAppInfo:self];
}

#pragma mark - Private

- (void)setupViews {
  self.view.subwayLinesTableView.dataSource = self;
  self.view.subwayLinesTableView.delegate = self;

  UIImage *gpsImage =
  [[UIImage imageNamed:@"info-32"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  UIImageView *infoView = [[UIImageView alloc] initWithImage:gpsImage];
  infoView.tintColor = [HNDColor lightColor];
  infoView.contentMode = UIViewContentModeScaleAspectFit;
  self.navigationItem.rightBarButtonItem =
  [[UIBarButtonItem alloc] initWithImage:gpsImage
                                   style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(showAppInfo:)];
}

- (UITableViewCell *)configureCell:(HNDSubwayLineCell *)cell withLine:(HNDSubwayLine *)subwayLine {
  cell.lineLabel.text = subwayLine.lineText;
  cell.lineLabel.textColor = subwayLine.lineColor;
  return cell;
}


@end
