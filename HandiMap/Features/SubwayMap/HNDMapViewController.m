#import "HNDMapViewController.h"

#import "HNDSubwayMapView.h"
#import <MapKit/MapKit.h>
#import "HNDCoreDataManager.h"
#import "HNDOutage.h"
#import "HNDStation.h"

@interface HNDMapViewController () <MKMapViewDelegate>

@property(nonatomic) HNDMapFlow *flow;
@property(nonatomic) HNDSubwayMapView *view;

@end

@implementation HNDMapViewController

- (instancetype)initInFlow:(HNDMapFlow *)flow {
  if (self = [super init]) {
    _flow = flow;
  }
  return self;
}

- (void)loadView {
  self.view = [[HNDSubwayMapView alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.mapView.delegate = self;
}

@end
