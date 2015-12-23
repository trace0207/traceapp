//
//  FinishSchemeAck.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

@class HF_BaseAck;

@interface FinishSchemeData : TK_BaseJsonModel
@property (nonatomic, assign) NSInteger totalDay;
@property (nonatomic, assign) NSInteger continueDay;
@property (nonatomic, assign) NSInteger tiebaId;
@property (nonatomic, assign) NSInteger status;//是否可以获得嗨豆（0，不可以；1，可以）
@property (nonatomic, assign) NSInteger score;//可获得嗨豆数
@end

@interface FinishSchemeAck : HF_BaseAck
@property (nonatomic, strong) FinishSchemeData *data;
@end
