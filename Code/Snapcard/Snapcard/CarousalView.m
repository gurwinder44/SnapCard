//
//  CarousalView.m
//  Snapcard
//
//  Created by Pravin on 4/8/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "CarousalView.h"
#import "CardView.h"
#import "CardView2.h"

@implementation CarousalView
@synthesize user;

- (void)drawRect:(CGRect)rect {
    
}


-(void)awakeFromNib{
    [self setBackgroundColor:[UIColor lightThemeColor]];
    [aCarousel setBackgroundColor:[UIColor lightThemeColor]];
    aCarousel.type = iCarouselTypeCoverFlow;
    user=[[CommonUtils sharedInstance] loadUserProfile];
    [aCarousel reloadData];

}

-(void)updateConstraints{
    [super updateConstraints];
    user=[[CommonUtils sharedInstance] loadUserProfile];
    [aCarousel reloadData];
}



- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return user.friends.count;
}


-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    //create a numbered view
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    CardView *rootView = [[[NSBundle mainBundle] loadNibNamed:@"CardView2" owner:self options:nil] objectAtIndex:0];
    rootView.user=[user.friends objectAtIndex:index];
    rootView.frame=CGRectMake(0, 0, 300, 400);
    [view addSubview:rootView];
    return view;
    
}

//- (NSInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel{
//    //note: placeholder views are only displayed on some carousels if wrapping is disabled
//    return 0;
//}


- (BOOL)carouselShouldWrap:(iCarousel *)carousel{
    //wrap all carousels
    return false;
}


- (void)carouselDidScroll:(iCarousel *)carousel{
    
}

- (IBAction)saveContact:(id)sender {
    if(user.friends.count>0){
        UserProfile *friend=[user.friends objectAtIndex:aCarousel.currentItemIndex];
        CNContactStore *store = [[CNContactStore alloc] init];
        
        // create contact
        
        CNMutableContact *contact = [[CNMutableContact alloc] init];
        contact.givenName = friend.firstName;
        
        CNLabeledValue *homePhone = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:[CNPhoneNumber phoneNumberWithStringValue:friend.phoneNumber]];
        contact.phoneNumbers = @[homePhone];
        
        CNContactViewController *controller = [CNContactViewController viewControllerForUnknownContact:contact];
        controller.contactStore = store;
        controller.delegate = self;
        
       //[ pushViewController:controller animated:TRUE];
        NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
        [dict setObject:controller forKey:@"controller"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ContactsUI" object:nil userInfo:dict];
    }
}

@end
