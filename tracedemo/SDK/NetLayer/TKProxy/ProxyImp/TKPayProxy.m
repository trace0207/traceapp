//
//  TKPayProxy.m
//  tracedemo
//
//  Created by cmcc on 16/3/14.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKPayProxy.h"
#import "TK_PayAck.h"
#import "TKPayChooseView.h"
#import "TKAlertView.h"


static TKAlertView * loadingView;

@implementation TKPayProxy



+(TKAlertView *)getLoadingView:(NSString *)msg
{
    if(loadingView == nil)
    {
        loadingView = [TKAlertView showHUDWithText:msg];
    }else
    {
        loadingView.textLabel.text = msg;
    }
    return loadingView;
}

+(void)dimissLoadingPay
{
    if(loadingView != nil)
    {
        [loadingView removeFromSuperview];
    }
}



-(instancetype)init
{
    [Pingpp setDebugMode:YES];
    self = [super init];
    
    return self;
}



+(void)aliPay:(NSObject *)charge
    urlScheme:(NSString *)scheme
withCompletion:(PingppCompletion)completionBlock

{
    [Pingpp createPayment:charge
             appURLScheme:scheme
           withCompletion:completionBlock];
}



/**
 预支付
 **/
+(void)prePay:(TK_PayArg *)arg withBlick:(payAckBlock)block
{
    
    arg.clientIp = [[HFDeviceInfo shareInstance] getIPAddress:YES];
    
    [TKPayProxy getLoadingView:@"正在支付..."];
    
    [[TKProxy proxy].mainProxy tkPay:arg withBolco:^(HF_BaseAck *ack) {
        [TKPayProxy dimissLoadingPay];
        if(ack.sucess)
        {
            
            if (arg.bigMoney !=0) {
            
                // 大牌币支付
                
                block(PaySuccess);
                
            }else
            {
                [TKPayProxy aliPay: ((TK_PayAck*)ack).data.charge urlScheme:@"QupaiConsumer" withCompletion:^(NSString *result, PingppError *error) {
                    DDLogInfo(@"pay back %@",result);
                    if([@"success" isEqualToString:result])
                    {
                        block(PaySuccess);
                    }
                    else if([@"cancel" isEqualToString:result])
                    {
                        block(PayCancel);//取消
                    }
                    else block(PayFailed); // 失败
                    
                }];

            }
        }
        else
        {
            block(PrePayFailed);
        }
    } ];}



+(void)selectPayWay:(NSString *)money rewardId:(NSString *)rewardId fundType:(NSInteger)type withBlock:(payAckBlock)block
{
    
    NSInteger payType = PayTypeAlipay;
    if(type == 1)//  尾款
    {
        payType = PayTypeAlipay|PayQUPAI;
    }
    [[[TKPayChooseView alloc] initWithPayType:payType]show:@"预付款将打入趣平台，不会直接打给买手" money:money withBlock:^(NSInteger payTpye)
    {
     
        //先预支付 如果是大牌币 就直接支付了。
        
        TK_PayArg * arg = [[TK_PayArg alloc] init];
        arg.postrewardId = rewardId;
        arg.fundType = type;
        if(payTpye == PayTypeAlipay)//支付宝支付
        {
            arg.payType = 0;// 0 阿里支付
            arg.payAmount = money;
            arg.bigMoney = 0;
           
        }else if(payTpye == PayQUPAI)
        {
            arg.payType = 0;// 0 阿里支付
            arg.bigMoney = money.integerValue;
            arg.payAmount = money;
            // 大牌币支付不足
//             block(PayBigMoneyNotEnough);
//            return;
        }
        
        [TKPayProxy prePay:arg withBlick:block];
        
    }];
}


@end
