#import <UIKit/UIKit.h>

// TODO: Don't use a button.
@class HNDLabel;

@interface HNDStationDetailView : UIView
@property(nonatomic, readonly, weak) UITableView *tableView;
@property(nonatomic, readonly, weak) HNDLabel *titleView;
@end
