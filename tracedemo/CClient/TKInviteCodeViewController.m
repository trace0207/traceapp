//
//  TKInviteCodeViewController.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/31.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKInviteCodeViewController.h"
#import "UIView+Border.h"
@interface TKInviteCodeViewController ()
{
    BOOL hasCode;
}
@end

@implementation TKInviteCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor HFColorStyle_6];
    [self.kcopyButton setDefaultBorder];
    self.inviteCodeLabel.text = @"邀请码未生成";
    [self.kcopyButton setTitle:@"生成邀请码" forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)kCopyAction:(id)sender {
    if (hasCode == NO) {
        self.inviteCodeLabel.text = @"KSDFJE8";
        [self.kcopyButton setTitle:@"复制" forState:UIControlStateNormal];
        hasCode = YES;
    }else{
        UIPasteboard *generalPasteBoard = [UIPasteboard generalPasteboard];
        [generalPasteBoard setString:self.inviteCodeLabel.text];
    }
}
@end
