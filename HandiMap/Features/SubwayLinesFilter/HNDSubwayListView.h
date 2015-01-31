#import <UIKit/UIKit.h>

extern NSString *const kSubwayLineCellId;

@interface HNDSubwayLineCell : UITableViewCell
@property(nonatomic, readonly) UILabel *lineLabel;
@end

@interface HNDSubwayListView : UIView
@property(nonatomic, readonly) UITableView *subwayLinesTableView;
@end
