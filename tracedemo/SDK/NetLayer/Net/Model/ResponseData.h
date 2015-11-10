//
//  ResponseData.h
//  GuanHealth
//
//  Created by hermit on 15/2/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "JSONModel.h"
#import "GlobEnum.h"

@interface ResponseData : JSONModel

@property (nonatomic, assign)   NSInteger        recode;     //返回码
@property (nonatomic,   copy)   NSString         *msg;       //返回消息
@property (nonatomic,assign) BOOL requestSuccess;

- (BOOL)success;

- (void)parseJSON:(id)dicJson;

- (void)transfrom;

/**
 初始化默认的
 **/
-(id)initWithError:(HFRequestError)errorCode;

@end
