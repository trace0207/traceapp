//
//  TK_JsonArg.h
//  GuanHealth
//
//  Created by cmcc on 15/8/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TK_BaseJsonModel.h"

@interface TK_JsonModelArg : TK_BaseJsonModel


@property(nonatomic,strong)NSString <Ignore> *baseUrl;
@property(nonatomic,strong)NSString <Ignore> *relativeUrl;
@property(nonatomic,strong)NSString <Ignore> *ackClassName;
@property(nonatomic,strong)NSString <Ignore> *method;
@property(nonatomic) CGFloat timeout;

@end
