//
//  DeliveryTimeView.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/21.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "DeliveryTimeView.h"
#import "UIColor+TK_Color.h"
#import "UIButton+TitleImage.h"
#import "UIView+Border.h"

@implementation DeliveryTimeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDefaultBackgroundView];
        [self.hasReadBtn setImage:IMG(@"selected") forState:UIControlStateSelected];
        [self.onShowBtn setImage:IMG(@"selected") forState:UIControlStateSelected];
        [self.hasReadBtn setBorderColor:[UIColor hexChangeFloat:TKColorGreen] borderWidth:2];
        self.hasReadBtn.selected = YES;
        [self.onShowBtn setDefaultBorder];
        self.onShowBtn.selected = NO;
        [self.leftBtn setDefaultBorder];
        [self.rightBtn setDefaultBorder];
    }
    return self;
}
- (IBAction)chooseDate:(UIButton *)button
{
    int days = 0;
    if (button.tag == 1) {
        days = 1;
        [self.oneBtn setBorderColor:[UIColor hexChangeFloat:TKColorGreen] borderWidth:2];
        [self.oneBtn setTitleColor:[UIColor hexChangeFloat:TKColorGreen] forState:UIControlStateNormal];
        [self.oneBtn setLeftTitle:@"1天内发货" rightImage:IMG(@"selected")];
        
        [self.threeBtn setDefaultBorder];
        [self.threeBtn setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
        [self.threeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.threeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.threeBtn setTitle:@"3天内发货" forState:UIControlStateNormal];
        [self.threeBtn setImage:nil forState:UIControlStateNormal];
        
        [self.sevenBtn setDefaultBorder];
        [self.sevenBtn setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
        [self.sevenBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.sevenBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.sevenBtn setTitle:@"7天内发货" forState:UIControlStateNormal];
        [self.sevenBtn setImage:nil forState:UIControlStateNormal];
    }else if (button.tag == 2) {
        days = 3;
        [self.threeBtn setBorderColor:[UIColor hexChangeFloat:TKColorGreen] borderWidth:2];
        [self.threeBtn setTitleColor:[UIColor hexChangeFloat:TKColorGreen] forState:UIControlStateNormal];
        [self.threeBtn setLeftTitle:@"3天内发货" rightImage:IMG(@"selected")];
        
        [self.oneBtn setDefaultBorder];
        [self.oneBtn setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
        [self.oneBtn setTitle:@"1天内发货" forState:UIControlStateNormal];
        [self.oneBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.oneBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.oneBtn setImage:nil forState:UIControlStateNormal];
        
        [self.sevenBtn setDefaultBorder];
        [self.sevenBtn setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
        [self.sevenBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.sevenBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.sevenBtn setTitle:@"7天内发货" forState:UIControlStateNormal];
        [self.sevenBtn setImage:nil forState:UIControlStateNormal];
    }else {
        days = 7;
        [self.sevenBtn setBorderColor:[UIColor hexChangeFloat:TKColorGreen] borderWidth:2];
        [self.sevenBtn setTitleColor:[UIColor hexChangeFloat:TKColorGreen] forState:UIControlStateNormal];
        [self.sevenBtn setLeftTitle:@"7天内发货" rightImage:IMG(@"selected")];
        
        [self.threeBtn setDefaultBorder];
        [self.threeBtn setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
        [self.threeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.threeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.threeBtn setTitle:@"3天内发货" forState:UIControlStateNormal];
        [self.threeBtn setImage:nil forState:UIControlStateNormal];
        
        [self.oneBtn setDefaultBorder];
        [self.oneBtn setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
        [self.oneBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.oneBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.oneBtn setTitle:@"1天内发货" forState:UIControlStateNormal];
        [self.oneBtn setImage:nil forState:UIControlStateNormal];
    }
    self.actualLabel.text = [NSString stringWithFormat:@"您选择了“%i天内发货”，若买家同意您的发货时间，切记不要延期，否则平台将会按照“发货规则”执行罚金操作，同意将影响您的信用等级。",days];
}

- (void)setExpectDays:(int)expectDays
{
    _expectDays = expectDays;
    self.expectLabel.text = [NSString stringWithFormat:@"买家期望发货时间：%i天内发货",expectDays];
    if (expectDays == 1) {
        [self chooseDate:self.oneBtn];
    }else if (expectDays == 3) {
        [self chooseDate:self.threeBtn];
    }else {
        [self chooseDate:self.sevenBtn];
    }
}

- (IBAction)hasReadAction:(UIButton *)button
{
    if (self.hasReadBtn.selected) {
        [self.hasReadBtn setDefaultBorder];
    }else {
        [self.hasReadBtn setBorderColor:[UIColor hexChangeFloat:TKColorGreen] borderWidth:2];
    }
    self.hasReadBtn.selected = !self.hasReadBtn.selected;
}
- (IBAction)donotShowAction:(UIButton *)button
{
    if (self.onShowBtn.selected) {
        [self.onShowBtn setDefaultBorder];
    }else {
        [self.onShowBtn setBorderColor:[UIColor hexChangeFloat:TKColorGreen] borderWidth:2];
    }
    self.onShowBtn.selected = !self.onShowBtn.selected;
}
- (IBAction)fahuoRule:(UIButton *)button
{
    //发货规则
}
@end
