//
//  ProfileShow.m
//  Snapcard
//
//  Created by Pravin on 4/18/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "ProfileShow.h"

@interface ProfileShow ()

@end

@implementation ProfileShow

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        FAKFontAwesome *sel=[FAKFontAwesome userIconWithSize:30];
        [sel addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
        FAKFontAwesome *unsel=[FAKFontAwesome userIconWithSize:30];
        [unsel addAttribute:NSForegroundColorAttributeName value:[UIColor lightThemeColor]];
        
        UIImage *selectedImage=[sel imageWithSize:CGSizeMake(30, 30)];
        UIImage *unselectedImage=[unsel imageWithSize:CGSizeMake(30, 30)];
        
        self.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"Profile" image:unselectedImage selectedImage:selectedImage];
        [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    user=[[CommonUtils sharedInstance] loadUserProfile];
    [[CommonUtils sharedInstance] SetUpNavControllerWithid:self andTitle:@"Profile"];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor darkThemeColor]];
    [self.view setNeedsLayout];
    [editInfoBtn.layer setCornerRadius:10.0f];

    
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title=@"Profile";
    CardView2 *cardView = [[[NSBundle mainBundle] loadNibNamed:@"CardView2" owner:self options:nil] objectAtIndex:0];
    cardView.user=[[CommonUtils sharedInstance] loadUserProfile];
    [cardView setFrame:cardHolder.bounds];
    [cardHolder addSubview:cardView];
    [self getSessionID];
}


-(void)getSessionID{
    NSString *serviceUrl=@"https://login.salesforce.com/services/oauth2/token?grant_type=password&username=praveen@mysalesforce.com&password=drink7upXkgb1lfLYThQmkYeEvRn1hpM&client_id=3MVG9uudbyLbNPZN4t1Fi5Ct0Y7sqjTPVZpl4m4crJUYFO4wWFNI1yoAg5Jr3Hg3qrkiygBwqHMcFgpnx3Tkr&client_secret=8109137341775776726";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:serviceUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        [self secondService:responseObject];
        //[self getUser:@"9F2F3D18-B735-45AC-8E38-D55976212CB5" andresponseObject:responseObject];
       // [self getBeaconID:@"0" andresponseObject:responseObject];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
    }];
}



-(void)getUser:(NSString *)uuid andresponseObject:(id)responseObject{
    
    //Setup
    NSString *instanceUrl1=[responseObject objectForKey:@"instance_url"];
    NSString *accessToken1=[responseObject objectForKey:@"access_token"];
    NSString *url=[NSString stringWithFormat:@"%@/services/apexrest/memberdata",instanceUrl1];
    NSString *urlToken=[NSString stringWithFormat:@"OAuth %@",accessToken1];
    
    
    
       NSString *serviceUrl=@"https://na30.salesforce.com/services/data/v20.0/sobjects/SnapCard__c/UserID__c/9F2F3D18-B735-45AC-8E38-D55976212CB5";
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{@"Content-Type": @"application/json"};
    configuration.HTTPAdditionalHeaders = @{@"Authorization": urlToken};
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:serviceUrl] sessionConfiguration:configuration];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager GET:serviceUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"Success");
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Falser");
    }];
}



-(void)getBeaconID:(NSString *)beaconID andresponseObject:(id)responseObject{
    
    //Setup
    NSString *instanceUrl1=[responseObject objectForKey:@"instance_url"];
    NSString *accessToken1=[responseObject objectForKey:@"access_token"];
    NSString *url=[NSString stringWithFormat:@"%@/services/apexrest/memberdata",instanceUrl1];
    NSString *urlToken=[NSString stringWithFormat:@"OAuth %@",accessToken1];
    
    
    
    NSString *serviceUrl=@"https://na30.salesforce.com/services/data/v35.0/query/?q= SELECT+Name+FROM+ SnapCard__c+WHERE+BeaconID__c+=+'0'";
    NSString *encoded = [serviceUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{@"Content-Type": @"application/json"};
    configuration.HTTPAdditionalHeaders = @{@"Authorization": urlToken};
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:serviceUrl] sessionConfiguration:configuration];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager GET:encoded parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"Success");
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Falser");
    }];
}

-(void)secondService:(id)responseObject{
    
    //Setup
    NSString *instanceUrl1=[responseObject objectForKey:@"instance_url"];
    NSString *accessToken1=[responseObject objectForKey:@"access_token"];
    NSString *url=[NSString stringWithFormat:@"%@/services/apexrest/memberdata",instanceUrl1];
    NSString *urlToken=[NSString stringWithFormat:@"OAuth %@",accessToken1];
    

    UIImage *image=[UIImage imageNamed:@"propic.jpg"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    NSString *stringImage = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

    
    NSMutableDictionary *inputJSON=[[NSMutableDictionary alloc]init];
    [inputJSON setValue:[[NSUUID UUID] UUIDString] forKey:@"UserID"];
    [inputJSON setValue:user.firstName forKey:@"Name"];
    [inputJSON setValue:user.email forKey:@"Email"];
    [inputJSON setValue:user.phoneNumber forKey:@"PhoneNumber"];
    [inputJSON setValue:user.designation forKey:@"designation"];
    [inputJSON setValue:user.companyOrInstitution forKey:@"companyOrInstitution"];
    [inputJSON setValue:stringImage  forKey:@"ProfilePicture"];
    [inputJSON setValue:@"0" forKey:@"BeaconID"];
    [inputJSON setValue:@"0" forKey:@"CompanyInstitution"];
    
    
    //Other Basics Information
    [inputJSON setValue:user.peronalURL forKey:@"peronalURL"];
    [inputJSON setValue:@"0" forKey:@"homelocation"];
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
    
    NSString* actualData= [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{@"Content-Type": @"application/json"};
    configuration.HTTPAdditionalHeaders = @{@"Authorization": urlToken};
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url] sessionConfiguration:configuration];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager POST:url parameters:inputJSON progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"Success");
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Falser");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)editbtnClicked:(id)sender {
}
@end
