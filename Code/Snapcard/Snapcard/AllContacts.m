//
//  AllContacts.m
//  Snapcard
//
//  Created by Pravin on 4/8/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "AllContacts.h"
#import "PPiFlatSegmentedControl.h"
#import "PPiFlatSegmentItem.h"
@interface AllContacts ()

@end

@implementation AllContacts
@synthesize mapView,carousalView,container;

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        FAKFoundationIcons *sel=[FAKFoundationIcons addressBookIconWithSize:30];
        [sel addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
        FAKFoundationIcons *unsel=[FAKFoundationIcons addressBookIconWithSize:30];
        [unsel addAttribute:NSForegroundColorAttributeName value:[UIColor lightThemeColor]];
        
        UIImage *selectedImage=[sel imageWithSize:CGSizeMake(30, 30)];
        UIImage *unselectedImage=[unsel imageWithSize:CGSizeMake(30, 30)];
        
        self.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"All Contacts" image:unselectedImage selectedImage:selectedImage];
        [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    [[CommonUtils sharedInstance] SetUpNavControllerWithid:self andTitle:@"All Contacts"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ContactsPage:) name:@"ContactsUI" object:nil];
    
    mapView = [[[NSBundle mainBundle] loadNibNamed:@"MapView" owner:self options:nil] objectAtIndex:0];
    carousalView =[[[NSBundle mainBundle] loadNibNamed:@"CarousalView" owner:self options:nil] objectAtIndex:0];
    
    mapView.frame=container.bounds;
    carousalView.frame=container.bounds;
    [container addSubview:carousalView];
    [container addSubview:mapView];
    
    NSArray *items = @[[[PPiFlatSegmentItem alloc] initWithTitle:@"List" andIcon:nil],
                       [[PPiFlatSegmentItem alloc] initWithTitle:@"Map" andIcon:nil]
                       ];
    PPiFlatSegmentedControl *segmented=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,40)
                                                                                items:items
                                                                         iconPosition:IconPositionRight
                                                                    andSelectionBlock:^(NSUInteger segmentIndex) {
                                                                        
                                                                        if(segmentIndex==1){
                                                                            [UIView transitionFromView:mapView toView:carousalView
                                                                                              duration:1.0
                                                                                               options:UIViewAnimationOptionTransitionFlipFromRight
                                                                                            completion:NULL];
                                                                        }
                                                                        else {

                                                                            [UIView transitionFromView:carousalView toView:mapView
                                                                                              duration:1.0
                                                                                               options:UIViewAnimationOptionTransitionFlipFromLeft
                                                                                            completion:NULL];
                                                                        }
                                                                    
                                                                    }
                                                                       iconSeparation:15];
    segmented.color=[UIColor lightThemeColor];
    segmented.selectedColor=[UIColor darkThemeColor];
    segmented.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmented.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                       NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented];
    
}



-(void)ContactsPage:(NSNotification*)notification{
    NSDictionary* userInfo = notification.userInfo;
    [self.navigationController pushViewController:[userInfo objectForKey:@"controller"] animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title=@"All Contacts";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
