//
//  BaseHTTPClient.m
//  GuanHealth
//
//  Created by hermit on 15/2/26.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHTTPClient.h"
#import "BaseHttpReq.h"
@implementation BaseHTTPClient

- (void)httpAction:(E_HTTPMethod)method
              path:(NSString *)path
        parameters:(NSDictionary *)parameters
    appendOpetaion:(void (^)(AFHTTPRequestOperation *operation)) appendOpetaion
        parseBlock:(ParseBlock)block
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self httpAction:method path:path parameters:parameters fileParameters:nil appendOpetaion:appendOpetaion parseBlock:block success:success failure:failure];
}

- (void)httpAction:(E_HTTPMethod)method
              path:(NSString *)path
        parameters:(NSDictionary *)parameters
    fileParameters:(UIImage *)fileParameters
    appendOpetaion:(void (^)(AFHTTPRequestOperation *operation)) appendOpetaion
        parseBlock:(ParseBlock)block
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString *requestMethod = [self getRequestMethod:method];
    
    DDLogDebug(@"\nRequest : %@%@ \nParams:%@",self.baseURL, path,parameters);
    
    if (fileParameters) {
        //NSString *strKey = [[fileParameters allKeys] lastObject];
        NSString *strName = @"img";//kPicfile
        NSData   *data = nil;
        NSString *strMimeType = @"image/jpeg";
        data = UIImageJPEGRepresentation(fileParameters, 0.5f);
        NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:requestMethod URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:data name:strName fileName:[NSString stringWithFormat:@"%@.jpg", strName] mimeType:strMimeType];
        } error:nil];
        request.timeoutInterval = 30.0;
        AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
        if (operation) {
            appendOpetaion(operation);
        }
        [self.operationQueue addOperation:operation];
    }else{
        NSString *url = [[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString];
        NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:requestMethod URLString:url parameters:parameters error:nil];
        request.timeoutInterval = 30.0;
        AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
        if (operation) {
            appendOpetaion(operation);
        }
        [self.operationQueue addOperation:operation];
    }
}

- (NSString*)getRequestMethod:(E_HTTPMethod)method
{
    switch (method) {
        case E_DELETE:
            return @"DELETE";
            break;
        case E_HEAD:
            return @"HEAD";
            break;
        case E_GET:
            return @"GET";
            break;
        case E_PUT:
            return @"PUT";
            break;
        case E_POST:
            return @"POST";
            break;
        case E_PATCH:
            return @"PATCH";
            break;
        default:
            return @"POST";
            break;
    }
}


@end
