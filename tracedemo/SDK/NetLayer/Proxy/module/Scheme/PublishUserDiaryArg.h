//
//  PublishUserDiaryArg.h
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HF_BaseArg.h"

@interface PublishUserDiaryArg : HF_BaseArg
@property (nonatomic,assign) NSInteger schemeId;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * picAddr;
@property (nonatomic,assign) NSInteger day;
@end
