//
//  BaseHTTPClient.h
//  GuanHealth
//
//  Created by hermit on 15/2/26.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "IParser.h"
#import "ResponseData.h"
typedef NS_ENUM(NSInteger, E_HTTPMethod)
{
    E_POST                       = 1,
    E_PUT                        = 2,
    E_GET                        = 3,
    E_DELETE                     = 4,
    E_HEAD                       = 5,
    E_PATCH                      = 6,
};

typedef void(^netCallBackBlock)(ResponseData* responseData);

@interface BaseHTTPClient : AFHTTPRequestOperationManager

- (void)httpAction:(E_HTTPMethod)method
              path:(NSString *)path
        parameters:(NSDictionary *)parameters
    appendOpetaion:(void (^)(AFHTTPRequestOperation *operation)) appendOpetaion
        parseBlock:(ParseBlock)block
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


- (void)httpAction:(E_HTTPMethod)method
              path:(NSString *)path
        parameters:(NSDictionary *)parameters
    fileParameters:(UIImage *)fileParameters
    appendOpetaion:(void (^)(AFHTTPRequestOperation *operation)) appendOpetaion
        parseBlock:(ParseBlock)block
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
