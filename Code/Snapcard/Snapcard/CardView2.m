    //
//  CardView2.m
//  Snapcard
//
//  Created by Pravin on 4/10/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "CardView2.h"
#define iconSize 20
#define iconColor [UIColor whiteColor]
#define scrollMargins 10
#define circleIconSize 20.0
#define circleiconColor [UIColor whiteColor]

@implementation CardView2
@synthesize user;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
    [_profileName setText:user.firstName];
    [_profilePic setImage:[self retriveImage]];
    [_backgroundImage setImage:[self retriveImage]];
    [_profilePic.layer setCornerRadius:_profilePic.frame.size.width/2];
    [_profilePic setBackgroundColor:[UIColor clearColor]];
    [self addBlurBackground];
}

-(void)addBlurBackground{
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *beView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    beView.frame = self.bounds;
    [self insertSubview:beView atIndex:2];
    [self setBackgroundColor:[UIColor clearColor]];
}

-(void)awakeFromNib{

}

-(UIImage*)retriveImage{
    NSString *fullName;
    UserProfile *mainPro=[[CommonUtils sharedInstance] loadUserProfile];
    if([user.userid isEqualToString:mainPro.userid]){
        fullName=@"myPhoto.jpg";
    }
    else{
        fullName=[NSString stringWithFormat:@"%@.jpg",user.userid];
    }
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CellID"];
    [cell.textLabel setNumberOfLines:3];
    
    
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        [cell setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.0]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
    }
    if(user){
        if(indexPath.row==0){
            [cell.textLabel setText:user.phoneNumber];
            FAKFontAwesome *facebookIcon = [FAKFontAwesome phoneIconWithSize:iconSize];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:iconColor];
            [cell.imageView setImage:[facebookIcon imageWithSize:CGSizeMake(30, 30)]];
            return cell;
        }
        if(indexPath.row==1){
            [cell.textLabel setText:user.email];
            FAKFontAwesome *facebookIcon = [FAKFontAwesome envelopeIconWithSize:iconSize-2];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:iconColor];
            [cell.imageView setImage:[facebookIcon imageWithSize:CGSizeMake(30, 30)]];
            return cell;
        }
        if(indexPath.row==2){
            [cell.textLabel setText:user.peronalURL];
            FAKFontAwesome *facebookIcon = [FAKFontAwesome linkIconWithSize:iconSize];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:iconColor];
            [cell.imageView setImage:[facebookIcon imageWithSize:CGSizeMake(30, 30)]];
            return cell;
        }
        if(indexPath.row==3){
            [cell.textLabel setText:user.homelocationAddress];
            FAKFontAwesome *facebookIcon = [FAKFontAwesome homeIconWithSize:iconSize];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:iconColor];
            [cell.imageView setImage:[facebookIcon imageWithSize:CGSizeMake(30, 30)]];
            return cell;
        }
        if(indexPath.row==4){
            CGFloat aHeight = [tableView rectForRowAtIndexPath:indexPath].size.height;
            UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, aHeight)];
            int element=0;
            int tag=0;
            int elementwidthHeight=scroll.frame.size.height-2*scrollMargins;
            
            
            if(user.facebookID){
                UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(scrollMargins+ (element *(elementwidthHeight+scrollMargins)),scrollMargins, elementwidthHeight, elementwidthHeight)];
                [btn setBackgroundColor:[UIColor faceBookColor]];
                [scroll addSubview: btn];
                [btn.layer setCornerRadius:btn.frame.size.height/2];
                [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTag:tag];
                FAKZocial *icon=[FAKZocial facebookIconWithSize:circleIconSize];
                [icon addAttribute:NSForegroundColorAttributeName value:circleiconColor];
                [btn setImage:[icon imageWithSize:btn.frame.size] forState:UIControlStateNormal];
                element=element+1;
            }
            tag=tag+1;
            
            if(user.twitterID){
                UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(scrollMargins+ (element *(elementwidthHeight+scrollMargins)),scrollMargins, elementwidthHeight, elementwidthHeight)];
                [btn setBackgroundColor:[UIColor twitterColor]];
                FAKZocial *icon=[FAKZocial twitterIconWithSize:circleIconSize];
                [scroll addSubview: btn];
                [btn.layer setCornerRadius:btn.frame.size.height/2];
                [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTag:tag];
                [icon addAttribute:NSForegroundColorAttributeName value:circleiconColor];
                [btn setImage:[icon imageWithSize:btn.frame.size] forState:UIControlStateNormal];
                element=element+1;
            }
            tag=tag+1;
            
            if(user.instagramID){
                UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(scrollMargins+ (element *(elementwidthHeight+scrollMargins)),scrollMargins, elementwidthHeight, elementwidthHeight)];
                [btn setBackgroundColor:[UIColor instagramColor]];
                FAKFontAwesome *icon=[FAKFontAwesome instagramIconWithSize:circleIconSize];
                [scroll addSubview: btn];
                [btn.layer setCornerRadius:btn.frame.size.height/2];
                [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTag:tag];
                [icon addAttribute:NSForegroundColorAttributeName value:circleiconColor];
                [btn setImage:[icon imageWithSize:btn.frame.size] forState:UIControlStateNormal];
                element=element+1;
            }
            tag=tag+1;
            
            if(user.pintrestID){
                UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(scrollMargins+ (element *(elementwidthHeight+scrollMargins)),scrollMargins, elementwidthHeight, elementwidthHeight)];
                [btn setBackgroundColor:[UIColor pintrestColor]];
                FAKZocial *icon=[FAKZocial pinterestIconWithSize:circleIconSize];
                [scroll addSubview: btn];
                [btn.layer setCornerRadius:btn.frame.size.height/2];
                [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTag:tag];
                [icon addAttribute:NSForegroundColorAttributeName value:circleiconColor];
                [btn setImage:[icon imageWithSize:btn.frame.size] forState:UIControlStateNormal];
                element=element+1;
            }
            tag=tag+1;
            
            if(user.gitHubID){
                UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(scrollMargins+ (element *(elementwidthHeight+scrollMargins)),scrollMargins, elementwidthHeight, elementwidthHeight)];
                [btn setBackgroundColor:[UIColor gitHubInColor]];
                FAKZocial *icon=[FAKZocial githubIconWithSize:circleIconSize];
                [scroll addSubview: btn];
                [btn.layer setCornerRadius:btn.frame.size.height/2];
                [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTag:tag];
                [icon addAttribute:NSForegroundColorAttributeName value:circleiconColor];
                [btn setImage:[icon imageWithSize:btn.frame.size] forState:UIControlStateNormal];
                element=element+1;
            }
            tag=tag+1;
            
            
            if(user.linkedinID){
                UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(scrollMargins+ (element *(elementwidthHeight+scrollMargins)),scrollMargins, elementwidthHeight, elementwidthHeight)];
                [btn setBackgroundColor:[UIColor linkedInColor]];
                FAKZocial *icon=[FAKZocial linkedinIconWithSize:circleIconSize];
                [scroll addSubview: btn];
                [btn.layer setCornerRadius:btn.frame.size.height/2];
                [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTag:tag];
                [icon addAttribute:NSForegroundColorAttributeName value:circleiconColor];
                [btn setImage:[icon imageWithSize:btn.frame.size] forState:UIControlStateNormal];
                element=element+1;
            }
            [scroll setContentSize:CGSizeMake(element *(elementwidthHeight+scrollMargins), aHeight)];
            [cell addSubview:scroll];
            return cell;

        }
    }
    return nil;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==4){
        return 60;
    }
    else
        return 40;
}


