//
//  HomeLocationSelect.h
//  Snapcard
//
//  Created by Pravin on 4/19/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HomeLocationSelect : UIViewController<MKMapViewDelegate,MKAnnotation,MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocation *currentLocation;
    CLLocation *homeLocation;
    MKPointAnnotation *annotationPoint;
    NSString *fullAddress;
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    BOOL isUpdateOnce;
}
@property (nonatomic) int modeOfEntry;
@property (nonatomic) NSUInteger pageIndex;
@end
