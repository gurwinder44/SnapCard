//
//  UserProfile.h
//  Snapcard
//
//  Created by Pravin on 3/30/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface UserProfile : NSObject<NSCoding>

//Basic Information
@property (strong, nonatomic) NSString* userid;
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* phoneNumber;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* designation;
@property (strong, nonatomic) NSString* companyOrInstitution;

//Other Basics Information
@property (strong, nonatomic) NSString* peronalURL;
@property (strong, nonatomic) CLLocation* homelocation;
@property (strong, nonatomic) CLLocation* officeLocation;
@property (strong, nonatomic) NSString* homelocationAddress;
@property (strong, nonatomic) NSString* officeLocationAddress;

//Social   Information
@property (strong, nonatomic) NSString* facebookID;
@property (strong, nonatomic) NSString* twitterID;
@property (strong, nonatomic) NSString* instagramID;
@property (strong, nonatomic) NSString* pintrestID;
@property (strong, nonatomic) NSString* linkedinID;
@property (strong, nonatomic) NSString* gitHubID;
@property (strong, nonatomic) NSString* snapchatID;
@property (strong, nonatomic) NSString* profilepic;

@property (strong,nonatomic) NSString* deviceToken;


//For Friends
@property (strong, nonatomic) NSMutableArray* friends;

//Location Information
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong,nonatomic) CLLocation *meetingLocation;

//

//FRIENDS


@end
