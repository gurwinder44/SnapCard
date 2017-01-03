//
//  WelcomeScreen.m
//  Snapcard
//
//  Created by Pravin on 3/31/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "WelcomeScreen.h"

@interface WelcomeScreen ()

@property (weak, nonatomic) IBOutlet UIButton *getStartedButton;
@end
@implementation WelcomeScreen
@synthesize pageIndex;
- (void)viewDidLoad {
    [super viewDidLoad];
    [_getStartedButton.layer setCornerRadius:10.0f];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getStartedClicked:(UIButton *)sender {
    NSDictionary *dict=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%lu",(unsigned long)pageIndex],@"index", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PCNext" object:self userInfo:dict];
}


@end
