#import <UIKit/UIKit.h>

// TODO: Don't use a button.
@class HNDButton;

@interface HNDStationDetailView : UIView
@property(nonatomic, readonly, weak) UITableView *tableView;
@property(nonatomic, readonly, weak) HNDButton *outageButton;
@end
