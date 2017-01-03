//
//  ViewController.m
//  Snapcard
//
//  Created by Pravin on 3/31/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "ViewController.h"
#import "WelcomeScreen.h"
#import "createSocial.h"
#import "createBasicInfo.h"
#import "HomeLocationSelect.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    WelcomeScreen *welcome=[story instantiateViewControllerWithIdentifier:@"WelcomeScreenID"];
    [welcome.view setBackgroundColor:[UIColor flatGrayColor]];
    welcome.pageIndex=0;
    
    createBasicInfo *basic1=[story instantiateViewControllerWithIdentifier:@"createBasicInfoID"];
    [basic1.view setBackgroundColor:[UIColor flatLimeColor]];
    basic1.pageIndex=1;
    
    createBasicInfo *basic2=[story instantiateViewControllerWithIdentifier:@"createBasicInfoID"];
    basic2.pageIndex=2;
    
    createBasicInfo *basic3=[story instantiateViewControllerWithIdentifier:@"createBasicInfoID"];
    basic3.pageIndex=3;
    
    
    HomeLocationSelect *home=[story instantiateViewControllerWithIdentifier:@"HomeLocationSelectID"];
    home.pageIndex=4;
    home.modeOfEntry=0;
    
    createSocial *social1=[story instantiateViewControllerWithIdentifier:@"createSocialID"];
    [social1.view setBackgroundColor:[UIColor faceBookColor]];
    social1.pageIndex=5;
    
    createSocial *social2=[story instantiateViewControllerWithIdentifier:@"createSocialID"];
    [social2.view setBackgroundColor:[UIColor twitterColor]];
    social2.pageIndex=6;
    
    createSocial *social3=[story instantiateViewControllerWithIdentifier:@"createSocialID"];
    [social3.view setBackgroundColor:[UIColor instagramColor]];
    social3.pageIndex=7;
    
    
    createSocial *social4=[story instantiateViewControllerWithIdentifier:@"createSocialID"];
    [social4.view setBackgroundColor:[UIColor pintrestColor]];
    social4.pageIndex=7;
    
    
    _aryPages=[[NSMutableArray alloc] initWithObjects:welcome,basic1,basic2,basic3,home,social1,social2,social3,social4, nil];
    
    
    
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OnboardPageViewID"];
    self.pageViewController.dataSource = self;
    
    OnboardPageView *startingViewController = [_aryPages objectAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height );
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

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


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return _aryPages.count;
}



- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}





@end
