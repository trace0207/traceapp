//
//  TKPublishShowGoodsArg.m
//  tracedemo
// 发布晒单
//  Created by cmcc on 16/3/3.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKPublishShowGoodsArg.h"

@implementation TKPublishShowGoodsArg



/**
 arg 对象转换
 **/
+(TKPublishShowGoodsArg *)changeFromRrewardArg:(TK_PublishRewardArg*)arg
{
    

    
    TKPublishShowGoodsArg * a = [[TKPublishShowGoodsArg alloc] init];
    a.picAddr1 = arg.picAddr1;
    a.picAddr2 = arg.picAddr2;
    a.picAddr3 = arg.picAddr3;
    a.picAddr4 = arg.picAddr4;
    a.picAddr5 = arg.picAddr5;
    a.picAddr6 = arg.picAddr6;
    a.picAddr7 = arg.picAddr7;
    a.picAddr8 = arg.picAddr8;
    a.picAddr9 = arg.picAddr9;
    a.content = arg.content;
    a.categoryId = arg.categoryId;
    a.brandId = arg.brandId;
    a.showPrice = arg.rewardPrice;
    return a;
    
}

@end
