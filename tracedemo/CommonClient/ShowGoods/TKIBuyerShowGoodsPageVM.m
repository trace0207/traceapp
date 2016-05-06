//
//  TKIBuyerShowGoodsPageVM.m
//  tracedemo
//
//  Created by cmcc on 16/4/18.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBuyerShowGoodsPageVM.h"
#import "TKUITools.h"
#import "TKUserCenter.h"




@implementation TKIBuyerShowGoodsPageVM


-(void)tkLoadDefaultData
{
    NSString * userid = [TKUserCenter instance].getUser.userId;
    NSInteger page = self.nowPage;
    WS(weakSelf)
    if(self.isFromBottom)
    {
        page = page +1;
    }
    [[TKProxy proxy].mainProxy getBuyerHomePageOrders:userid page:page withBlock:^(HF_BaseAck *ack) {
       
        if(ack.sucess)
        {
            if([ack isKindOfClass:[TK_GetOrdersAck class]])
            {
                if([ack isKindOfClass:[TK_GetOrdersAck class]] && ack.sucess)
                {
                    [weakSelf resetData:(TK_GetOrdersAck *)ack];
                }
                
                [weakSelf stopRefresh];
                
                if(self.nowPage == 0 && weakSelf.defaultSection.rowsData.count == 0)
                {
                    [weakSelf showTipsView:[TKUITools getListViewEmptyTip]];
                }
            }
        }
        
    }];
}

@end
