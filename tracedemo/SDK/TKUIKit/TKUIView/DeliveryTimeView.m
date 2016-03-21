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
        self.clipsToBounds = YES;
        self.layer.masksToBounds = NO;
        self.backgroundColor = [UIColor whiteColor];
        [[self layer] setCornerRadius:5];
        [[self layer] setShadowOffset:CGSizeMake(3, 3)];
        [[self layer] setShadowRadius:5];
        [[self layer] setShadowOpacity:0.8];
        [[self layer] setShadowColor:[UIColor blackColor].CGColor];
        
        [self chooseDate:self.threeBtn];
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
    if (button.tag == 1) {
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
