//
//  TKBuyerCenterVM.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/31.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKBuyerCenterVM.h"
#import "TK_GetOrdersAck.h"
#import "TKShowGoodsCell.h"
#import "TK_GetUserHomePageAck.h"

@interface TKBuyerCenterVM ()
@property (nonatomic, strong) TKShowGoodsCell *header;
@end

@implementation TKBuyerCenterVM

- (TKShowGoodsCell *)header
{
    if (nil == _header) {
        _header = [[[NSBundle mainBundle]loadNibNamed:@"TKShowGoodsCell" owner:self options:nil]objectAtIndex:1];
    }
    return _header;
}
- (void)defaultViewSetting
{
//    self.userId = @"1";
    [self.mTableView setTableHeaderView:self.header];
    
}

- (void)tkLoadDefaultData
{
    if(self.isBuyer)
    {
        [self loadBuyerData];
    }
    else
    {
        [self loadCustomerData];
    }
}


-(void)resetCustomerHeadView:(TK_GetUserHomePageAck *)ack
{
    TKSetHeadImageView(self.header.headImage,ack.data.headerUrl)
    self.header.nameLabel.text = ack.data.nickName;
    self.header.describleLabel.text = ack.data.signature;
    self.header.gradeLabel.text = ack.data.mobile;
}

-(void)resetBuyerHeadView:(TK_GetUserHomePageAck *)ack
{
    TKSetHeadImageView(self.header.headImage,ack.data.headerUrl)
    self.header.nameLabel.text = ack.data.purchaserName;
    self.header.describleLabel.text = ack.data.signature;
    self.header.gradeLabel.text = [NSString stringWithFormat:@"  Vip %@ 级买手",ack.data.vip];

}


-(void)loadBuyerData
{
    WS(weakSelf)
    [[TKProxy proxy].mainProxy getBuyerUserInfo:self.userId withBlock:^(HF_BaseAck *ack) {
        if(ack.sucess)
        {
            TK_GetUserHomePageAck * buyInfo =   (TK_GetUserHomePageAck *)ack;
            [weakSelf resetBuyerHeadView:buyInfo];
        }
        else
        {
            [[HFHUDView shareInstance] ShowTips:@"加载用户基本信息失败" delayTime:2.0 atView:nil];
        }
    }];
    
    [[TKProxy proxy].mainProxy getBuyerHomePageOrders:self.userId page:0 withBlock:^(HF_BaseAck *ack) {
        if(ack.sucess && [ack isKindOfClass:[TK_GetOrdersAck class]])
        {
            [weakSelf resetData:(TK_GetOrdersAck *)ack];
        }
        
        [weakSelf stopRefresh];
    }];
}

-(void)loadCustomerData
{
    WS(weakSelf)
    [[TKProxy proxy].userProxy getUserHomePage:self.userId userType:1 withBoloc:^(HF_BaseAck *ack) {
        
        if(ack.sucess)
        {
            [weakSelf resetCustomerHeadView:(TK_GetUserHomePageAck *)ack];
        }
        else
        {
            [[HFHUDView shareInstance] ShowTips:@"加载用户基本信息失败" delayTime:2.0 atView:nil];
        }
        
        
    }];
    
    [[TKProxy proxy].mainProxy getCustomerPageOrders:self.userId page: 0 withBolocl:^(HF_BaseAck *ack) {
        
        if(ack.sucess && [ack isKindOfClass:[TK_GetOrdersAck class]])
        {
            [weakSelf resetData:(TK_GetOrdersAck *)ack];
        }
        
        [weakSelf stopRefresh];
    }];
}






@end
