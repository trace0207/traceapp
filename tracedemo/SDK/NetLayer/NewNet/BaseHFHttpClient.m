//
//  BaseHFHttpClient.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/22.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHFHttpClient.h"

#import "NSString+HFStrUtil.h"



@implementation BaseHFHttpClient
@synthesize bNetReachable;
@synthesize netState = _netState;
SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(BaseHFHttpClient, shareInstance);
//统一请求格式
- (instancetype)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",kBaseURL]]];
    if (self)
    {
        
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        //由于AFNetwork异步执行，所以采用同步执行的Reachability
        Reachability * reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        if ([reachability currentReachabilityStatus] == NotReachable)
        {
            bNetReachable = NO;
        }
        else
        {
            bNetReachable = YES;
        }
        
        
        WS(weakSelf);
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            _netState = status;
            if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
                [weakSelf setBNetReachable:YES];
            }else{
                [weakSelf setBNetReachable:NO];
            }
        }];
        
        [self.reachabilityManager startMonitoring];
    }
    return self;
}

- (void)beginHttpRequest:(BaseHttpReq *)req
                   parse:(NSString *)parseClass
              completion:(completionRequestBlock)block
{
    if (!bNetReachable)
    {
        [HFNetProcessHelper netErrorProcessCenter:_T(@"HF_Common_CheckNet")
                                        showToast:[req showToast]
                                       compeltion:block];
        return;
    }
    
    NSString *url = [[NSURL URLWithString:[req reqUrl] relativeToURL:self.baseURL] absoluteString];
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:[req reqMothod] URLString:url parameters:[req toDictionary] error:nil];
    request.timeoutInterval = [req reqTimeOut];
    
    DDLogDebug(@"\nRequest : 【%@】 \nParams:%@",url,[req toDictionary]);
    
    NSString * className = parseClass;
    if (className == nil || [className isEqualToString:@""])
    {
        className = @"ResponseData";
    }
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DDLogDebug(@"\nAck : 【%@】 \nParams:%@",url,responseObject);
        
        [HFNetProcessHelper processResponseObject:responseObject
                                        showToast:[req showToast]
                                        parseName:className
                                       compeltion:block];
        
    }  failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        DDLogDebug(@"\nAck : 【%@】 error code = %@",url,error);
        
        [HFNetProcessHelper netErrorProcessCenter:_T(@"HF_Common_CheckNet")
                                        showToast:[req showToast]
                                       compeltion:block];
        
    }];
    [self.operationQueue addOperation:operation];
}

- (void)upLoadImage:(UIImage *)image
        httpRequest:(BaseHttpReq *)req
              parse:(NSString *)parseClass
         completion:(completionRequestBlock)block
{
    if (!bNetReachable)
    {
        [HFNetProcessHelper netErrorProcessCenter:_T(@"HF_Common_CheckNet")
                                        showToast:[req showToast]
                                       compeltion:block];
        return;
    }
    
    NSString *requestMethod = [req reqMothod];
    if (image) {
        NSString *strName = @"img";//kPicfile
        NSData   *data = nil;
        NSString *strMimeType = @"image/jpeg";
        data = UIImageJPEGRepresentation(image, 0.5);
        NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:requestMethod URLString:[[NSURL URLWithString:[req reqUrl] relativeToURL:self.baseURL] absoluteString] parameters:[req toDictionary] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:data name:strName fileName:[NSString stringWithFormat:@"%@.jpg", strName] mimeType:strMimeType];
        } error:nil];
        request.timeoutInterval = [req reqTimeOut];
        
        NSString * className = parseClass;
        if (className == nil || [className isEqualToString:@""])
        {
            className = @"ResponseData";
        }
        
        AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [HFNetProcessHelper processResponseObject:responseObject
                                            showToast:[req showToast]
                                            parseName:className
                                           compeltion:block];
            
        }  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [HFNetProcessHelper netErrorProcessCenter:_T(@"HF_Common_CheckNet")
                                            showToast:[req showToast]
                                           compeltion:block];
        }];
        [self.operationQueue addOperation:operation];
    }
}




/**
 上传图片
 **/
-(void)uploadImageFile:(UIImage *)image toActionRelativePath:(NSString * )relativePath responseBlock:(responseBlock)block{

    
}


