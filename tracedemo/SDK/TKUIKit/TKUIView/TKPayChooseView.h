//
//  TKPayChooseView.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/24.
//  Copyright © 2016年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^payChooseBlock)(NSInteger result);

typedef NS_OPTIONS(NSUInteger,PayType){
    PayTypeApple    = 1,//苹果支付
    PayTypeUnion    = 1<<1,//银联支付
    PayTypeWeChat   = 1<<2 ,//微信支付
    PayTypeAlipay   = 1<<3,//支付宝支付
    PayQUPAI        = 1<<4,//大牌币
    PayTypeAll      = PayTypeApple|PayTypeUnion|PayTypeWeChat|PayTypeAlipay|PayQUPAI//默认支持以上全部支付方式
    
};

@protocol TKPayChooseViewDelegate <NSObject>
//协议根据需求待写
@end

@interface TKPayChooseView : UIView
@property (nonatomic,copy) NSString * money;//支付金额数
@property (nonatomic,strong) payChooseBlock block;
- (instancetype)initWithPayType:(PayType)payType;

- (void)show:(NSString *)msg money:(NSString *)money withBlock:(payChooseBlock)block;
@end
