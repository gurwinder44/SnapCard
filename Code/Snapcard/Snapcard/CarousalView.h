//
//  CarousalView.h
//  Snapcard
//
//  Created by Pravin on 4/8/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Contacts;
@import ContactsUI;

@interface CarousalView : UIView<iCarouselDelegate,iCarouselDataSource,CNContactViewControllerDelegate>
{
    IBOutlet iCarousel *aCarousel;
}

@property (nonatomic,retain) UserProfile *user;

@end
