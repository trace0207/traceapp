//
//  TKAfterSalesViewController.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/4/6.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"
#import "TKTextView.h"
@interface TKAfterSalesViewController : TKIBaseNavWithDefaultBackVC
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHeight;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet TKTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *goOnLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic,strong)NSString *orderId;

- (IBAction)choosePicAction:(id)sender;
- (IBAction)submitAction:(id)sender;

+(void)showAfterSalesView:(NSString *)orderId;
@end
