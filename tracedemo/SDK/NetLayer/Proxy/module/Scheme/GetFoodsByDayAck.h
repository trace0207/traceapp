//
//  GetFoodsByDayAck.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HF_BaseAck.h"


@protocol GetFoodsByMealCookData <NSObject>

@end

@interface GetFoodsByMealCookData : TK_BaseJsonModel

@property(nonatomic)NSInteger calorieId;
@property(nonatomic,strong)NSString * calorieName;
@property(nonatomic,strong)NSString * calorieTips;
@property(nonatomic)NSString * picAddr;
@property(nonatomic)NSInteger id;
@property(nonatomic)NSInteger days;
@property(nonatomic)NSInteger mealType;
@property(nonatomic)NSInteger schemeId;

@end



@protocol GetFoodsByMealData <NSObject>

@end

@interface GetFoodsByMealData : TK_BaseJsonModel

@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString * createDate;
//@property(nonatomic,strong)NSDictionary * createTime;
@property(nonatomic,strong)NSString * endTime;
@property(nonatomic)NSInteger flag;       //是否领奖
@property(nonatomic,strong)NSString * icon;
@property(nonatomic)NSInteger id;
@property(nonatomic)NSInteger isOK;       //是否完成
@property(nonatomic)NSInteger mealType;
@property(nonatomic,strong)NSString * picAddr;
@property(nonatomic)NSInteger schemeId;
@property(nonatomic)NSInteger scoreId;
@property(nonatomic,strong)NSString *startTime;
@property(nonatomic)NSInteger userId;
@property(nonatomic,strong)NSArray<GetFoodsByMealCookData> * cookBookList;
@end



@interface GetFoodsByDayData : TK_BaseJsonModel

@property(nonatomic,strong)NSString * icon;
@property(nonatomic,strong)NSString * name;
@property(nonatomic)NSInteger score;
@property(nonatomic)NSInteger subSchemeId;
@property(nonatomic)NSInteger isOK;
@property(nonatomic,strong)NSArray<GetFoodsByMealData> * mealList;

@end


@interface GetFoodsByDayAck : HF_BaseAck
@property(nonatomic,strong)GetFoodsByDayData * data;
@end
