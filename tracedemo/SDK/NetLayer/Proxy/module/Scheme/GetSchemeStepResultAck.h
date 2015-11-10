//
//  GetSchemeStepResultAck.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HF_BaseAck.h"

@protocol GetSchemeStepResultListData <NSObject>

@end
@interface GetSchemeStepResultListData : TK_BaseJsonModel

@property (nonatomic, assign) NSUInteger completeDays;
@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, assign) NSUInteger schemeId;
@property (nonatomic, assign) NSUInteger stageId;
@property (nonatomic, assign) NSUInteger subType;
@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, assign) NSUInteger userSchemeId;
@property (nonatomic, copy) NSString * subSetName;

@end

@interface GetSchemeStepResultData : TK_BaseJsonModel

@property (nonatomic, assign) NSUInteger schemeId;
@property (nonatomic, assign) NSUInteger stageId;
@property (nonatomic, copy) NSString * stageSuggest;
@property (nonatomic, copy) NSString * stageTarget;
@property (nonatomic, assign) NSUInteger startDay;
@property (nonatomic, strong) NSMutableArray<GetSchemeStepResultListData> * list;

@end

@interface GetSchemeStepResultAck : HF_BaseAck

@property (nonatomic, strong) GetSchemeStepResultData * data;

@end
