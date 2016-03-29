//
//  TKPublishShowGoodsArg.h
//  tracedemo
//
//  Created by cmcc on 16/3/3.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"
#import "TK_PublishRewardArg.h"

@interface TKPublishShowGoodsArg : HF_BaseArg

@property (nonatomic,copy)NSString *orderId;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *brandId;
@property (nonatomic,copy)NSString *categoryId;
@property (nonatomic,copy)NSString *role;
@property (nonatomic,copy)NSString *showPrice;
@property (nonatomic,copy)NSString *picAddr1;
@property (nonatomic,copy)NSString *picAddr2;
@property (nonatomic,copy)NSString *picAddr3;
@property (nonatomic,copy)NSString *picAddr4;
@property (nonatomic,copy)NSString *picAddr5;
@property (nonatomic,copy)NSString *picAddr6;
@property (nonatomic,copy)NSString *picAddr7;
@property (nonatomic,copy)NSString *picAddr8;
@property (nonatomic,copy)NSString *picAddr9;


/**
  arg 对象转换
 **/
+(TKPublishShowGoodsArg *)changeFromRrewardArg:(TK_PublishRewardArg*)arg;

@end
