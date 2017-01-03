//
//  CommonUtils.h
//  Grabfree
//
//  Created by Pravin on 12/20/15.
//  Copyright (c) 2015 Grabfree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfile.h"

@interface CommonUtils : NSObject




//*****************  Device Token *****************************
- (void)saveDeviceToken:(NSData *)object;
- (NSString *)loadDeviceToken;

//*****************  User Profile *****************************
- (void)saveUserProfile:(UserProfile *)object;
- (UserProfile *)loadUserProfile;

//*****************  User Default *****************************
-(NSString *)Load_Stringfrom_UserDefaultWithKey:(NSString *)key;


//*****************  Navigation Bar *****************************
-(void)SetUpNavControllerWithid:(UIViewController *)delegate andTitle:(NSString*)title;
-(void)Save_StringTo_UserDefault:(NSString*)object andKey:(NSString *)key;


//*****************  Activity Indicator *****************************
-(void)showActivityIndicatorWithString:(NSString*)string;
-(void)hideActivityIndicator;

//***************** Miscellaneous *****************************
+ (CommonUtils *)sharedInstance;
-(BOOL)isOnBoardingDone;
-(void)setBoardingDone;

//***************** Miscellaneous *****************************
-(void)showAlertViewInVisiblePage:(NSString *) titleString;


@end
