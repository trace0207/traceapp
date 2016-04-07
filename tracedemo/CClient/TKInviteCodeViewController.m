//
//  TKInviteCodeViewController.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/31.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKInviteCodeViewController.h"
#import "UIView+Border.h"
#import "TK_GetInviteCodeAck.h"
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
        
        [[TKProxy proxy].mainProxy createInviteCode:^(HF_BaseAck *ack) {
           
            if(ack.sucess)
            {
                TK_GetInviteCodeAck *ackData = (TK_GetInviteCodeAck *)ack;
                self.inviteCodeLabel.text = ackData.data ;
                hasCode = YES;
                [self.kcopyButton setTitle:@"点击复制" forState:UIControlStateNormal];
            }
            else
            {
                [[HFHUDView shareInstance] ShowTips:ack.msg delayTime:1.0 atView:NULL];
            }
        }];
        
    }else{
        UIPasteboard *generalPasteBoard = [UIPasteboard generalPasteboard];
        [generalPasteBoard setString:self.inviteCodeLabel.text];
        [[HFHUDView shareInstance] ShowTips:@"邀请码已赋值到剪切板" delayTime:1.0 atView:NULL];
    }
}
@end
