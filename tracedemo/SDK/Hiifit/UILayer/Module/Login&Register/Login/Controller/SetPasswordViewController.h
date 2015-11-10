//
//  SetPasswordViewController.h
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"

@interface SetPasswordViewController : BaseViewController

@property (nonatomic, weak) IBOutlet UITextField *pwdTextField;
@property (nonatomic, weak) IBOutlet UIImageView *eyeImage;
@property (nonatomic, weak) IBOutlet UIView      *line;
@property (nonatomic, weak) IBOutlet UIButton    *modifyBtn;

- (IBAction)modifyPassword:(id)sender;

- (IBAction)displayPassword:(id)sender;

@end
