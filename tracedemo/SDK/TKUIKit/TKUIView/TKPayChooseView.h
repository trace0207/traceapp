//
//  TKPayChooseView.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/24.
//  Copyright © 2016年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger,PayType){
    PayTypeApple    = 1,//苹果支付
    PayTypeUnion    = 1<<1,//银联支付
    PayTypeWeChat   = 1<<2 ,//微信支付
    PayTypeAlipay   = 1<<3,//支付宝支付
    PayTypeAll      = PayTypeApple|PayTypeUnion|PayTypeWeChat|PayTypeAlipay//默认支持以上全部支付方式
};

@protocol TKPayChooseViewDelegate <NSObject>
//协议根据需求待写
@end

@interface TKPayChooseView : UIView
@property (nonatomic, assign) CGFloat money;//支付金额数
- (instancetype)initWithPayType:(PayType)payType;

- (void)show;
@end
