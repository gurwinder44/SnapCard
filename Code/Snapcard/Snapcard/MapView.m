//
//  MapView.m
//  Snapcard
//
//  Created by Pravin on 4/8/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "MapView.h"

@implementation MapView

- (void)drawRect:(CGRect)rect {
    
}




-(void)awakeFromNib{
    
}

-(void)updateConstraints{
    [super updateConstraints];
    user=[[CommonUtils sharedInstance] loadUserProfile];
    isupdating=false;
    mapView.showsUserLocation=TRUE;
    
    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    [locationManager startUpdatingLocation];
    
    for (UserProfile *friend in user.friends){
        if(friend.meetingLocation){
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = friend.meetingLocation.coordinate;
            point.title = friend.firstName;
            point.subtitle =friend.designation;
            [mapView addAnnotation:point];
        }
    }

}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if(!isupdating){
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([locations objectAtIndex:0].coordinate, 2500, 500);
        [mapView setRegion:region animated:YES];
        isupdating=TRUE;
        [locationManager stopUpdatingLocation];
    }
    
    
}
@end
