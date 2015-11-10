//
//  HiModuleListData.h
//  GuanHealth
//
//  Created by hermit on 15/4/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@protocol HiModuleListData

@end

@interface HiModuleListData : ResponseData

@property (nonatomic, assign) int id;
@property (nonatomic, assign) int subscribeNum;//订阅数
@property (nonatomic, assign) int classify;//模块分类 1了解健康状况 2最合适的才是最好的 3坚持有我 4脑力锻炼
@property (nonatomic, assign) int flag;//1、已订阅 2、未订阅
@property (nonatomic,   copy) NSString *note;
@property (nonatomic,   copy) NSString *modelName;
@property (nonatomic,   copy) NSString *picAddr;//模块图标
@property (nonatomic,   copy) NSString *backgroundAddr;//模块背景图
@property (nonatomic,   copy) NSString  *classifyName;


@end
