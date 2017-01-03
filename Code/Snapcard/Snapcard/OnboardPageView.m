//
//  OnboardPageView.m
//  Snapcard
//
//  Created by Pravin on 3/30/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "OnboardPageView.h"
#import "WelcomeScreen.h"
#import "createSocial.h"
#import "createBasicInfo.h"
#import "HomeLocationSelect.h"
#import "CreateAddProPic.h"
@interface OnboardPageView ()

@end

@implementation OnboardPageView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextPage:) name:@"PCNext" object:nil];
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    WelcomeScreen *welcome=[story instantiateViewControllerWithIdentifier:@"WelcomeScreenID"];
    [welcome.view setBackgroundColor:[UIColor flatGrayColor]];
    welcome.pageIndex=0;
    
    createBasicInfo *basic1=[story instantiateViewControllerWithIdentifier:@"createBasicInfoID"];
    basic1.pageIndex=1;
    
    createBasicInfo *basic2=[story instantiateViewControllerWithIdentifier:@"createBasicInfoID"];
    basic2.pageIndex=2;
    
    createBasicInfo *basic3=[story instantiateViewControllerWithIdentifier:@"createBasicInfoID"];
    basic3.pageIndex=3;
    
    
    HomeLocationSelect *home=[story instantiateViewControllerWithIdentifier:@"HomeLocationSelectID"];
    home.pageIndex=4;
    home.modeOfEntry=0;
    
    createSocial *social1=[story instantiateViewControllerWithIdentifier:@"createSocialID"];
    social1.pageIndex=5;
    [social1.view setBackgroundColor:[UIColor faceBookColor]];
    
    
    createSocial *social2=[story instantiateViewControllerWithIdentifier:@"createSocialID"];
    social2.pageIndex=6;
    [social2.view setBackgroundColor:[UIColor twitterColor]];
    
    
    createSocial *social3=[story instantiateViewControllerWithIdentifier:@"createSocialID"];
    social3.pageIndex=7;
    [social3.view setBackgroundColor:[UIColor instagramColor]];
    
    
    createSocial *social4=[story instantiateViewControllerWithIdentifier:@"createSocialID"];
    social4.pageIndex=8;
    [social4.view setBackgroundColor:[UIColor pintrestColor]];
    
    
    createSocial *social5=[story instantiateViewControllerWithIdentifier:@"createSocialID"];
    social5.pageIndex=9;
    [social5.view setBackgroundColor:[UIColor linkedInColor]];
    
    
    createSocial *social6=[story instantiateViewControllerWithIdentifier:@"createSocialID"];
    social6.pageIndex=10;
    [social6.view setBackgroundColor:[UIColor gitHubInColor]];
    
    
    createSocial *social7=[story instantiateViewControllerWithIdentifier:@"createSocialID"];
    social7.pageIndex=11;
    [social7.view setBackgroundColor:[UIColor snapChatColor]];
    
    CreateAddProPic *pro=[story instantiateViewControllerWithIdentifier:@"CreateAddProPicID"];
    pro.pageIndex=12;
    
    
    
    
    _aryPages=[[NSMutableArray alloc] initWithObjects:welcome,basic1,basic2,basic3,home,social1,social2,social3,social4,social5,social6,social7,pro, nil];
    
    
    OnboardPageView *startingViewController = [_aryPages objectAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Create page view controller
    self.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index;
    if([viewController isKindOfClass:[WelcomeScreen class]]){
        index=((WelcomeScreen *) viewController).pageIndex;
    }
    else if([viewController isKindOfClass:[createBasicInfo class]]){
        index=((createBasicInfo *) viewController).pageIndex;
    }
    else if([viewController isKindOfClass:[createSocial class]]){
        index=((createSocial *) viewController).pageIndex;
    }
    else if([viewController isKindOfClass:[HomeLocationSelect class]]){
        index=((HomeLocationSelect *) viewController).pageIndex;
    }
    else if([viewController isKindOfClass:[CreateAddProPic class]]){
        index=((CreateAddProPic *) viewController).pageIndex;
    }
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [_aryPages objectAtIndex:index];
}




- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index;
    if([viewController isKindOfClass:[WelcomeScreen class]]){
        index=((WelcomeScreen *) viewController).pageIndex;
    }
    else if([viewController isKindOfClass:[createBasicInfo class]]){
        index=((createBasicInfo *) viewController).pageIndex;
    }
    else if([viewController isKindOfClass:[createSocial class]]){
        index=((createSocial *) viewController).pageIndex;
    }
    else if([viewController isKindOfClass:[HomeLocationSelect class]]){
        index=((HomeLocationSelect *) viewController).pageIndex;
    }
    else if([viewController isKindOfClass:[CreateAddProPic class]]){
        index=((CreateAddProPic *) viewController).pageIndex;
    }
    if (index == NSNotFound|| index==([_aryPages count]-1) ) {
        return nil;
    }

    
    index++;
    return [_aryPages objectAtIndex:index];
}



- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.aryPages count] == 0) || (index >= [self.aryPages count])) {
        return nil;
    }
    return (UIViewController *)[_aryPages objectAtIndex:index];
    
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return _aryPages.count;
}



- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return currentIndex;
}

-(void)nextPage:(NSNotification *) notification{
    currentIndex=[[notification.userInfo objectForKey:@"index"] integerValue]+1;
    NSArray *viewControllers = @[[self viewControllerAtIndex:currentIndex]];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
}

@end

