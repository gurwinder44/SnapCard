//
//  CardView2.h
//  Snapcard
//
//  Created by Pravin on 4/10/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView2 : UIView <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *profileName;
@property (strong, nonatomic) UserProfile *user;
@end
