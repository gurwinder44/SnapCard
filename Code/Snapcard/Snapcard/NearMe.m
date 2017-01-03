//
//  NearMe.m
//  Snapcard
//
//  Created by Pravin on 4/7/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "NearMe.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface NearMe ()
{
    BOOL isRanging;
}
@end

@implementation NearMe


- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        FAKFontAwesome *sel=[FAKFontAwesome mapMarkerIconWithSize:30];
        [sel addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
        FAKFontAwesome *unsel=[FAKFontAwesome mapMarkerIconWithSize:30];
        [unsel addAttribute:NSForegroundColorAttributeName value:[UIColor lightThemeColor]];
        
        UIImage *selectedImage=[sel imageWithSize:CGSizeMake(30, 30)];
        UIImage *unselectedImage=[unsel imageWithSize:CGSizeMake(30, 30)];
        
        self.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"Near Me" image:unselectedImage selectedImage:selectedImage];
        [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    isRanging=FALSE;
    allPeople=[[NSMutableArray alloc] init];
    [_tblView setDelegate:self];
    [_tblView setDataSource:self];
    [[CommonUtils sharedInstance] SetUpNavControllerWithid:self andTitle:@"NearMe"];
    bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self
                                                             queue:nil
                                                           options:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0]
                                                                                               forKey:CBCentralManagerOptionShowPowerAlertKey]];
    
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    [self.manager requestAlwaysAuthorization];
    
    
    reason=EDLoading;
    self.tblView.emptyDataSetSource = self;
    self.tblView.emptyDataSetDelegate = self;
    self.tblView.tableFooterView=[UIView new];
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor clearColor];
    refreshControl.tintColor = [UIColor themeColor];
    [refreshControl addTarget:self
                       action:@selector(reloadTable)
             forControlEvents:UIControlEventValueChanged];
    [self.tblView addSubview:refreshControl];
    [_tblView setBackgroundColor:[UIColor lightThemeColor]];
    
}

-(void)reloadTable{
    if (reason==EDRanging){
        [self getSessionID:2];
    }
    [_tblView reloadData];
}


#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    // This delegate method will monitor for any changes in bluetooth state and respond accordingly
    NSString *stateString = nil;
    switch(bluetoothManager.state)
    {
        case CBCentralManagerStateResetting: stateString =
            @"The connection with the system service was momentarily lost, update imminent."; break;
        case CBCentralManagerStateUnsupported: stateString =
            @"The platform doesn't support Bluetooth Low Energy."; break;
        case CBCentralManagerStateUnauthorized: stateString =
            @"The app is not authorized to use Bluetooth Low Energy."; break;
        case CBCentralManagerStatePoweredOff:
        {
            reason=EDReasonNoBluetooth;
            [_tblView reloadData];
            break;
        }
        case CBCentralManagerStatePoweredOn:
        {
            reason=EDPerfect;
            [self startMoniteringBeacon];
            break;
        }
        default: stateString = @"State unknown, update imminent."; break;
    }
    NSLog(@"Bluetooth State: %@",stateString);
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
   
   self.tabBarController.navigationItem.title=@"Near Me";
}


-(void)startMoniteringBeacon{
    NSLog(@"Monitering beacon");
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"F7826DA6-4FA2-4E98-8024-BC5B71E0893E"];
        // Create the beacon region to be monitored.
        self.beaconRegion = [[CLBeaconRegion alloc]
                                        initWithProximityUUID:uuid
                                        identifier:@"ID"];
    self.beaconRegion.notifyEntryStateOnDisplay = YES;
    self.beaconRegion.notifyOnEntry = YES;
    self.beaconRegion.notifyOnExit = YES;
        // Register the beacon region with the location manager.
        [self.manager startMonitoringForRegion:self.beaconRegion];
        [self.manager startRangingBeaconsInRegion:self.beaconRegion];
}


- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    NSLog(@"Failed monitoring region: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location manager failed: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    CLBeacon *foundBeacon = [beacons firstObject];
    if(!isRanging){
        [[CommonUtils sharedInstance] showActivityIndicatorWithString:@"Beacon found"];
        isRanging=TRUE;
        reason=EDRanging;
        BeaconID= [foundBeacon.major intValue];
        [self getSessionID:1];
        NSLog(@"Ranging Beacon");
    }
}

- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion*)region
{
    NSLog(@"Enter Beacon");
 
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion*)region
{
    isRanging=FALSE;
    NSLog(@"Exit Beacon");
    [self.manager stopRangingBeaconsInRegion:self.beaconRegion];
}



-(void)getSessionID:(int)mode{
    NSString *serviceUrl=@"https://login.salesforce.com/services/oauth2/token?grant_type=password&username=praveen@mysalesforce.com&password=drink7upXkgb1lfLYThQmkYeEvRn1hpM&client_id=3MVG9uudbyLbNPZN4t1Fi5Ct0Y7sqjTPVZpl4m4crJUYFO4wWFNI1yoAg5Jr3Hg3qrkiygBwqHMcFgpnx3Tkr&client_secret=8109137341775776726";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:serviceUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if(mode==1){
            [self secondService:responseObject];
        }
        else if(mode==2){
            [self getBeaconID:@"0" andresponseObject:responseObject];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
    }];
}


