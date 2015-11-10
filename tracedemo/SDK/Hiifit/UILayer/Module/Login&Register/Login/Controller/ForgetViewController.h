//
//  ForgetViewController.h
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"

@interface ForgetViewController : BaseViewController

@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;

@property (nonatomic, weak) IBOutlet UIButton    *nextBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

- (IBAction)nextAction:(UIButton*)btn;

@end
