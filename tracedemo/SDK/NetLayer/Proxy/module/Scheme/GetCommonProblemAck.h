//
//  GetCommonProblemAck.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/9/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HF_BaseAck.h"

@interface GetCommonProblemData : TK_BaseJsonModel

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * answer;
@property (nonatomic, assign) NSInteger id;

@end

@protocol GetCommonProblemData <NSObject>

@end
@interface GetCommonProblemAck : HF_BaseAck

@property (nonatomic, strong) GetCommonProblemData * data;

@end
