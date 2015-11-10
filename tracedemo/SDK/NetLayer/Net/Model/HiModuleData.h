//
//  HiModuleData.h
//  GuanHealth
//
//  Created by hermit on 15/4/21.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "HiModuleListData.h"

@protocol HiModuleData

@end

@interface HiModuleData : ResponseData

@property (nonatomic, assign) int      classify;
@property (nonatomic,   copy) NSString *classifyName;

@property (nonatomic, strong) NSArray<HiModuleListData> *modelList;

@end
