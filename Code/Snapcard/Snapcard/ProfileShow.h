//
//  ProfileShow.h
//  Snapcard
//
//  Created by Pravin on 4/18/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView2.h"

@interface ProfileShow : UIViewController
{
    UserProfile *user;
    IBOutlet UIButton *editInfoBtn;
    IBOutlet UIView *cardHolder;
}

@end