-(IBAction)btnClicked:(id)sender{
    UIButton *btn =(UIButton *)sender;
    int tag=(int)[btn tag];
    
    if(tag==0){        
        NSURL *facebookURL = [NSURL URLWithString:[NSString stringWithFormat:@"fb://profile?app_scoped_user_id=%@",user.facebookID]];
        if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
            [[UIApplication sharedApplication] openURL:facebookURL];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.facebook.com/%@",user.facebookID]]];
        }
    }
    
    if(tag==1){
        NSURL *twitterURL = [NSURL URLWithString:[NSString stringWithFormat:@"twitter://user?screen_name=%@",user.twitterID]];
        if ([[UIApplication sharedApplication] canOpenURL:twitterURL]) {
            [[UIApplication sharedApplication] openURL:twitterURL];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/%@",user.twitterID]]];
        }
    }
    
    if(tag==2){
        NSURL *instagramURL = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://user?username=%@",user.instagramID]];
        if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
            [[UIApplication sharedApplication] openURL:instagramURL];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.instagram.com/%@",user.instagramID]]];
        }
    }
    
    if(tag==3){
        NSURL *instagramURL = [NSURL URLWithString:[NSString stringWithFormat:@"pinterest://user/%@",user.pintrestID]];
        if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
            [[UIApplication sharedApplication] openURL:instagramURL];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.pinterest.com/%@",user.pintrestID]]];
        }
    }
    
    if(tag==4){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.github.com/%@",user.gitHubID]]];
    }
    
    if(tag==5){
        NSURL *instagramURL = [NSURL URLWithString:[NSString stringWithFormat:@"linkedin://profile/%@",user.instagramID]];
        if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
            [[UIApplication sharedApplication] openURL:instagramURL];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.linkedin.com/in/%@",user.instagramID]]];
        }
    }
    


}


@end
