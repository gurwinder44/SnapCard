//
//  AllContacts.h
//  Snapcard
//
//  Created by Pravin on 4/8/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapView.h"
#import "CarousalView.h"


@interface AllContacts : UIViewController

@property (strong, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic)  MapView *mapView;
@property (strong, nonatomic)  CarousalView *carousalView;



@end
