//
//  UserProfile.m
//  Snapcard
//
//  Created by Pravin on 3/30/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile
-(void)encodeWithCoder:(NSCoder *)encoder
{

    //Basic Information object
    [encoder encodeObject:self.userid forKey:@"userid"];
    [encoder encodeObject:self.firstName forKey:@"firstname"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
    [encoder encodeObject:self.designation forKey:@"designation"];
    [encoder encodeObject:self.companyOrInstitution forKey:@"companyOrInstitution"];
    
    //Other Basics Information
    [encoder encodeObject:self.peronalURL forKey:@"peronalURL"];
    [encoder encodeObject:self.homelocation forKey:@"homelocation"];
    [encoder encodeObject:self.officeLocation forKey:@"officeLocation"];
    [encoder encodeObject:self.homelocationAddress forKey:@"homelocationAddress"];
    [encoder encodeObject:self.officeLocationAddress forKey:@"officeLocationAddress"];
    
    //Social Information
    [encoder encodeObject:self.facebookID forKey:@"facebookID"];
    [encoder encodeObject:self.twitterID forKey:@"twitterID"];
    [encoder encodeObject:self.instagramID forKey:@"instagramID"];
    [encoder encodeObject:self.pintrestID forKey:@"pintrestID"];
    [encoder encodeObject:self.linkedinID forKey:@"linkedinID"];
    [encoder encodeObject:self.gitHubID forKey:@"gitHubID"];
    [encoder encodeObject:self.snapchatID forKey:@"snapchatID"];
    [encoder encodeObject:self.profilepic forKey:@"profilepic"];
    [encoder encodeObject:self.friends forKey:@"friends"];
    [encoder encodeObject:self.meetingLocation forKey:@"meetingLocation"];
    [encoder encodeObject:self.deviceToken forKey:@"deviceToken"];
    
}




-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if ( self != nil )
    {
        //decode the properties
        self.userid = [decoder decodeObjectForKey:@"userid"];
        self.firstName = [decoder decodeObjectForKey:@"firstname"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.phoneNumber = [decoder decodeObjectForKey:@"phoneNumber"];
        self.designation = [decoder decodeObjectForKey:@"designation"];
        self.companyOrInstitution = [decoder decodeObjectForKey:@"companyOrInstitution"];
        
        //Other Basics Information
        self.peronalURL=[decoder decodeObjectForKey:@"peronalURL"];
        self.homelocation=[decoder decodeObjectForKey:@"homelocation"];
        self.officeLocation=[decoder decodeObjectForKey:@"officeLocation"];
        self.homelocationAddress=[decoder decodeObjectForKey:@"homelocationAddress"];
        self.officeLocationAddress=[decoder decodeObjectForKey:@"officeLocationAddress"];
        self.friends=[decoder decodeObjectForKey:@"friends"];
        self.meetingLocation=[decoder decodeObjectForKey:@"meetingLocation"];
        
        //Social Information
        self.facebookID= [decoder decodeObjectForKey:@"facebookID"];
        self.twitterID=[decoder decodeObjectForKey:@"twitterID"];
        self.instagramID=[decoder decodeObjectForKey:@"instagramID"];
        self.linkedinID=[decoder decodeObjectForKey:@"linkedinID"];
        self.pintrestID=[decoder decodeObjectForKey:@"pintrestID"];
        self.gitHubID=[decoder decodeObjectForKey:@"gitHubID"];
        self.snapchatID=[decoder decodeObjectForKey:@"snapchatID"];
        self.profilepic=[decoder decodeObjectForKey:@"profilepic"];
        self.deviceToken=[decoder decodeObjectForKey:@"deviceToken"];
        
    }
    return self;
}
@end
