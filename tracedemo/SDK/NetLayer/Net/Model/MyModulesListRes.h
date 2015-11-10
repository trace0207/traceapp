//
//  MyModulesListRes.h
//  GuanHealth
//
//  Created by hermit on 15/4/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "MyModulesListData.h"
@interface MyModulesListRes : ResponseData

@property (nonatomic, strong)   NSArray<MyModulesListData>  *data;

@end
