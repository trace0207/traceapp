//
//  TKIShowGoodsVM.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKTableViewVM.h"

#import "TK_GetOrdersAck.h"
#import "TK_Brand.h"
#import "TK_ShareCategory.h"

@interface TKIShowGoodsVM : TKTableViewVM

@property (nonatomic,strong)TK_Brand * brand;
@property (nonatomic,strong)TK_ShareCategory * category;

@property (nonatomic,assign) BOOL hasInitData;
-(void)resetData:(TK_GetOrdersAck *)ack;
@end
