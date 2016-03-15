//
//  HF_BaseAck.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "TK_JsonModelAck.h"

@interface HF_BaseAck : TK_JsonModelAck

@property (nonatomic, assign)   NSInteger        recode;     //返回码
@property (nonatomic,   copy)   NSString         *msg;       //返回消息
@property(nonatomic,strong)NSString <Ignore> *successCode;


- (BOOL)sucess;



@end
