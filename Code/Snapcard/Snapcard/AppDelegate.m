 //
//  AppDelegate.m
//  Snapcard
//
//  Created by Pravin on 3/30/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UserProfile* user=[[CommonUtils sharedInstance] loadUserProfile];
    if(!user){
        user=[[UserProfile alloc] init];
        [[CommonUtils sharedInstance] saveUserProfile:user];
    }
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
    UINavigationController *navigationController = (UINavigationController *) self.window.rootViewController;
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if ([[CommonUtils sharedInstance] isOnBoardingDone]) {
        // Show the dashboard
        [navigationController pushViewController:[story instantiateViewControllerWithIdentifier:@"HomeTabbarControllerID"] animated:NO];
    } else {
        // Login
        [navigationController pushViewController:[story instantiateViewControllerWithIdentifier:@"OnboardPageViewID"] animated:NO];
    }
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings // available in iOS8
{
    [application registerForRemoteNotifications];
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString * token = [NSString stringWithFormat:@"%@", deviceToken];
    //Format token as you need:
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSLog(@"%@",token);
    
    UserProfile* user=[[CommonUtils sharedInstance] loadUserProfile];
    user.deviceToken=token;
    [[CommonUtils sharedInstance] saveUserProfile:user];
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSString *mes=[userInfo valueForKey:@"message"];
    NSLog(@"%@",mes);
    
    NSData *data = [mes dataUsingEncoding:NSUTF8StringEncoding];
    if(!notificationDictionary){notificationDictionary=[[NSMutableDictionary alloc] init];}
    notificationDictionary= [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self getSessionID];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Error:%@",error);
}


-(void)getSessionID{
    NSString *serviceUrl=@"https://login.salesforce.com/services/oauth2/token?grant_type=password&username=praveen@mysalesforce.com&password=drink7upXkgb1lfLYThQmkYeEvRn1hpM&client_id=3MVG9uudbyLbNPZN4t1Fi5Ct0Y7sqjTPVZpl4m4crJUYFO4wWFNI1yoAg5Jr3Hg3qrkiygBwqHMcFgpnx3Tkr&client_secret=8109137341775776726";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:serviceUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [self getUser:[notificationDictionary objectForKey:@"userid"] andresponseObject:responseObject];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
    }];
}





-(void)getUser:(NSString *)uuid andresponseObject:(id)responseObject{
    
    //Setup
    NSString *instanceUrl1=[responseObject objectForKey:@"instance_url"];
    NSString *accessToken1=[responseObject objectForKey:@"access_token"];
    NSString *url=[NSString stringWithFormat:@"%@/services/apexrest/memberdata",instanceUrl1];
    NSString *urlToken=[NSString stringWithFormat:@"OAuth %@",accessToken1];
    
    NSString *serviceUrl= [NSString stringWithFormat:@"https://na30.salesforce.com/services/data/v20.0/sobjects/SnapCard__c/UserID__c/%@",uuid];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{@"Content-Type": @"application/json"};
    configuration.HTTPAdditionalHeaders = @{@"Authorization": urlToken};
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:serviceUrl] sessionConfiguration:configuration];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager GET:serviceUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        UserProfile *user=[[CommonUtils sharedInstance] loadUserProfile];
        UserProfile *friendScanned;
        if(friendScanned==nil){friendScanned=[[UserProfile alloc] init];}
        
        friendScanned.firstName=[responseObject objectForKey:@"Name"];
        friendScanned.phoneNumber=[responseObject objectForKey:@"Phone__c"];
        friendScanned.userid=[responseObject objectForKey:@"UserID__c"];
        friendScanned.companyOrInstitution=[responseObject objectForKey:@"CompanyInstitution__c"];
        friendScanned.designation=[responseObject objectForKey:@"Designation__c"];
        friendScanned.email=[responseObject objectForKey:@"Email__c"];
        
        friendScanned.homelocationAddress=[responseObject objectForKey:@"HomeLocation__c"];
        friendScanned.peronalURL=[responseObject objectForKey:@"personalURL__c"];
        
        friendScanned.facebookID=[responseObject objectForKey:@"FacebookID__c"];
        friendScanned.twitterID=[responseObject objectForKey:@"TwitterID__c"];
        friendScanned.instagramID=[responseObject objectForKey:@"InstagramID__c"];;
        friendScanned.pintrestID=[responseObject objectForKey:@"PintrestID__c"];
        friendScanned.gitHubID=[responseObject objectForKey:@"GitHubID__c"];
        friendScanned.snapchatID=[responseObject objectForKey:@"SnapChatID__c"];
        friendScanned.linkedinID=[responseObject objectForKey:@"LinkedInID__c"];
        friendScanned.deviceToken=[responseObject objectForKey:@"Device_Token__c"];
        
        NSString *locationString =[notificationDictionary objectForKey:@"location"];
        NSArray* foo = [locationString componentsSeparatedByString: @","];
        float lati=[[foo objectAtIndex:0] floatValue];
        float longi=[[foo objectAtIndex:1] floatValue];
        CLLocation *location=[[CLLocation alloc] initWithLatitude:lati longitude:longi];
        friendScanned.meetingLocation=location;
        
        // Add Image
        NSData *data = [[NSData alloc]initWithBase64EncodedString:[responseObject objectForKey:@"ProfilePicText__c"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *img=[UIImage imageWithData:data];
        [self saveImage:img withUserID:friendScanned.userid];
        
        if(user.friends){
            [user.friends addObject:friendScanned];}
        else{
            user.friends=[[NSMutableArray alloc] init];
            [user.friends addObject:friendScanned];}
        
        
        [[CommonUtils sharedInstance] saveUserProfile:user];
        NSString *alertMessage=[NSString stringWithFormat:@"%@ added as a Friend",friendScanned.firstName];
        [[CommonUtils sharedInstance] showAlertViewInVisiblePage:alertMessage];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"False");
    }];
}



-(void)saveImage:(UIImage*)img withUserID:(NSString*) userID{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullName=[NSString stringWithFormat:@"%@.jpg",userID];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:fullName];
    NSData *imageData = UIImageJPEGRepresentation(img, 1);
    [imageData writeToFile:savedImagePath atomically:YES];
}


@end
