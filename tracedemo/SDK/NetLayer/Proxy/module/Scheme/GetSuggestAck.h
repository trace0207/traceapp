//
//  GetSuggestAck.h
//  GuanHealth
//
//  Created by luotianjia on 15/8/10.
//  Copyright (c) 2015年 cmcc. All rights reserved.
//

@class HF_BaseAck;

@interface GetSuggestData : TK_BaseJsonModel

@property (nonatomic, copy) NSString * icon;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * picAddr;
@property (nonatomic, copy) NSString * detailSteps;
@property (nonatomic, copy) NSString * urlAddr;
@property (nonatomic, copy) NSString * videoAddr;
@property (nonatomic, copy) NSString * introduce;
@property (nonatomic, copy) NSString * usages;
@property (nonatomic, copy) NSString * format;

@property (nonatomic, assign) NSUInteger duration;
@property (nonatomic, assign) NSUInteger size;
@property (nonatomic, assign) NSUInteger type;
@property (nonatomic, assign) NSUInteger sportId;
@end

@protocol GetSuggestData <NSObject>

@end


@interface GetSuggestAck : HF_BaseAck

@property (nonatomic,copy) NSMutableArray<GetSuggestData> * data;

@end
