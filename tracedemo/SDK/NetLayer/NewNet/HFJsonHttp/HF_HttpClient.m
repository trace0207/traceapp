//
//  HF_HttpClient.m
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HF_HttpClient.h"
#import "BaseHFHttpClient.h"
#import "HFHUDView.h"
#import "UIKitTool.h"

@implementation HF_HttpClient

SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(HF_HttpClient, httpClient);



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
            _ISNetReachable = NO;
        }
        else
        {
            _ISNetReachable = YES;
        }
        
        
        WS(weakSelf);
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
                [weakSelf setISNetReachable:YES];
            }else{
                [weakSelf setISNetReachable:NO];
            }
        }];
        
        [self.reachabilityManager startMonitoring];
    }
    return self;
}



-(void)sendRequestForHiifit:(HF_BaseArg *)arg withBolck:(hfAckBlock)block{
    
    // 检查网络
    if(![[BaseHFHttpClient shareInstance]bNetReachable])
    {
        HF_BaseAck * errorAck = [[[arg getAckClass] alloc] init];
        errorAck.recode =  TK_NEtWorkError;// = - 10085, // 网络不可用
        errorAck.msg = _T(@"HF_Common_CheckNet");
        if([arg.showToastStr isEqualToString:@"YES"]){
            
            [[HFHUDView shareInstance] ShowTips:errorAck.msg delayTime:1.0 atView:NULL];
        }
        block(errorAck);
        return ;
    }
    
    // 按需显示 loading
    MBProgressHUD *hud;
    if([arg.showLoadingStr isEqualToString:@"YES"]){
        
        hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    }
    
    //  发送请求
    [self sendRequestForJsonModel:arg withAckBlock:^(TK_JsonModelAck * ack){
        
        if(hud){
            
            [hud hide:YES];
        }
        
        if(ack.error){
            
            // 有异常的情况
            HF_BaseAck * hfAck = (HF_BaseAck *)ack;//  请求通过继承关系保证了  ack 一定是  HFAck
            
            if([arg.showToastStr isEqualToString:@"YES"]){
                
                [[HFHUDView shareInstance] ShowTips:hfAck.msg delayTime:1.0 atView:NULL];
            }
            
            block(hfAck);
        }
        else
        {
            
            //  请求成功， 预处理服务器返回的错误信息， arg 需要处理才处理
            
            if([arg.showToastStr isEqualToString:@"YES"]){
                
                HF_BaseAck * hfAck = (HF_BaseAck *)ack;
                
                if(!hfAck.sucess){
                    [[HFHUDView shareInstance] ShowTips:hfAck.msg delayTime:1.0 atView:NULL];
                }
            }
            block((HF_BaseAck *)ack);
        }

    }];
    
}



-(void)sendMUtableArgsForHiffit:(NSArray<__kindof HF_BaseArg *> *)args
                    showLoading:(BOOL) loading
                     toastError:(BOOL) toastError
                      withBlock:(hfMutableAckBlock) block
{
    // 检查网络
    if(![[BaseHFHttpClient shareInstance]bNetReachable])
    {
        if(toastError){
            
            [[HFHUDView shareInstance] ShowTips:_T(@"HF_Common_CheckNet") delayTime:1.0 atView:NULL];
        }
        block(nil);
        return ;
    }

    // 按需显示 loading
    MBProgressHUD *hud;
    if(loading){
        
        hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    }
    
    [self sendMutableArg:args withBlock:^(NSArray<__kindof TK_JsonModelAck *> *ack) {
        
        if(hud){
            
            [hud hide:YES];
        }
        block(ack);
    }];
}




@end
