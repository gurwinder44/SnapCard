//
//  OnboardPageView.h
//  Snapcard
//
//  Created by Pravin on 3/30/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnboardPageView : UIPageViewController <UIPageViewControllerDataSource>
{
    NSDictionary *nextPageoption;
    NSInteger currentIndex;
}

@property (strong, nonatomic) NSMutableArray *aryPages;


@end
