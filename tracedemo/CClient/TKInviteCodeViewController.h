//
//  TKInviteCodeViewController.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/31.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"

@interface TKInviteCodeViewController : TKIBaseNavWithDefaultBackVC
@property (weak, nonatomic) IBOutlet UILabel *inviteCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *kcopyButton;
- (IBAction)kCopyAction:(id)sender;

@end
