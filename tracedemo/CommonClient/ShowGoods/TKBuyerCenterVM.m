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
    [[TKProxy proxy].mainProxy getShowOrders:self.category.categoryId
                                     brandId:self.brand.brandId
                                        page:0 withBlock:^(HF_BaseAck *ack) {
        
        //        DDLogInfo(@"orders list %@",ack);
        
        if([ack isKindOfClass:[TK_GetOrdersAck class]])
        {
            [weakSelf resetData:(TK_GetOrdersAck *)ack];
        }
        
        [weakSelf stopRefresh];
        
    }];
}

@end
