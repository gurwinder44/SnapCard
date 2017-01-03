//
//  NearMe.h
//  Snapcard
//
//  Created by Pravin on 4/7/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"
#import <CoreBluetooth/CoreBluetooth.h>
@import CoreLocation;


typedef NS_ENUM(NSInteger, EDReason) {
    EDReasonNoBluetooth,
    EDReasonNoPeople,
    EDPerfect,
    EDLoading,
    EDRanging
};

@interface NearMe : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,CBCentralManagerDelegate>
{
    EDReason reason;
    UIRefreshControl *refreshControl;
    NSMutableArray *allPeople;
    UILabel *mobilePhone;
    PulsingHaloLayer *halo;
    CBCentralManager *bluetoothManager;
    int BeaconID;
}
@property (nonatomic,strong) CLLocationManager *manager;
@property (nonatomic,strong) NSMutableArray *tblItems;
@property (nonatomic,strong) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) IBOutlet UITableView *tblView;

@end
