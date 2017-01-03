//
//  ScanQRViewController.m
//  Snapcard
//
//  Created by Pravin on 4/10/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "ScanQRViewController.h"

@interface ScanQRViewController ()
@property (nonatomic) BOOL isReading;
@property (strong, nonatomic) IBOutlet UIView *scannerView;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation ScanQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isReading = NO;
    _captureSession = nil;
    [self loadBeepSound];
    [self startReading];
    user=[[CommonUtils sharedInstance] loadUserProfile];
    NSLog(@"sd");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)startReading {
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];

    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_scannerView.layer.bounds];
    [_scannerView.layer addSublayer:_videoPreviewLayer];
    [_captureSession startRunning];

    return YES;
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    CGRect highlightViewRect = CGRectZero;
    NSString *detectionString = nil;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            barCodeObject = (AVMetadataMachineReadableCodeObject *)[_videoPreviewLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadataObj];
            highlightViewRect = barCodeObject.bounds;
            detectionString = [(AVMetadataMachineReadableCodeObject *)metadataObj stringValue];
            [self stopReading];
            [self getSessionIDanduserWithID:detectionString];
            _isReading = NO;
            if (_audioPlayer) {
                [_audioPlayer play];
            }
        }
    }
    _scannerView.frame = highlightViewRect;
}


-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
}



-(void)loadBeepSound{
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    NSError *error;
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        [_audioPlayer prepareToPlay];
    }
}




#pragma mark Service Calls

-(void)getSessionIDanduserWithID:(NSString*)userID{
    NSString *serviceUrl=@"https://login.salesforce.com/services/oauth2/token?grant_type=password&username=praveen@mysalesforce.com&password=drink7upXkgb1lfLYThQmkYeEvRn1hpM&client_id=3MVG9uudbyLbNPZN4t1Fi5Ct0Y7sqjTPVZpl4m4crJUYFO4wWFNI1yoAg5Jr3Hg3qrkiygBwqHMcFgpnx3Tkr&client_secret=8109137341775776726";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:serviceUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [self getUser:userID andresponseObject:responseObject];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
    }];
}

-(void)getUser:(NSString *)uuid andresponseObject:(id)responseObject{
    
    //Setup
    NSString *instanceUrl1=[responseObject objectForKey:@"instance_url"];
    NSString *accessToken1=[responseObject objectForKey:@"access_token"];
    NSString *urlToken=[NSString stringWithFormat:@"OAuth %@",accessToken1];
    
    
    NSString *serviceUrl=[NSString stringWithFormat:@"https://na30.salesforce.com/services/data/v20.0/sobjects/SnapCard__c/UserID__c/%@",uuid];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{@"Content-Type": @"application/json"};
    configuration.HTTPAdditionalHeaders = @{@"Authorization": urlToken};
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:serviceUrl] sessionConfiguration:configuration];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager GET:serviceUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"Success");
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
        

    
        // Add Image
        NSData *data = [[NSData alloc]initWithBase64EncodedString:[responseObject objectForKey:@"ProfilePicText__c"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *img=[UIImage imageWithData:data];
        [self saveImage:img withUserID:friendScanned.userid];
        
        
        //Add Location
        if(!locationmanager){locationmanager=[[CLLocationManager alloc] init];}
        locationmanager.delegate=self;
        isLocUpdating=false;
        [locationmanager startUpdatingLocation];
        

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


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if(!isLocUpdating){
        isLocUpdating=TRUE;
        friendScanned.meetingLocation=[locations objectAtIndex:0];
        
        // Add to List
        if(user.friends){
            [user.friends addObject:friendScanned];}
        else{
            user.friends=[[NSMutableArray alloc] init];
            [user.friends addObject:friendScanned];}
        
        [[CommonUtils sharedInstance] saveUserProfile:user];
        [locationmanager stopUpdatingLocation];
        
        [self sendNotificationtoFriendwithLocation:friendScanned.meetingLocation andUserID:user.userid anddeviceToken:friendScanned.deviceToken];
    }
}


-(void)sendNotificationtoFriendwithLocation:(CLLocation *)location andUserID:(NSString*)userID anddeviceToken:(NSString*) deviceToken{
    
    NSString *locationString=[NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
    NSString *serviceUrl=[NSString stringWithFormat:@"http://52.37.195.136/mcproject/Getnotifications?location=%@&userid=%@&devicetoken=%@",locationString,userID,deviceToken];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:serviceUrl] sessionConfiguration:configuration];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager GET:serviceUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [self.navigationController popViewControllerAnimated:YES];
        [[CommonUtils sharedInstance] showAlertViewInVisiblePage:@"Friend Added"];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"False");
    }];
}

@end
