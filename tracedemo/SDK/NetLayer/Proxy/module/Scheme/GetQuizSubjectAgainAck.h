//
//  GetQuizSubjectAgainAck.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/9/27.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

@class HF_BaseAck;

@protocol GetQuizSubjectAgainData <NSObject>

@end

@interface GetQuizSubjectAgainData : TK_BaseJsonModel

@property (nonatomic, assign) NSInteger questionId;
@property (nonatomic, copy) NSString * content;

@end
@interface GetQuizSubjectAgainAck : HF_BaseAck

@property (nonatomic, strong) GetQuizSubjectAgainData * data;

@end