///**
// 上传文件
// **/
//-(void)uploadFile:(HttpFileReq *)req responseBlock:(responseBlock)block{
//    NSString *url = [[NSURL URLWithString:req.relativeUrl relativeToURL:self.baseURL] absoluteString];
//    DDLogDebug(@"\nRequest : 【%@】 \nParams:%@",url,[req toDictionary]);
//    ResponseData *resp;
//    Class respClass = NSClassFromString(req.responseClassName);
//    if (!bNetReachable)//  网络优先判断
//    {
//        resp = [[ResponseData alloc]initWithError:HFNetDisable];
//    }
//    // 其实 判断 请求参数 ， class是否合法
//    else {
//        
//        if(![respClass isSubclassOfClass:ResponseData.class]){
//            resp = [[ResponseData alloc]initWithError:HFRequestParamError];
//        }
//    }
//    
//    if(resp){
//        
//        if([req showToast]){
//            //  按需 弹出提示窗
//            [[HFHUDView shareInstance] ShowTips:resp.msg delayTime:1.0 atView:NULL];
//        }
//        block(resp);
//        return;
//    }
//    // 发送请求
//    
//    // 按需显示 loading
//    MBProgressHUD *hud;
//    if([req showLoading]){
//        
//        hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
//    }
//    
//    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST"
//                                                                                URLString:[[NSURL URLWithString:req.relativeUrl relativeToURL:self.baseURL] absoluteString]
//                                                                               parameters:[req toDictionary]
//                                                                constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
//    {
//        [formData appendPartWithFileData:req.fileData name:req.name fileName:req.fileName mimeType:req.mimeType];
//    } error:nil];
//
//    request.timeoutInterval = [req reqTimeOut];
//    
//    
//
//
//    
//    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DDLogDebug(@"\nAck : 【%@】 \nParams:%@",url,responseObject);
//        
//        ResponseData * respData = [HFNetProcessHelper parserResponseData:respClass fromDictionary:responseObject];
//        
//        if(hud){
//            [hud hide:YES];
//        }
//        block(respData);
//        
//    }  failure:^(AFHTTPRequestOperation *operation, NSError *error){
//        
//        DDLogDebug(@"\nAck : 【%@】 error code = %@",url,error);
//        ResponseData * respData = [[ResponseData alloc]initWithError:HFNetDisable];
//        if([req showToast]){
//            [[HFHUDView shareInstance] ShowTips:respData.msg delayTime:1.0 atView:NULL];
//        }
//        if(hud){
//            [hud hide:YES];
//        }
//        block(respData);
//    }];
//    
//    [self.operationQueue addOperation:operation];
//    
//
//}
//
///**
// 下载文件
// */
//-(void)downLoadFile:(HttpFileReq *)req responseBlock:(responseBlock)block{
//
//}


/**
 发送Request请求
 **/
-(void)sendRequest:(BaseHttpReq *)req
//     respClassName:(Class)className
     responseBlock:(responseBlock)respBlock{
    [self send:req mothod:@"GET" responseBlock:respBlock];
}

/**
 发送Post请求
 **/
-(void)sendPost:(BaseHttpReq *)req
  responseBlock:(responseBlock)respBlock{
    [self send:req mothod:@"POST" responseBlock:respBlock];
}


/**
 发送HTTP请求
 **/
-(void)send:(BaseHttpReq *)req
//  respClassName:(Class)respClass
     mothod:(NSString*)sendMod
    responseBlock:(responseBlock)respBlock{
    NSString *url = [[NSURL URLWithString:[req reqUrl] relativeToURL:self.baseURL] absoluteString];
    DDLogDebug(@"\nRequest : 【%@】 \nParams:%@",url,[req toDictionary]);
    
    ResponseData *resp;
    Class respClass = NSClassFromString(req.responseClassName);
    if (!bNetReachable)//  网络优先判断
    {
        resp = [[ResponseData alloc]initWithError:HFNetDisable];
    }
    // 其实 判断 请求参数 ， class是否合法
    else {
        
        if(![respClass isSubclassOfClass:ResponseData.class]){
            resp = [[ResponseData alloc]initWithError:HFRequestParamError];
        }
    }
    
    if(resp){
        
        if([req showToast]){
            //  按需 弹出提示窗
            [[HFHUDView shareInstance] ShowTips:resp.msg delayTime:1.0 atView:NULL];
        }
        respBlock(resp);
        return;
    }
    // 发送请求
    
    // 按需显示 loading
    MBProgressHUD *hud;
    if([req showLoading]){
        
      hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    }
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:sendMod URLString:url parameters:[req toDictionary] error:nil];
    request.timeoutInterval = [req reqTimeOut];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DDLogDebug(@"\nAck : 【%@】 \nParams:%@",url,responseObject);
        
        ResponseData * respData = [HFNetProcessHelper parserResponseData:respClass fromDictionary:responseObject];
        
        if(hud){
            [hud hide:YES];
        }
        respBlock(respData);
        
    }  failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        DDLogDebug(@"\nAck : 【%@】 error code = %@",url,error);
        ResponseData * respData = [[ResponseData alloc]initWithError:HFNetDisable];
        if([req showToast]){
            [[HFHUDView shareInstance] ShowTips:respData.msg delayTime:1.0 atView:NULL];
        }
        if(hud){
            [hud hide:YES];
        }
        respBlock(respData);
    }];
    
    [self.operationQueue addOperation:operation];
}

- (NetworkStatus)networkStatus
{
    Reachability * reachability = [Reachability reachabilityWithHostName:@"http://www.baidu.com/"];
    return [reachability currentReachabilityStatus];
}

@end
