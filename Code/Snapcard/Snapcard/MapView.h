//
//  MapView.h
//  Snapcard
//
//  Created by Pravin on 4/8/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapView : UIView<MKMapViewDelegate,CLLocationManagerDelegate>
{
    UserProfile *user;
    IBOutlet MKMapView *mapView;
    CLLocationManager *locationManager;
    BOOL isupdating;
}
@end
