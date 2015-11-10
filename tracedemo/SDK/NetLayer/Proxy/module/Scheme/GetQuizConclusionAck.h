//
//  GetQuizConclusionAck.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/9/21.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HF_BaseAck.h"

@interface GetQuizConclusionData : TK_BaseJsonModel

@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) NSInteger hasAchieved;
@property (nonatomic, assign) NSInteger conclusionId;

@end

@interface GetQuizConclusionAck : HF_BaseAck

@property (nonatomic, strong) GetQuizConclusionData * data;

@end
