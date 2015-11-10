//
//  HFReportView.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFReportView.h"

@implementation HFReportView


- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.reportBtn setTitleColor:[UIColor HFColorStyle_5] forState:UIControlStateNormal];
    currentIndex = 1;
    UIImageView *imageView = (UIImageView *)[self viewWithTag:101];
    imageView.highlighted = YES;
    _bgView.clipsToBounds = YES;
    _bgView.layer.cornerRadius = 3.0f;
}

- (IBAction)cancelAction:(id)sender
{
    [self removeFromSuperview];
}

- (IBAction)reportAction:(id)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    WS(weakSelf)
    [[[HIIProxy shareProxy]weiboProxy]reportWeiboType:_data.type andWeiboId:_data.weiboId andUserId:_data.authorId informType:currentIndex success:^(BOOL finished) {
        [hud hide:YES];
        [weakSelf removeFromSuperview];
        if (finished) {
            [MBProgressHUD showSuccess:@"举报成功" toView:[UIKitTool getAppdelegate].window];
        }else{
            [MBProgressHUD showSuccess:@"举报失败" toView:[UIKitTool getAppdelegate].window];
        }
    }];
}

- (IBAction)selectAction:(UIButton *)btn
{
    currentIndex = btn.tag - 200;
    for (NSInteger i = 1; i <= 5; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:100+i];
        if (i == currentIndex) {
            imageView.highlighted = YES;
        }else {
            imageView.highlighted = NO;
        }
    }
}

@end
