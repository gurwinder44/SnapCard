//
//  CreateAddProPic.m
//  Snapcard
//
//  Created by Pravin on 4/24/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "CreateAddProPic.h"

@interface CreateAddProPic ()
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UIButton *photoLibrary;
@property (strong, nonatomic) IBOutlet UIButton *Camerabtn;
@property (strong, nonatomic) IBOutlet UIButton *thatsAllbtn;

@end

@implementation CreateAddProPic

- (void)viewDidLoad {
    [super viewDidLoad];
    [_Camerabtn.layer setCornerRadius:10.0f];
    [_photoLibrary.layer setCornerRadius:10.0f];
    [_thatsAllbtn.layer setCornerRadius:10.0f];
    [_imgView.layer setCornerRadius:self.imgView.frame.size.height];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)btnPhotoClicked:(id)sender {
    if(imagePickerController==nil){
        imagePickerController = [[UIImagePickerController alloc]init];}
    imagePickerController.delegate = self;
    [imagePickerController setAllowsEditing:YES];
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (IBAction)btnCameraClicked:(id)sender {
    if(imagePickerController==nil){
        imagePickerController = [[UIImagePickerController alloc]init];}
    [imagePickerController setAllowsEditing:YES];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

-(void)saveImage:(UIImage*)img{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"myPhoto.jpg"];
    NSData *imageData = UIImageJPEGRepresentation(img, 0.3);
    [imageData writeToFile:savedImagePath atomically:YES];
}

-(UIImage*)retriveImage{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"myPhoto.jpg"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:savedImagePath];
    if(fileExists){
        NSData *imgData = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:savedImagePath]];
        UIImage *thumbNail = [[UIImage alloc] initWithData:imgData];
        return thumbNail;
    }
    return nil;
}


- (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize {
    CGAffineTransform scaleTransform;
    CGPoint origin;
    
    if (image.size.width > image.size.height) {
        CGFloat scaleRatio = newSize / image.size.height;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        origin = CGPointMake(-(image.size.width - image.size.height) / 2.0f, 0);
    } else {
        CGFloat scaleRatio = newSize / image.size.width;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        origin = CGPointMake(0, -(image.size.height - image.size.width) / 2.0f);
    }
    CGSize size = CGSizeMake(newSize, newSize);
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, scaleTransform);
    [image drawAtPoint:origin];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self saveImage:image];
    [_imgView setImage:[self retriveImage]];
    [_imgView.layer setCornerRadius:self.imgView.frame.size.height];
}



- (IBAction)FinishClicked:(id)sender {
    if(_imgView.image){
        [[CommonUtils sharedInstance] setBoardingDone];
        [[CommonUtils sharedInstance] showActivityIndicatorWithString:@"Preparing Your Card"];
        [self getSessionID];
    }
    else{
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Oops"
                                                       description:@"Please put your Image"
                                                              type:TWMessageBarMessageTypeInfo];
    }
}



#pragma mark Arguments

-(void)getSessionID{
    NSString *serviceUrl=@"https://login.salesforce.com/services/oauth2/token?grant_type=password&username=praveen@mysalesforce.com&password=drink7upXkgb1lfLYThQmkYeEvRn1hpM&client_id=3MVG9uudbyLbNPZN4t1Fi5Ct0Y7sqjTPVZpl4m4crJUYFO4wWFNI1yoAg5Jr3Hg3qrkiygBwqHMcFgpnx3Tkr&client_secret=8109137341775776726";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:serviceUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [self secondService:responseObject];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
    }];
}

-(void)secondService:(id)responseObject{
    
    //Setup
    [[CommonUtils sharedInstance] hideActivityIndicator];
    [[CommonUtils sharedInstance] showActivityIndicatorWithString:@"Almost there"];
    NSString *instanceUrl1=[responseObject objectForKey:@"instance_url"];
    NSString *accessToken1=[responseObject objectForKey:@"access_token"];
    NSString *url=[NSString stringWithFormat:@"%@/services/apexrest/memberdata",instanceUrl1];
    NSString *urlToken=[NSString stringWithFormat:@"OAuth %@",accessToken1];
    
    
    NSData *imageData = UIImageJPEGRepresentation(_imgView.image, 0.13);
    NSString *stringImage = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    UserProfile *user=[[CommonUtils sharedInstance] loadUserProfile];
    user.userid=[[NSUUID UUID] UUIDString];
    [[CommonUtils sharedInstance] saveUserProfile:user];
    NSMutableDictionary *inputJSON=[[NSMutableDictionary alloc]init];
    [inputJSON setValue:user.userid forKey:@"UserID"];
    [inputJSON setValue:user.firstName forKey:@"Name"];
    [inputJSON setValue:user.email forKey:@"Email"];
    [inputJSON setValue:user.phoneNumber forKey:@"PhoneNumber"];
    [inputJSON setValue:user.designation forKey:@"designation"];
    [inputJSON setValue:user.companyOrInstitution forKey:@"companyOrInstitution"];
    [inputJSON setValue:stringImage forKey:@"ProfilePicture"];
    [inputJSON setValue:@"0" forKey:@"BeaconID"];
    
    
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
    [inputJSON setValue:user.deviceToken forKey:@"deviceToken"];
    
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
        
        // Change View Controller
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *navigationController = (UINavigationController *) [UIApplication sharedApplication].keyWindow.rootViewController;
        [navigationController pushViewController:[story instantiateViewControllerWithIdentifier:@"HomeTabbarControllerID"] animated:NO];
        // [[UIApplication sharedApplication].keyWindow setRootViewController:tab];
        return;

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"False");
    }];
}


@end
