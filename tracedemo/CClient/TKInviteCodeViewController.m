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

@end

@implementation TKInviteCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor HFColorStyle_6];
    [self.kcopyButton setDefaultBorder];
    self.inviteCodeLabel.text = @"邀请码未生成";
    [self.kcopyButton setTitle:@"生成邀请码" forState:UIControlStateNormal];
    [self.kcopyButton setTitle:@"复制" forState:UIControlStateSelected];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)kCopyAction:(id)sender {
    if (self.kcopyButton.selected == NO) {
        self.kcopyButton.selected = YES;
        self.inviteCodeLabel.text = @"KSDFJE8";
    }else{
        UIPasteboard *generalPasteBoard = [UIPasteboard generalPasteboard];
        [generalPasteBoard setString:self.inviteCodeLabel.text];
    }
}
@end
