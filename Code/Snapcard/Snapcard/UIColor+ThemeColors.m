//
//  UIColor+ThemeColors.m
//  FavorLooper
//
//  Created by Pravin on 4/22/15.
//  Copyright (c) 2015 FavorLooper. All rights reserved.
//

#import "UIColor+ThemeColors.h"

@implementation UIColor (ThemeColors)
+ (UIColor*)themeGreen {
    return [UIColor colorWithRed:73.0/255.0 green:138.0/255.0 blue:69.0/255.0 alpha:1];
    //return [UIColor colorWithRed:62.0/255.0 green:124.0/255.0 blue:214.0/255.0 alpha:1.0];
}
+ (UIColor*)HeaderColor{
    return [UIColor colorWithRed:73.0/255.0 green:138.0/255.0 blue:69.0/255.0 alpha:1];
    //return [UIColor colorWithRed:214.0/255.0 green:69.0/255.0 blue:73.0/255.0 alpha:1.0];
    //return [UIColor colorWithRed:62.0/255.0 green:124.0/255.0 blue:214.0/255.0 alpha:1.0];
}

+(UIColor*)TableHeader{
    return [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
}



//Dashboard

+ (UIColor*)KarmaPointsRed{
    return [UIColor colorWithRed:214.0/255.0 green:69.0/255.0 blue:73.0/255.0 alpha:0.0];
}
+ (UIColor*)KarmaPointsBlue{
    return [UIColor colorWithRed:62.0/255.0 green:124.0/255.0 blue:214.0/255.0 alpha:0.0];
}
+ (UIColor*)LightText{
    return [UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:0.5];
}

+ (UIColor*)LightBorderGreen{
    return [UIColor colorWithRed:73.0/255.0 green:138.0/255.0 blue:69.0/255.0 alpha:0.65];
}

+ (UIColor*)whiteFaded{
    return [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.65];
}
+ (UIColor*)themeGrey{
    return [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
}

+(UIColor*)themeBlue{
    return [UIColor colorWithRed:62.0/255.0 green:124.0/255.0 blue:214.0/255.0 alpha:1];
}

+(UIColor*)themeColor{
    //brown
        //return [UIColor colorWithRed:78.0/255.0 green:52.0/255.0 blue:46.0/255.0 alpha:1];
    //orange
        //return [UIColor colorWithRed:240.0/255.0 green:138.0/255.0 blue:93.0/255.0 alpha:1];
    //YIK YAK blue
        return [UIColor colorWithRed:254.0/255.0 green:150.0/255.0 blue:39.0/255.0 alpha:1];
}

+(UIColor*)FAbtnColors{
    return [UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1];
}


+(UIColor *)darkThemeColor{
    return [UIColor flatNavyBlueColorDark];
}

+(UIColor *)lightThemeColor{
    return [UIColor flatNavyBlueColor];
}

+(UIColor*)faceBookColor{
    return [UIColor colorWithHexString:@"3b5998"];
}

+(UIColor*)twitterColor{
    return [UIColor colorWithHexString:@"00aced"];
}

+(UIColor*)instagramColor{
    return [UIColor colorWithHexString:@"3f729b"];
}


+(UIColor*)linkedInColor{
    return [UIColor colorWithHexString:@"0077b5"];
}

+(UIColor*)pintrestColor{
    return [UIColor colorWithHexString:@"bd081c"];
}

+(UIColor*)gitHubInColor{
    return [UIColor colorWithHexString:@"554488"];
}

+(UIColor*)snapChatColor{
    return [UIColor colorWithHexString:@"#ffcc00"];
}

+(UIColor*)starColor{
    return [UIColor colorWithHexString:@"f9d616"];
}



@end
