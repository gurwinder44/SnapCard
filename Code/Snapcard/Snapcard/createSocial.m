//
//  createSocial.m
//  Snapcard
//
//  Created by Pravin on 3/31/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "createSocial.h"
#import "FontAwesomeKit/FontAwesomeKit.h"

const static CGFloat kJVFieldFontSize = 16.0f;
const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@interface createSocial ()
@property (weak, nonatomic) IBOutlet UIButton *submitbtn;

@end

@implementation createSocial
@synthesize pageIndex,txtField;
- (void)viewDidLoad {
    [super viewDidLoad];
    [_submitbtn.layer setCornerRadius:7.0];
    [_submitbtn setTitle:@"Next" forState:UIControlStateNormal];
    UIColor *floatingLabelColor = [UIColor flatWhiteColorDark];
    txtField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    txtField.floatingLabelTextColor = floatingLabelColor;
    txtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtField.translatesAutoresizingMaskIntoConstraints = NO;
    txtField.keepBaseline = YES;
    [txtField setBackgroundColor:[UIColor clearColor]];
    [txtField setTextColor:[UIColor whiteColor]];
    [txtField setBorderStyle:UITextBorderStyleNone];
    txtField.textAlignment = NSTextAlignmentCenter;
    txtField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    
    
    
    
        if(pageIndex==5){
            FAKZocial *facebookIcon = [FAKZocial facebookIconWithSize:70];
            [facebookIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
            [_image setImage:[facebookIcon imageWithSize:CGSizeMake(_image.frame.size.width, _image.frame.size.height)]];
            txtField.attributedPlaceholder =
            [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Facebook ID", @"")
                                            attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
            [txtField setText:@"pravin.pk.94"];

        }
        else if(pageIndex==6){
            FAKZocial *twitterIcon = [FAKZocial twitterIconWithSize:70];
            [twitterIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
            [_image setImage:[twitterIcon imageWithSize:CGSizeMake(_image.frame.size.width, _image.frame.size.height)]];
            txtField.attributedPlaceholder =
            [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Twitter Handle", @"")
                                            attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
            [txtField setText:@"pravinpk7"];
        }
    
        else if(pageIndex==7){
            FAKFontAwesome *twitterIcon = [FAKFontAwesome instagramIconWithSize:70];
            [twitterIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
            [_image setImage:[twitterIcon imageWithSize:CGSizeMake(_image.frame.size.width, _image.frame.size.height)]];
            txtField.attributedPlaceholder =
            [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Instagram Username", @"")
                                            attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
            [txtField setText:@"pravin_pk7"];
        }
        else if(pageIndex==8){
            FAKFontAwesome *twitterIcon = [FAKFontAwesome pinterestIconWithSize:70];
            [twitterIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
            [_image setImage:[twitterIcon imageWithSize:CGSizeMake(_image.frame.size.width, _image.frame.size.height)]];
            txtField.attributedPlaceholder =
            [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Pintrest Username", @"")
                                            attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
            [txtField setText:@"pravinpk7"];
        }
        else if(pageIndex==9){
            FAKFontAwesome *twitterIcon = [FAKFontAwesome linkIconWithSize:70];
            [twitterIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
            [_image setImage:[twitterIcon imageWithSize:CGSizeMake(_image.frame.size.width, _image.frame.size.height)]];
            txtField.attributedPlaceholder =
            [[NSAttributedString alloc] initWithString:NSLocalizedString(@"LinkedIn Username", @"")
                                            attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
            [txtField setText:@"pravinpk7"];
        }
        else if(pageIndex==10){
            FAKFontAwesome *twitterIcon = [FAKFontAwesome gitIconWithSize:70];
            [twitterIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
            [_image setImage:[twitterIcon imageWithSize:CGSizeMake(_image.frame.size.width, _image.frame.size.height)]];
            txtField.attributedPlaceholder =
            [[NSAttributedString alloc] initWithString:NSLocalizedString(@"GitHub Username", @"")
                                            attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
            [txtField setText:@"pravinpk7"];
        }
        else if(pageIndex==11){
            FAKFoundationIcons *twitterIcon = [FAKFoundationIcons socialSnapchatIconWithSize:70];
            [twitterIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
            [_image setImage:[twitterIcon imageWithSize:CGSizeMake(_image.frame.size.width, _image.frame.size.height)]];
            txtField.attributedPlaceholder =
            [[NSAttributedString alloc] initWithString:NSLocalizedString(@"SnapChat Username", @"")
                                            attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
            [txtField setText:@"pravinpk7"];
        }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

}

- (IBAction)submitbtnClicked:(id)sender {
    
    UserProfile *user=[[CommonUtils sharedInstance] loadUserProfile];
    if(pageIndex==5){user.facebookID=txtField.text;}
    else if(pageIndex==6){user.twitterID=txtField.text;}
    else if(pageIndex==7){user.instagramID=txtField.text;}
    else if(pageIndex==8){user.pintrestID=txtField.text;}
    else if(pageIndex==9){user.linkedinID=txtField.text;}
    else if(pageIndex==10){user.gitHubID=txtField.text;}
    else if(pageIndex==11){user.snapchatID=txtField.text;}
        [[CommonUtils sharedInstance] saveUserProfile:user];
        NSDictionary *dict=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%lu",(unsigned long)pageIndex],@"index", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PCNext" object:self userInfo:dict];
}


- (IBAction)skipClicked:(id)sender {
    UserProfile *user=[[CommonUtils sharedInstance] loadUserProfile];
    if(pageIndex==5){user.facebookID=nil;}
    else if(pageIndex==6){user.twitterID=nil;}
    else if(pageIndex==7){user.instagramID=nil;}
    else if(pageIndex==8){user.pintrestID=nil;}
    else if(pageIndex==9){user.linkedinID=nil;}
    else if(pageIndex==10){user.gitHubID=nil;}
    else if(pageIndex==11){user.snapchatID=nil;}
    [[CommonUtils sharedInstance] saveUserProfile:user];
        NSDictionary *dict=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%lu",(unsigned long)pageIndex],@"index", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PCNext" object:self userInfo:dict];
}




@end
