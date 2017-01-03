//
//  CardView.h
//  Snapcard
//
//  Created by Pravin on 4/2/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *designation;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIImageView *profilepic;
@property (strong, nonatomic) UserProfile *user;

@property (weak, nonatomic) IBOutlet UIScrollView *scrlView;

@end
