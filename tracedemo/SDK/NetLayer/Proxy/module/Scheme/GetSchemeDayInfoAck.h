//
//  GetSchemeDayInfoAck.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HF_BaseAck.h"

@protocol GetSchemeDayInfoList <NSObject>

@end

@interface GetSchemeDayInfoList : TK_BaseJsonModel

@property(nonatomic)NSInteger flag;
@property(nonatomic)NSInteger schemeStageId;
@property(nonatomic,strong)NSString * schemeStageName;
@end



@interface GetSchemeDayInfoData : TK_BaseJsonModel

@property(nonatomic)NSInteger currDay;
@property(nonatomic)NSInteger days;
@property(nonatomic,strong)NSString * endTime;
@property(nonatomic)NSInteger flag;
@property(nonatomic)NSInteger id;
@property(nonatomic)NSInteger offsetDay;
@property(nonatomic)NSInteger schemeId;
@property(nonatomic,strong)NSString * schemeName;
@property(nonatomic,strong)NSString * stageName;
@property(nonatomic,strong)NSString * stageTarget;
@property(nonatomic,strong)NSString * startTime;
@property(nonatomic)NSInteger status;
@property(nonatomic)NSInteger userId;
@property (nonatomic, assign) NSInteger tieBaUnreadCount;

@property(nonatomic,strong)NSArray<GetSchemeDayInfoList>  * list;


@end


@interface GetSchemeDayInfoAck : HF_BaseAck

@property(nonatomic,strong)GetSchemeDayInfoData * data;

@end
