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
    [self.mTableView setTableHeaderView:self.header];
}

- (void)tkLoadDefaultData
{
    WS(weakSelf)
    [[TKProxy proxy].userProxy getUserHomePage:@"1" userType:1 withBoloc:^(HF_BaseAck *ack) {
       
        if(ack.sucess)
        {
            [weakSelf resetHeadView:(TK_GetUserHomePageAck *)ack];
        }
        else
        {
            [[HFHUDView shareInstance] ShowTips:@"加载用户基本信息失败" delayTime:2.0 atView:nil];
        }
        
        
    }];
    
    [[TKProxy proxy].mainProxy getCustomerPageOrders:@"1" page:0 withBolocl:^(HF_BaseAck *ack) {
        
        if(ack.sucess && [ack isKindOfClass:[TK_GetOrdersAck class]])
        {
            [weakSelf resetData:(TK_GetOrdersAck *)ack];
        }
        
        [weakSelf stopRefresh];
    }];
}


-(void)resetHeadView:(TK_GetUserHomePageAck *)ack
{
    TKSetHeadImageView(self.header.headImage,ack.data.headerUrl)
    self.header.nameLabel.text = ack.data.nickName;
    self.header.describleLabel.text = ack.data.signature;
    self.header.gradeLabel.text = ack.data.mobile;
}

@end
