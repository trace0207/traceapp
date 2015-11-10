//
//  SubSchemeHomeAck.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HF_BaseAck.h"

@interface SubSchemeHomeData : TK_BaseJsonModel

@property (nonatomic, assign) NSInteger levels;
@property (nonatomic, assign) NSInteger isSubscribe;
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, assign) NSInteger isOver;//1完成0未完成

@property (nonatomic, copy) NSString *disease;
@property (nonatomic, copy) NSString *parts;
@property (nonatomic, copy) NSString *picAddr;

@end

@interface SubSchemeHomeAck : HF_BaseAck

@property (nonatomic, strong) SubSchemeHomeData *data;

@end
