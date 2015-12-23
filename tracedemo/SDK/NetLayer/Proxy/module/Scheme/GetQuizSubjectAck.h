//
//  GetQuizSubjectAck.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/9/21.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

@class HF_BaseAck;

@protocol GetQuizSubjectData <NSObject>

@end

@interface GetQuizSubjectData : TK_BaseJsonModel

@property (nonatomic, copy) NSString * content;
@property (nonatomic, assign) NSInteger questionId;

@end

@interface GetQuizSubjectAck : HF_BaseAck

@property (nonatomic, strong) GetQuizSubjectData * data;

@end