-(void)secondService:(id)responseObject{
    
    //Setup
    [[CommonUtils sharedInstance] hideActivityIndicator];
    NSString *instanceUrl1=[responseObject objectForKey:@"instance_url"];
    NSString *accessToken1=[responseObject objectForKey:@"access_token"];
    NSString *url=[NSString stringWithFormat:@"%@/services/apexrest/memberdata",instanceUrl1];
    NSString *urlToken=[NSString stringWithFormat:@"OAuth %@",accessToken1];
    
    
    UIImage *image=[self retriveImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    NSString *stringImage = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    UserProfile *user=[[CommonUtils sharedInstance] loadUserProfile];
    [[CommonUtils sharedInstance] saveUserProfile:user];
    NSMutableDictionary *inputJSON=[[NSMutableDictionary alloc]init];
    [inputJSON setValue:user.userid forKey:@"UserID"];
    [inputJSON setValue:user.firstName forKey:@"Name"];
    [inputJSON setValue:user.email forKey:@"Email"];
    [inputJSON setValue:user.phoneNumber forKey:@"PhoneNumber"];
    [inputJSON setValue:user.designation forKey:@"designation"];
    [inputJSON setValue:user.companyOrInstitution forKey:@"companyOrInstitution"];
    [inputJSON setValue:stringImage forKey:@"ProfilePicture"];
    NSNumber *Beaint=[NSNumber numberWithInt:BeaconID];
    [inputJSON setValue:Beaint forKey:@"BeaconID"];
    
    
    //Other Basics Information
    [inputJSON setValue:user.peronalURL forKey:@"peronalURL"];
    [inputJSON setValue:user.homelocationAddress forKey:@"homelocation"];
    [inputJSON setValue:@"0" forKey:@"officeLocation"];
    
    //Social Information
    [inputJSON setValue:user.facebookID forKey:@"facebookID"];
    [inputJSON setValue:user.twitterID forKey:@"twitterID"];
    [inputJSON setValue:user.instagramID forKey:@"instagramID"];
    [inputJSON setValue:user.pintrestID forKey:@"pintrestID"];
    [inputJSON setValue:user.linkedinID forKey:@"linkedinID"];
    [inputJSON setValue:user.gitHubID forKey:@"gitHubID"];
    [inputJSON setValue:user.snapchatID forKey:@"snapchatID"];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:inputJSON
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{@"Content-Type": @"application/json"};
    configuration.HTTPAdditionalHeaders = @{@"Authorization": urlToken};
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url] sessionConfiguration:configuration];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager POST:url parameters:inputJSON progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [[CommonUtils sharedInstance] hideActivityIndicator];
        [[CommonUtils sharedInstance] showActivityIndicatorWithString:@"Gathering Nearby People"];
        [self getSessionID:2];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"False");
    }];
}


-(void)getBeaconID:(NSString *)beaconID andresponseObject:(id)responseObject{
    
    //Setup
    NSString *instanceUrl1=[responseObject objectForKey:@"instance_url"];
    NSString *accessToken1=[responseObject objectForKey:@"access_token"];
    NSString *url=[NSString stringWithFormat:@"%@/services/apexrest/memberdata",instanceUrl1];
    NSString *urlToken=[NSString stringWithFormat:@"OAuth %@",accessToken1];
    
    
//    NSString *serviceUrl=@"https://na30.salesforce.com/services/data/v36.0/query/?q=SELECT+Name,UserID__c ,Designation__c,CompanyInstitution__c , ProfilePicText__c , Device_Token__c , Phone__c +FROM+SnapCard__c+WHERE+BeaconID__c+=+'0'";
    NSString * serviceUrl=[NSString stringWithFormat:@"https://na30.salesforce.com/services/data/v36.0/query/?q=SELECT+Name,UserID__c ,Designation__c,CompanyInstitution__c , ProfilePicText__c , Device_Token__c , Phone__c +FROM+SnapCard__c+WHERE+BeaconID__c+=+'%d'",BeaconID];
    NSString *encoded = [serviceUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{@"Content-Type": @"application/json"};
    configuration.HTTPAdditionalHeaders = @{@"Authorization": urlToken};
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:serviceUrl] sessionConfiguration:configuration];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager GET:encoded parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        allPeople=[responseObject objectForKey:@"records"];
        [_tblView reloadData];
        [[CommonUtils sharedInstance] hideActivityIndicator];
        [refreshControl endRefreshing];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"False");
    }];
}


-(UIImage*)retriveImage{
    NSString *fullName;
    fullName=@"myPhoto.jpg";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:fullName];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:savedImagePath];
    if(fileExists){
        NSData *imgData = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:savedImagePath]];
        UIImage *thumbNail = [[UIImage alloc] initWithData:imgData];
        return thumbNail;
    }
    return nil;
}


#pragma mark TableView Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return allPeople.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BeaconCellID"];
    UIImageView *proImg=[cell viewWithTag:1];
    UILabel *name=[cell viewWithTag:2];
    UILabel *designation=[cell viewWithTag:3];
    
    [name setText:[[allPeople objectAtIndex:indexPath.row] objectForKey:@"Name"]];
    [designation setText:[[allPeople objectAtIndex:indexPath.row] objectForKey:@"Designation__c"]];
    NSData *data = [[NSData alloc]initWithBase64EncodedString:[[allPeople objectAtIndex:indexPath.row] objectForKey:@"ProfilePicText__c"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
    [proImg setImage:[UIImage imageWithData:data]];
    [proImg.layer setCornerRadius:proImg.frame.size.width/2];
    return cell;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Oops";
    switch (reason) {
        case EDReasonNoPeople:
            text=@"Looking for Beacons";
            break;
        case EDReasonNoBluetooth:
            text=@"No Bluetooth";
            break;
        case EDLoading:
            text=@"Loading...";
    }
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}



- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"";
    switch (reason) {
        case EDReasonNoPeople:
            text = @"No Beacons Found";
            break;
        case EDReasonNoBluetooth:
            text=@"Please turn on the Bluetooth";
            break;
    }
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor whiteColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}



@end
