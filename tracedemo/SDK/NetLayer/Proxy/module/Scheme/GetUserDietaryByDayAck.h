//
//  GetUserDietaryByDayAck.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

@class HF_BaseAck;

@protocol GetUserDietaryMealCookListByDayData <NSObject>

@end

@interface GetUserDietaryMealCookListByDayData : TK_BaseJsonModel
@property(nonatomic)NSInteger calorieId;
@property(nonatomic,strong)NSString * calorieName;
@property(nonatomic,strong)NSString * calorieTips;
@property(nonatomic)NSString * picAddr;
@property(nonatomic)NSInteger id;
@property(nonatomic)NSInteger days;
@property(nonatomic)NSInteger mealType;
@property(nonatomic)NSInteger schemeId;
@end


@protocol GetUserDietaryMealByDayData <NSObject>
@end

@interface GetUserDietaryMealByDayData: TK_BaseJsonModel

@property(nonatomic,strong)NSString * content;
@property(nonatomic,strong)NSString * createDate;
//@property(nonatomic)NSInteger createTime;
@property(nonatomic,strong)NSString * endTime;
@property(nonatomic)NSInteger flag;
@property(nonatomic,strong)NSString * icon;
@property(nonatomic)NSInteger id;
@property(nonatomic)NSInteger isOK;
@property(nonatomic)NSInteger mealType;
@property(nonatomic,strong)NSString * picAddr;
@property(nonatomic)NSInteger schemeId;
@property(nonatomic)NSInteger scoreId;
@property(nonatomic,strong)NSString *startTime;
@property(nonatomic)NSInteger userId;
@property(nonatomic,strong)NSArray<GetUserDietaryMealCookListByDayData> * cookBookList;

@end




@interface GetUserDietaryByDayData : TK_BaseJsonModel

@property(nonatomic,strong)NSString * icon;
@property(nonatomic,strong)NSString * name;
@property(nonatomic)NSInteger score;
@property(nonatomic)NSInteger isOK;
@property(nonatomic)NSInteger subSchemeId;
@property(nonatomic)NSArray<GetUserDietaryMealByDayData> * mealList;


@end


@interface GetUserDietaryByDayAck : HF_BaseAck

@property(nonatomic,strong)GetUserDietaryByDayData * data;

@end
