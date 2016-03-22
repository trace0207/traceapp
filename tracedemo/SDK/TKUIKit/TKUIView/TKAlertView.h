//
//  TKAltertView.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/21.
//  Copyright © 2016年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKAlertView : UIView

//一般场景，message支持NSString和NSAttributedString
+ (instancetype)showAltertWithTitle:(NSString *)title withMessage:(id)message commpleteBlock:(void(^)(NSInteger buttonIndex))block cancelTitle:(NSString *)cancelTitle determineTitle:(NSString *)determineTitle;

//带有成功标识图片的弹窗
+ (void)showSuccessWithTitle:(NSString *)title withMessage:(id)message commpleteBlock:(void(^)(NSInteger buttonIndex))block cancelTitle:(NSString *)cancelTitle determineTitle:(NSString *)determineTitle;

//带有失败标识图片的弹窗
+ (void)showFailedWithTitle:(NSString *)title withMessage:(id)message commpleteBlock:(void(^)(NSInteger buttonIndex))block cancelTitle:(NSString *)cancelTitle determineTitle:(NSString *)determineTitle;

//选择发货时间的弹窗界面
+ (void)showDeliveryTimeWithBlock:(void(^)(NSInteger buttonIndex))block;

//HUD
+ (instancetype)showHUDWithText:(NSString *)text;

@end
