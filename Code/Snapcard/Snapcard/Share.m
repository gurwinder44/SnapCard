//
//  Share.m
//  Snapcard
//
//  Created by Pravin on 4/8/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import "Share.h"



@interface Share ()

@end

@implementation Share

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        FAKFontAwesome *sel=[FAKFontAwesome shareAltIconWithSize:30];
        [sel addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
        FAKFontAwesome *unsel=[FAKFontAwesome shareAltIconWithSize:30];
        [unsel addAttribute:NSForegroundColorAttributeName value:[UIColor lightThemeColor]];
        
        UIImage *selectedImage=[sel imageWithSize:CGSizeMake(30, 30)];
        UIImage *unselectedImage=[unsel imageWithSize:CGSizeMake(30, 30)];
        
        self.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"Share" image:unselectedImage selectedImage:selectedImage];
        [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[CommonUtils sharedInstance] SetUpNavControllerWithid:self andTitle:@"Share"];
    UserProfile *user=[[CommonUtils sharedInstance] loadUserProfile];
    
    CIImage *qrImage=[self createQRForString:user.userid];
    
    float scaleX=_imageView.frame.size.width/ qrImage.extent.size.width;
    float scaleY=_imageView.frame.size.height/ qrImage.extent.size.height;
    _imageView.image=[[UIImage alloc] initWithCIImage:[qrImage imageByApplyingTransform:CGAffineTransformMakeScale(scaleX, scaleY)]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CIImage *)createQRForString:(NSString *)qrString {
    NSData *stringData = [qrString dataUsingEncoding: NSISOLatin1StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    
    return qrFilter.outputImage;
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title=@"Share";
}



@end
