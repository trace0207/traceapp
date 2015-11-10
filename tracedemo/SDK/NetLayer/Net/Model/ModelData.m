//
//  ModelData.m
//  GuanHealth
//
//  Created by hermit on 15/4/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ModelData.h"

@implementation ModelData

- (void)copyFrom:(HiModuleListData*)data
{
    self.modelId = data.id;
    self.modelName = data.modelName;
    self.note = data.note;
    self.picAddr = data.picAddr;
}

@end
