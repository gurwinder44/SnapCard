//
//  createSocial.h
//  Snapcard
//
//  Created by Pravin on 3/31/16.
//  Copyright © 2016 MobileComputing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"

@interface createSocial : UIViewController

@property (nonatomic) NSUInteger pageIndex;
@property NSString *key;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *txtField;
@property (weak, nonatomic) IBOutlet UIButton *skipbtn;

@end
