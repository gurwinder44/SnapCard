//
//  ScanQRViewController.h
//  Snapcard
//
//  Created by Pravin on 4/10/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ScanQRViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate,CLLocationManagerDelegate>
{
    UserProfile *user;
    UserProfile *friendScanned;
    NSString *scannedUserID;
    CLLocationManager *locationmanager;
    BOOL isLocUpdating;
}

@end
