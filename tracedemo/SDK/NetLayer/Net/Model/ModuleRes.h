//
//  ModuleRes.h
//  GuanHealth
//
//  Created by hermit on 15/4/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "ModelData.h"

@interface ModuleRes : ResponseData

@property (nonatomic, strong) NSArray<ModelData>    *data;

@end
