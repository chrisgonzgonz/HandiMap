#import <UIKit/UIKit.h>

extern NSString *const kSubwayLineCellId;

@interface HNDSubwayLineCell : UITableViewCell
@end

@interface HNDSubwayListView : UIView
@property(nonatomic, readonly) UITableView *subwayLinesTableView;
@end
