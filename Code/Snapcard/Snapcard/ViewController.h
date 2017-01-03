//
//  ViewController.h
//  Snapcard
//
//  Created by Pravin on 3/31/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnboardPageView.h"

@interface ViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) OnboardPageView *pageViewController;
@property (strong, nonatomic) NSMutableArray *aryPages;

@end
