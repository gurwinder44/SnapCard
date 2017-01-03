//
//  HomeLocationSelect.m
//  Snapcard
//
//  Created by Pravin on 4/19/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "HomeLocationSelect.h"


@interface HomeLocationSelect ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;


@end

@implementation HomeLocationSelect

- (void)viewDidLoad {
    [super viewDidLoad];
    geocoder=[[CLGeocoder alloc] init];
    annotationPoint=[[MKPointAnnotation alloc] init];
    [self.view setBackgroundColor:[UIColor lightThemeColor]];
    
     _mapView.showsUserLocation=YES;
    [_toolBar setBarTintColor:[UIColor darkThemeColor]];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPin:)];
    [recognizer setNumberOfTapsRequired:1];
    [_mapView addGestureRecognizer:recognizer];
    _mapView.delegate=self;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
    isUpdateOnce=YES;
    
}


- (IBAction)setHomeAddressClicked:(id)sender {
    
    
    
    if(homeLocation && fullAddress){
        UserProfile *user=[[CommonUtils sharedInstance] loadUserProfile];
        user.homelocation=homeLocation;
        user.homelocationAddress=fullAddress;
        [[CommonUtils sharedInstance] saveUserProfile:user];
    }
    
    if(_modeOfEntry==0){
        NSDictionary *dict=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%lu",(unsigned long)_pageIndex],@"index", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PCNext" object:self userInfo:dict];
        
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}



- (void)addPin:(UITapGestureRecognizer*)recognizer{
    [_mapView removeAnnotation:annotationPoint];
    [self clearOverlays];
    CGPoint tappedPoint = [recognizer locationInView:_mapView];
    CLLocationCoordinate2D coord= [_mapView convertPoint:tappedPoint toCoordinateFromView:_mapView];
    //Add Annotation
    [annotationPoint setCoordinate:coord];
    [annotationPoint setTitle:@"Marked here"];
    [_mapView addAnnotation:annotationPoint];
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:coord radius:1610];
    [_mapView addOverlay:circle];
    homeLocation=[[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    
    [geocoder reverseGeocodeLocation:homeLocation completionHandler:^(NSArray *placemarks, NSError *error){
        CLPlacemark *placemark = placemarks[0];
        if(!fullAddress){fullAddress=[[NSString alloc] init];}
//        fullAddress=[NSString stringWithFormat:@"%@ %@ %@ %@- %@",placemark.name,placemark.thoroughfare,placemark.locality,placemark.country,placemark.postalCode];//
        fullAddress=@"";
        BOOL islocalityAdded=NO;
        if (!(placemark.name == (id)[NSNull null] || placemark.name == 0 )){
            fullAddress=[NSString stringWithFormat:@"%@ %@",fullAddress,placemark.name];
        }
        if (!(placemark.locality == (id)[NSNull null] || placemark.locality == 0 || islocalityAdded)) {
            fullAddress=[NSString stringWithFormat:@"%@ %@",fullAddress,placemark.locality];
        }
        if (!(placemark.country == (id)[NSNull null] || placemark.country == 0 )){
            fullAddress=[NSString stringWithFormat:@"%@ %@",fullAddress,placemark.country];
        }
        if (!(placemark.postalCode == (id)[NSNull null] || placemark.postalCode == 0 )){
            fullAddress=[NSString stringWithFormat:@"%@-%@",fullAddress,placemark.postalCode];
        }
        [_addressLabel setText:fullAddress];
    }];
}


#pragma MapView Delegate

-(MKCircleRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay{
    MKCircleRenderer *circleView= [[MKCircleRenderer alloc] initWithOverlay:overlay];
    circleView.strokeColor = [UIColor redColor];
    circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
    circleView.lineWidth = 1;
    return circleView;
}

- (void)clearOverlays{
    NSArray *overlayCountries = [_mapView   overlays];
    [_mapView removeOverlays:overlayCountries];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if(isUpdateOnce){
        if(!currentLocation){currentLocation=[[CLLocation alloc] init];}
            currentLocation=newLocation;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 2500, 500);
        [self.mapView setRegion:region animated:YES];
            isUpdateOnce=FALSE;
            [manager stopUpdatingLocation];
    }
 
}
@end
