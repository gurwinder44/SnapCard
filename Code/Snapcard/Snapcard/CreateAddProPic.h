//
//  CreateAddProPic.h
//  Snapcard
//
//  Created by Pravin on 4/24/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAddProPic : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *imagePickerController;
}
@property NSUInteger pageIndex;

@end
