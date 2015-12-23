//
//  LoadSchemeDataAck.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

@class HF_BaseAck;

@protocol LoadSchemeDataAck <NSObject>

@end

@interface LoadSchemeDataAck : TK_BaseJsonModel

@property (nonatomic, copy) NSString *crowd;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *iconAddr;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger offsetDay;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger id;//schemeId
@property (nonatomic, assign) NSInteger currDay;
@property (nonatomic, assign) NSInteger currStage;
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, assign) NSInteger isDeblocking;
@property (nonatomic, assign) NSInteger isOver;
@property (nonatomic, assign) NSInteger isJumpOverPage;
@property (nonatomic, assign) NSInteger isSubscribe;
@property (nonatomic, assign) NSInteger subscribeNum;
@property (nonatomic, assign) NSInteger userId;//当前登录用户id
@property (nonatomic, assign) NSInteger version;

@end
