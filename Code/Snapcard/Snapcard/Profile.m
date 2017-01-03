//
//  Profile.m
//  Snapcard
//
//  Created by Pravin on 4/2/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "Profile.h"
#import "CardView.h"
#import "HomeLocationSelect.h"


#define iconsize 60
#define unavialableBackgroundColor [UIColor lightGrayColor]
#define unavialableFontColor [UIColor whiteColor]
#define avialableFontColor [UIColor whiteColor]

@interface Profile ()

@end
int width;
@implementation Profile

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setNeedsLayout];
    [self.navigationController setNavigationBarHidden:FALSE];
    width=self.view.frame.size.width;
    user=[[CommonUtils sharedInstance] loadUserProfile];
    [_collectionView setBackgroundColor:[UIColor lightThemeColor]];
    [self.view setBackgroundColor:[UIColor lightThemeColor]];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;
    
//    if(indexPath.row==0){
//        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
//        CardView *rootView = [[[NSBundle mainBundle] loadNibNamed:@"CardView" owner:self options:nil] objectAtIndex:0];
//        rootView.user=[[CommonUtils sharedInstance] loadUserProfile];
//        [rootView setFrame:CGRectMake(0, 0, width, 180)];
//        [cell addSubview:rootView];
//    }
    
    //Email
    if(indexPath.row==0){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
        FAKZocial *facebookIcon = [FAKZocial emailIconWithSize:iconsize];
        if(user.email==nil||[user.email isEqualToString:@""]){
            [cell setBackgroundColor:unavialableBackgroundColor];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:unavialableFontColor];
        }
        else{
            [cell setBackgroundColor:[UIColor themeGreen]];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:avialableFontColor];
        }
        UIImageView *image=[cell viewWithTag:1];
        [image setImage:[facebookIcon imageWithSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)]];
        [cell addSubview:image];
    }
    
    //Phone Number
    if(indexPath.row==1){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
        FAKFontAwesome *facebookIcon = [FAKFontAwesome phoneIconWithSize:iconsize];
        if(user.phoneNumber==nil||[user.phoneNumber isEqualToString:@""]){
            [cell setBackgroundColor:unavialableBackgroundColor];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:unavialableFontColor];
        }
        else{
            [cell setBackgroundColor:[UIColor themeGreen]];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:avialableFontColor];
        }
        UIImageView *image=[cell viewWithTag:1];
        [image setImage:[facebookIcon imageWithSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)]];
        [cell addSubview:image];
    }
    
    //Designation
    if(indexPath.row==2){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
        FAKFontAwesome *facebookIcon = [FAKFontAwesome graduationCapIconWithSize:iconsize];
        if(user.designation==nil||[user.designation isEqualToString:@""]){
            [cell setBackgroundColor:unavialableBackgroundColor];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:unavialableFontColor];
        }
        else{
            [cell setBackgroundColor:[UIColor themeGreen]];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:avialableFontColor];
        }
        UIImageView *image=[cell viewWithTag:1];
        [image setImage:[facebookIcon imageWithSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)]];
        [cell addSubview:image];
    }
    
    //Company
    if(indexPath.row==3){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
        FAKFontAwesome *facebookIcon = [FAKFontAwesome buildingIconWithSize:iconsize];
        if(user.companyOrInstitution==nil||[user.companyOrInstitution isEqualToString:@""]){
            [cell setBackgroundColor:unavialableBackgroundColor];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:unavialableFontColor];
        }
        else{
            [cell setBackgroundColor:[UIColor themeGreen]];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:avialableFontColor];
        }
        UIImageView *image=[cell viewWithTag:1];
        [image setImage:[facebookIcon imageWithSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)]];
        [cell addSubview:image];
    }
    
    
    //Home Address
    if(indexPath.row==4){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
        FAKFontAwesome *facebookIcon = [FAKFontAwesome homeIconWithSize:iconsize];
        if(user.homelocationAddress==nil||[user.homelocationAddress isEqualToString:@""]){
            [cell setBackgroundColor:unavialableBackgroundColor];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:unavialableFontColor];
        }
        else{
            [cell setBackgroundColor:[UIColor themeGreen]];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:avialableFontColor];
        }
        UIImageView *image=[cell viewWithTag:1];
        [image setImage:[facebookIcon imageWithSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)]];
        [cell addSubview:image];
    }
    
    //Personal Url
    if(indexPath.row==5){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
        FAKFontAwesome *facebookIcon = [FAKFontAwesome linkIconWithSize:iconsize];
        if(user.peronalURL==nil||[user.peronalURL isEqualToString:@""]){
            [cell setBackgroundColor:unavialableBackgroundColor];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:unavialableFontColor];
        }
        else{
            [cell setBackgroundColor:[UIColor themeGreen]];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:avialableFontColor];
        }
        UIImageView *image=[cell viewWithTag:1];
        [image setImage:[facebookIcon imageWithSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)]];
        [cell addSubview:image];
    }
    
    
    
    
    //FaceBook Icon
    else if(indexPath.row==6){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
        FAKZocial *facebookIcon = [FAKZocial facebookIconWithSize:iconsize];
        if(user.facebookID==nil||[user.facebookID isEqualToString:@""]){
            [cell setBackgroundColor:unavialableBackgroundColor];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:unavialableFontColor];
        }
        else{
            [cell setBackgroundColor:[UIColor faceBookColor]];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:avialableFontColor];
        }
        UIImageView *image=[cell viewWithTag:1];
        [image setImage:[facebookIcon imageWithSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)]];
        [cell addSubview:image];
    }
    
    //Twitter Icon
    else if(indexPath.row==7){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
        FAKZocial *twitterIcon = [FAKZocial twitterIconWithSize:iconsize];
        if(user.twitterID==nil||[user.twitterID isEqualToString:@""]){
            [cell setBackgroundColor:unavialableBackgroundColor];
            [twitterIcon addAttribute:NSForegroundColorAttributeName value:unavialableFontColor];
        }
        else{
            [cell setBackgroundColor:[UIColor twitterColor]];
            [twitterIcon addAttribute:NSForegroundColorAttributeName value:avialableFontColor];
        }
        UIImageView *image=[cell viewWithTag:1];
        [image setImage:[twitterIcon imageWithSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)]];
        [cell addSubview:image];
    }
    
    //Instagram Icon
    else if(indexPath.row==8){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
        FAKFontAwesome *instagramIcon = [FAKFontAwesome instagramIconWithSize:iconsize];
        if(user.instagramID==nil||[user.instagramID isEqualToString:@""]){
            [cell setBackgroundColor:unavialableBackgroundColor];
            [instagramIcon addAttribute:NSForegroundColorAttributeName value:unavialableFontColor];
        }
        else{
            [cell setBackgroundColor:[UIColor instagramColor]];
            [instagramIcon addAttribute:NSForegroundColorAttributeName value:avialableFontColor];
        }
        UIImageView *image=[cell viewWithTag:1];
        [image setImage:[instagramIcon imageWithSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)]];
        [cell addSubview:image];
    }
    
    //Pintrest Icon
    else if(indexPath.row==9){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
        FAKZocial *pintrestIcon = [FAKZocial pinterestIconWithSize:iconsize];
        if(user.pintrestID==nil||[user.pintrestID isEqualToString:@""]){
            [cell setBackgroundColor:unavialableBackgroundColor];
            [pintrestIcon addAttribute:NSForegroundColorAttributeName value:unavialableFontColor];
        }
        else{
            [cell setBackgroundColor:[UIColor pintrestColor]];
            [pintrestIcon addAttribute:NSForegroundColorAttributeName value:avialableFontColor];
        }
        UIImageView *image=[cell viewWithTag:1];
        [image setImage:[pintrestIcon imageWithSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)]];
        [cell addSubview:image];
    }
    
    
    //GitHub Icon
    else if(indexPath.row==10){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
        FAKZocial *gitHubIcon = [FAKZocial githubIconWithSize:iconsize];
        if(user.gitHubID==nil||[user.gitHubID isEqualToString:@""]){
            [cell setBackgroundColor:unavialableBackgroundColor];
            [gitHubIcon addAttribute:NSForegroundColorAttributeName value:unavialableFontColor];
        }
        else{
            [cell setBackgroundColor:[UIColor gitHubInColor]];
            [gitHubIcon addAttribute:NSForegroundColorAttributeName value:avialableFontColor];
        }
        UIImageView *image=[cell viewWithTag:1];
        [image setImage:[gitHubIcon imageWithSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)]];
        [cell addSubview:image];
    }
    
    //LinkedIn Icon
    else if(indexPath.row==11){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
        FAKZocial *linkedInIcon = [FAKZocial linkedinIconWithSize:iconsize];
        if(user.linkedinID==nil||[user.linkedinID isEqualToString:@""]){
            [cell setBackgroundColor:unavialableBackgroundColor];
            [linkedInIcon addAttribute:NSForegroundColorAttributeName value:unavialableFontColor];
        }
        else{
            [cell setBackgroundColor:[UIColor linkedInColor]];
            [linkedInIcon addAttribute:NSForegroundColorAttributeName value:avialableFontColor];
        }
        UIImageView *image=[cell viewWithTag:1];
        [image setImage:[linkedInIcon imageWithSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)]];
        [cell addSubview:image];
    }
    


    //SnapChat Icon
    else if(indexPath.row==12){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
        FAKIonIcons *gitHubIcon = [FAKIonIcons socialSnapchatIconWithSize:iconsize];
        if(user.gitHubID==nil||[user.gitHubID isEqualToString:@""]){
            [cell setBackgroundColor:unavialableBackgroundColor];
            [gitHubIcon addAttribute:NSForegroundColorAttributeName value:unavialableFontColor];
        }
        else{
            [cell setBackgroundColor:[UIColor snapChatColor]];
            [gitHubIcon addAttribute:NSForegroundColorAttributeName value:avialableFontColor];
        }
        UIImageView *image=[cell viewWithTag:1];
        [image setImage:[gitHubIcon imageWithSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)]];
        [cell addSubview:image];
    }
    return cell;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionViews{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 13;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{    
    //You may want to create a divider to scale the size by the way..
        return CGSizeMake(width/3, width/3);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    chosenIndex=(int)indexPath.row;
    NSString *askString=[[NSString alloc] init];
    if (indexPath.row==4){
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HomeLocationSelect *home=[story instantiateViewControllerWithIdentifier:@"HomeLocationSelectID"];
        [self.navigationController pushViewController:home animated:YES];
    }
    else{
        if(indexPath.row==0){ askString=@"Email";}
        if(indexPath.row==1){ askString=@"Phone";}
        if(indexPath.row==2){ askString=@"Designation";}
        if(indexPath.row==3){ askString=@"Company/Institution";}
        if(indexPath.row==5){ askString=@"Personal Url";}
        if(indexPath.row==6){ askString=@"Facebook ID";} 
        if(indexPath.row==7){ askString=@"Twitter ID";}
        if(indexPath.row==8){ askString=@"Instagram ID";}
        if(indexPath.row==9){ askString=@"Pintrest ID";}
        if(indexPath.row==10){ askString=@"GitHub ID";}
        if(indexPath.row==11){ askString=@"LinkedIn ID";}
        if(indexPath.row==12){ askString=@"SnapChat ID";}
        UIAlertView *alertViewChangeName=[[UIAlertView alloc]initWithTitle:askString message:@"Type here" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save",nil];
        alertViewChangeName.alertViewStyle=UIAlertViewStylePlainTextInput;
        [alertViewChangeName show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView firstOtherButtonIndex]) {
        NSString *text = [alertView textFieldAtIndex:0].text;
        if(chosenIndex==0){user.email=text;}
        else if(chosenIndex==1){user.phoneNumber=text;}
        else if(chosenIndex==2){user.designation=text;}
        else if(chosenIndex==3){user.companyOrInstitution=text;}
        else if(chosenIndex==5){user.peronalURL=text;}
        else if(chosenIndex==6){user.facebookID=text;}
        else if(chosenIndex==7){user.twitterID=text;}
        else if(chosenIndex==8){user.instagramID=text;}
        else if(chosenIndex==9){user.pintrestID=text;}
        else if(chosenIndex==10){user.gitHubID=text;}
        else if(chosenIndex==11){user.linkedinID=text;}
        else if(chosenIndex==12){user.snapchatID=text;}
        [[CommonUtils sharedInstance] saveUserProfile:user];
        [[CommonUtils sharedInstance] showActivityIndicatorWithString:@"Updating"];
        [self getSessionID];
    }
}


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
    
    
    UIImage *image=[self retriveImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    NSString *stringImage = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    user=[[CommonUtils sharedInstance] loadUserProfile];
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
        //        [[UIApplication sharedApplication].keyWindow setRootViewController:tab];
        return;
        
        
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


@end
