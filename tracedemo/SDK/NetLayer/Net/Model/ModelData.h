//
//  ModelData.h
//  GuanHealth
//
//  Created by hermit on 15/4/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "HiModuleListData.h"

@protocol ModelData
@end

@interface ModelData : ResponseData

@property (nonatomic, assign) int       modelId;
@property (nonatomic,   copy) NSString  *modelName;
@property (nonatomic,   copy) NSString  *note;
@property (nonatomic,   copy) NSString  *picAddr;

- (void)copyFrom:(HiModuleListData*)data;

@end
