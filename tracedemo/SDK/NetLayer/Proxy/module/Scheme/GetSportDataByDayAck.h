//
//  GetSportDataByDayAck.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

@class HF_BaseAck;

@interface GetSportDataByDayData : TK_BaseJsonModel

@property(nonatomic,strong)NSString * createDate;
//@property(nonatomic)NSInteger createTime;
@property(nonatomic)NSInteger flag;
@property(nonatomic,strong)NSString * icon;
@property(nonatomic)NSInteger id;
@property(nonatomic)NSInteger isOK;
@property(nonatomic,strong)NSString * name;
@property(nonatomic)NSInteger schemeId;
@property(nonatomic)NSInteger score;
@property(nonatomic)NSInteger scoreId;
@property(nonatomic)NSInteger sportId;
@property(nonatomic)NSInteger subSchemeId;
@property(nonatomic,strong)NSString * title;
@property(nonatomic)NSInteger type;
@property(nonatomic)NSInteger userId;
@end


@interface GetSportDataByDayAck : HF_BaseAck

@property(nonatomic,strong)GetSportDataByDayData * data;

@end
