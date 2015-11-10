//
//  HFRetModel.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HFRetModel;

typedef void(^completionRequestBlock)(HFRetModel * ret);

typedef void(^responseBlock)(ResponseData * responseData);

@interface HFRetModel : NSObject

@property(nonatomic)NSInteger  code;
@property(nonatomic,   copy)NSString * error;
@property(nonatomic, strong)ResponseData * data;
@property(nonatomic)BOOL       bSuccess;
@end


@interface HFNetProcessHelper : NSObject

+ (void)processResponseObject:(id)response
                    showToast:(BOOL)bShow
                    parseName:(NSString *)name
                   compeltion:(completionRequestBlock)block;

+ (void)netErrorProcessCenter:(NSString *)error
                    showToast:(BOOL)bShow
                   compeltion:(completionRequestBlock)block;

/**
 将 json解析成 class对象
 **/
+(ResponseData *)parserResponseData:(Class)class fromDictionary:(id)response;

@end
