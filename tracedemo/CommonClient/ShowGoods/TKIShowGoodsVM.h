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
#import "TKSHowGoodsCell.h"
#import "TKRewardCell.h"


@protocol TKShowGoodsVMDelegate <NSObject>

@optional
-(void)onFollowAction:(TKIShowGoodsRowM *)row;
-(void)onIWantAction:(TKRewardCellModel*)row;

@end

@interface TKIShowGoodsVM : TKTableViewVM<TKShowGoodsCellDelegate>

@property (nonatomic,strong)TK_Brand * brand;
@property (nonatomic,strong)TK_ShareCategory * category;
@property (weak,nonatomic) id<TKShowGoodsVMDelegate> showGoodsDelegate;


@property (nonatomic,assign) BOOL hasInitData;
-(void)resetData:(TK_GetOrdersAck *)ack;
@end
