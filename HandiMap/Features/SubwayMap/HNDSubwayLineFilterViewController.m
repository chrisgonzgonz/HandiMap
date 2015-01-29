#import "HNDSubwayLineFilterViewController.h"

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
  return [[UITableViewCell alloc] init];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - Private

- (void)setupViews {

}

@end
