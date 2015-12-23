//
//  GetDiaryDataByDayAck.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

@class HF_BaseAck;

@interface GetDiaryDataByDayData : TK_BaseJsonModel

@property(nonatomic,strong)NSString * content;
@property(nonatomic,strong)NSString * createDate;
//@property(nonatomic,strong)NSDictionary * createTime;
@property(nonatomic)NSInteger flag;
@property(nonatomic,strong)NSString * icon;
@property(nonatomic)NSInteger id;
@property(nonatomic)NSInteger isOK;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * picAddr;
@property(nonatomic)NSInteger schemeId;
@property(nonatomic)NSInteger score;
@property(nonatomic)NSInteger scoreId;
@property(nonatomic)NSInteger subSchemeId;
@property(nonatomic)NSInteger userId;
@end


@interface GetDiaryDataByDayAck : HF_BaseAck

@property(nonatomic,strong)GetDiaryDataByDayData * data;

@end
