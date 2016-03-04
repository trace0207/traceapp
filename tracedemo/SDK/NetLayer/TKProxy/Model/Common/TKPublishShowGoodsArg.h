//
//  TKPublishShowGoodsArg.h
//  tracedemo
//
//  Created by cmcc on 16/3/3.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TKPublishShowGoodsArg : HF_BaseArg

@property (nonatomic,copy)NSString *orderId;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,assign)NSInteger brandId;
@property (nonatomic,assign)NSInteger categoryId;
@property (nonatomic,assign)NSInteger role;
@property (nonatomic,assign)NSInteger showPrice;
@property (nonatomic,copy)NSString *picAddr1;
@property (nonatomic,copy)NSString *picAddr2;
@property (nonatomic,copy)NSString *picAddr3;
@property (nonatomic,copy)NSString *picAddr4;
@property (nonatomic,copy)NSString *picAddr5;
@property (nonatomic,copy)NSString *picAddr6;
@property (nonatomic,copy)NSString *picAddr7;
@property (nonatomic,copy)NSString *picAddr8;
@property (nonatomic,copy)NSString *picAddr9;



@end
