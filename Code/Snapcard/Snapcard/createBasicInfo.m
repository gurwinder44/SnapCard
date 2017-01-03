//
//  createBasicInfo.m
//  Snapcard
//
//  Created by Pravin on 3/31/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "createBasicInfo.h"
const static CGFloat kJVFieldFontSize = 16.0f;
const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@interface createBasicInfo ()
@property (weak, nonatomic) IBOutlet UIButton *submitbtn;

@end

@implementation createBasicInfo
@synthesize pageIndex,txtField1,txtField2;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *floatingLabelColor = [UIColor flatWhiteColorDark];
    [_submitbtn.layer setCornerRadius:7.0];

    txtField1.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    txtField1.floatingLabelTextColor = floatingLabelColor;
    txtField1.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtField1.translatesAutoresizingMaskIntoConstraints = NO;
    txtField1.keepBaseline = YES;
    [txtField1 setBackgroundColor:[UIColor clearColor]];
    [txtField1 setTextColor:[UIColor whiteColor]];
    [txtField1 setBorderStyle:UITextBorderStyleNone];
    txtField1.textAlignment = NSTextAlignmentCenter;
    txtField1.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    
    
    txtField2.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    txtField2.floatingLabelTextColor = floatingLabelColor;
    txtField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtField2.translatesAutoresizingMaskIntoConstraints = NO;
    txtField2.keepBaseline = YES;
    [txtField2 setBackgroundColor:[UIColor clearColor]];
    [txtField2 setTextColor:[UIColor whiteColor]];
    [txtField2 setBorderStyle:UITextBorderStyleNone];
    txtField2.textAlignment = NSTextAlignmentCenter;
    txtField2.font = [UIFont systemFontOfSize:kJVFieldFontSize];
   
    
    
    
    if(pageIndex==1){
        txtField1.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Your name", @"")
                                        attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        [txtField2 setKeyboardType:UIKeyboardTypePhonePad];
        txtField2.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:NSLocalizedString(@"People can call u @", @"")
                                        attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        
        [txtField1 setText:@"Pravin"];
        [txtField2 setText:@"4805672894"];
    }
    
    if(pageIndex==2){
        txtField1.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Email", @"")
                                        attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        txtField2.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Personal URL", @"")
                                        attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        [txtField1 setText:@"pravin@asu.edu"];
        [txtField2 setText:@"www.pravin.com"];
    }
    
    if(pageIndex==3){
        txtField1.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Designation", @"")
                                        attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        txtField2.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Company Or Institute", @"")
                                        attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        [txtField1 setText:@"Mobile Software Engineer"];
        [txtField2 setText:@"Adobe"];
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)submitbtnClicked:(id)sender {
    
    UserProfile *user=[[CommonUtils sharedInstance] loadUserProfile];
    if(pageIndex==1){
        user.firstName=txtField1.text;
        user.phoneNumber=txtField2.text;
    }
    else if(pageIndex==2){
        user.email=txtField1.text;
        user.peronalURL=txtField2.text;
    }
    else if(pageIndex==3){
        user.designation=txtField1.text;
        user.companyOrInstitution=txtField2.text;
    }
    [[CommonUtils sharedInstance] saveUserProfile:user];
    
    NSDictionary *dict=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%lu",(unsigned long)pageIndex],@"index", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PCNext" object:self userInfo:dict];
}


@end
