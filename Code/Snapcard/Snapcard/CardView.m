    //
//  CardView.m
//  Snapcard
//
//  Created by Pravin on 4/2/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "CardView.h"
#define scrollMargins 10
#define waitDuration 2
#define animationDuration 4.0
#define circleIconSize 20.0
#define circleiconColor [UIColor whiteColor]

@implementation CardView
@synthesize user;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */


- (void)drawRect:(CGRect)rect {
    [_profilepic.layer setCornerRadius:_profilepic.frame.size.width];
}


-(void)awakeFromNib{
    

    
    NSLog(@" Awake from nib %f",_scrlView.frame.size.height);

}

-(void)updateConstraints{
    [super updateConstraints];
    [self layoutIfNeeded];
    
    
    _name.text=user.firstName;
    _email.text=user.email;
    _designation.text=user.designation;
    _email.text=user.email;
    
    NSLog(@"Update constrains %f",_scrlView.frame.size.height);
    
    int element=0;
    int elementwidthHeight=_scrlView.frame.size.height-2*scrollMargins;
    
    
    if(user.facebookID){
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(scrollMargins+ (element *(elementwidthHeight+scrollMargins)),scrollMargins, elementwidthHeight, elementwidthHeight)];
        [btn setBackgroundColor:[UIColor faceBookColor]];
        [_scrlView addSubview: btn];
        [self animateButton:btn];
        
        [btn.layer setCornerRadius:btn.frame.size.height/2];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:element];
        FAKZocial *icon=[FAKZocial facebookIconWithSize:circleIconSize];
        [icon addAttribute:NSForegroundColorAttributeName value:circleiconColor];
        [btn setImage:[icon imageWithSize:btn.frame.size] forState:UIControlStateNormal];
        element=element+1;
    }
    
    if(user.twitterID){
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(scrollMargins+ (element *(elementwidthHeight+scrollMargins)),scrollMargins, elementwidthHeight, elementwidthHeight)];
        [btn setBackgroundColor:[UIColor twitterColor]];
        FAKZocial *icon=[FAKZocial twitterIconWithSize:circleIconSize];
        [_scrlView addSubview: btn];
        [self animateButton:btn];
        [btn.layer setCornerRadius:btn.frame.size.height/2];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:element];
        [icon addAttribute:NSForegroundColorAttributeName value:circleiconColor];
        [btn setImage:[icon imageWithSize:btn.frame.size] forState:UIControlStateNormal];
        element=element+1;
    }
    
    if(user.instagramID){
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(scrollMargins+ (element *(elementwidthHeight+scrollMargins)),scrollMargins, elementwidthHeight, elementwidthHeight)];
        [btn setBackgroundColor:[UIColor instagramColor]];
        FAKFontAwesome *icon=[FAKFontAwesome instagramIconWithSize:circleIconSize];
        [_scrlView addSubview: btn];
        [self animateButton:btn];
        [btn.layer setCornerRadius:btn.frame.size.height/2];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:element];
        [icon addAttribute:NSForegroundColorAttributeName value:circleiconColor];
        [btn setImage:[icon imageWithSize:btn.frame.size] forState:UIControlStateNormal];
        element=element+1;
    }
    
    if(user.pintrestID){
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(scrollMargins+ (element *(elementwidthHeight+scrollMargins)),scrollMargins, elementwidthHeight, elementwidthHeight)];
        [btn setBackgroundColor:[UIColor pintrestColor]];
        FAKZocial *icon=[FAKZocial pinterestIconWithSize:circleIconSize];
        [_scrlView addSubview: btn];
        [self animateButton:btn];
        [btn.layer setCornerRadius:btn.frame.size.height/2];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:element];
        [icon addAttribute:NSForegroundColorAttributeName value:circleiconColor];
        [btn setImage:[icon imageWithSize:btn.frame.size] forState:UIControlStateNormal];
        element=element+1;
    }
    
    if(user.gitHubID){
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(scrollMargins+ (element *(elementwidthHeight+scrollMargins)),scrollMargins, elementwidthHeight, elementwidthHeight)];
        [btn setBackgroundColor:[UIColor gitHubInColor]];
        FAKZocial *icon=[FAKZocial githubIconWithSize:circleIconSize];
        [_scrlView addSubview: btn];
        [self animateButton:btn];
        [btn.layer setCornerRadius:btn.frame.size.height/2];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:element];
        [icon addAttribute:NSForegroundColorAttributeName value:circleiconColor];
        [btn setImage:[icon imageWithSize:btn.frame.size] forState:UIControlStateNormal];
        element=element+1;
    }
    
    
    if(user.linkedinID){
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(scrollMargins+ (element *(elementwidthHeight+scrollMargins)),scrollMargins, elementwidthHeight, elementwidthHeight)];
        [btn setBackgroundColor:[UIColor linkedInColor]];
        FAKZocial *icon=[FAKZocial linkedinIconWithSize:circleIconSize];
        [_scrlView addSubview: btn];
        [self animateButton:btn];
        [btn.layer setCornerRadius:btn.frame.size.height/2];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:element];
        [icon addAttribute:NSForegroundColorAttributeName value:circleiconColor];
        [btn setImage:[icon imageWithSize:btn.frame.size] forState:UIControlStateNormal];
        element=element+1;
    }
    
}

-(void)animateButton:(UIButton*) button{
    button.transform=CGAffineTransformMakeScale(0.2, 0.2);
    [UIView animateWithDuration:animationDuration animations:^{
        if(button){
            NSLog(@"animating");
            button.transform=CGAffineTransformMakeScale(1, 1);
        }
    }];
}

-(IBAction)btnClicked:(id)sender{
    UIButton *btn =(UIButton *)sender;
    NSLog(@"%ld",(long)[btn tag]);
}
@end
