//
//  GetQuizSubjectArg.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/9/21.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HF_BaseArg.h"

@interface GetQuizSubjectArg : HF_BaseArg

@property (nonatomic, copy) NSString * qids;
@property (nonatomic, assign) NSInteger schemeId;
@property (nonatomic, assign) NSInteger currentQueAns;
@property (nonatomic, assign) NSInteger isLast;

@end
