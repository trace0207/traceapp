//
//  GetRunningDataAck.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HF_BaseAck.h"

@interface GetRunningData : TK_BaseJsonModel

@property(nonatomic,strong)NSString * createDate;
//@property(nonatomic)NSInteger createTime;
@property(nonatomic)NSInteger flag;
@property(nonatomic,strong)NSString * icon;
@property(nonatomic)NSInteger id;
@property(nonatomic,strong)NSString * name;
@property(nonatomic)NSInteger score;
@property(nonatomic)NSInteger scoreId;
@property(nonatomic)NSInteger step;
@property(nonatomic)NSInteger userId;
@property(nonatomic)NSInteger subSchemeId;
@property(nonatomic)NSInteger isOK;
@property(nonatomic)NSInteger targetStep;
@end


@interface GetRunningDataAck : HF_BaseAck

@property(nonatomic,strong)GetRunningData * data;

@end
