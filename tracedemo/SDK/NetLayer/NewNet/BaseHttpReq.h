//
//  BaseHttpReq.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/21.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONAPI.h"
#import "JSONModel.h"


@interface BaseHttpReq : JSONModel

@property(nonatomic,strong)NSString * deviceid;
@property(nonatomic, copy)NSString * behaviorInfo;
@property(nonatomic, copy)NSString * moduleCode;
@property(nonatomic,strong)NSString <Ignore> *showToastStr;
@property(nonatomic,strong)NSString <Ignore> *showLoadingStr;
@property(nonatomic,strong)NSString <Ignore> *responseClassName;

- (BOOL)showToast;

- (BOOL)showLoading;

- (NSString *)reqMothod;

- (NSString *)reqUrl;

- (CGFloat)reqTimeOut;

@end
