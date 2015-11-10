//
//  HF_HttpClient.m
//  GuanHealth
//
//  Created by cmcc on 15/8/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HF_HttpClient.h"
#import "ActionTools.h"
#import "BaseHFHttpClient.h"
#import "HFHUDView.h"
#import "UIKitTool.h"

@implementation HF_HttpClient

SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(HF_HttpClient, httpClient);


-(void)sendRequestForHiifit:(HF_BaseArg *)arg withBolck:(hfAckBlock)block{
    
    // 检查网络
    if(![[BaseHFHttpClient shareInstance]bNetReachable])
    {
    
        HF_BaseAck * errorAck = [self createErrorAckData:arg withAck:nil];
        
        if([arg.showToastStr isEqualToString:@"YES"]){
        
            [[HFHUDView shareInstance] ShowTips:errorAck.msg delayTime:1.0 atView:NULL];
        }
        
        block(errorAck);
        return ;
    }
    
    
    arg.relativeUrl = [ActionTools getRelativePathByArgClass:[arg class]];
    
    
    
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
            HF_BaseAck * errorAck = [self createErrorAckData:arg withAck:nil];
            
            if([arg.showToastStr isEqualToString:@"YES"]){
                
                [[HFHUDView shareInstance] ShowTips:errorAck.msg delayTime:1.0 atView:NULL];
            }
            
            block(errorAck);
            
            return ;
            
        }
        
        if([ack isKindOfClass:[HF_BaseAck class]]){
            
            //  处理服务器返回的错误， arg 需要处理才处理
            
            if([arg.showToastStr isEqualToString:@"YES"]){
                
                HF_BaseAck * hfAck = (HF_BaseAck *)ack;
            
                if(hfAck.recode != 1){
                
//                    if(hud){
//                    
//                        [hud hide:YES];
//                    }
                    
                    [[HFHUDView shareInstance] ShowTips:hfAck.msg delayTime:1.0 atView:NULL];
                    
                }
            }
            
            
            block((HF_BaseAck *)ack);
        }else{
        
            HF_BaseAck * errorAck = [self createErrorAckData:arg withAck:nil];
            
            if([arg.showToastStr isEqualToString:@"YES"]){
                
                [[HFHUDView shareInstance] ShowTips:errorAck.msg delayTime:1.0 atView:NULL];
            }
            
            block(errorAck);
        }
        
        
    }];
    
}


/*
  反回异常的Ack 数据
 */
-(HF_BaseAck *)createErrorAckData:(HF_BaseArg *)arg withAck: (TK_JsonModelAck *)ack{
    
    NSString * className = arg.ackClassName;
    
    Class ackClass = NSClassFromString(className);
    
    HF_BaseAck * realAck = [[ackClass alloc] init];
    
    if(!ack || ack.error){
        
        // 可以根据 类型来区分是什么异常
        
        //        if(ack.error.code == TK_CLASS_ERROR){
        //
        //
        //        }
        
        realAck.recode =  HFNetDisable;// = - 10085, // 网络不可用
        realAck.msg = _T(@"HF_Common_CheckNet");
    }
     return realAck;
}



@end
