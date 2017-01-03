//
//  Profile.h
//  Snapcard
//
//  Created by Pravin on 4/2/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"

@interface Profile : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>
{
    UserProfile *user;
    NSString *instanceUrl;
    NSString *accessToken;
    int chosenIndex;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
