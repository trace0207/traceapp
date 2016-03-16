//
//
//  GuanHealth
//
//  Created by hermit on 15/3/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFAlertView : UIView

//废弃了
+ (instancetype)initWithTitle:(NSString *)title withMessage:(NSString *)message commpleteBlock:(void(^)(NSInteger buttonIndex))block cancelTitle:(NSString *)cancelTitle determineTitle:(NSString *)determineTitle;

//使用这个，直接用类名调用，不用调用show函数，弹出动作已经在内部调用了。
+ (instancetype)showAltertWithTitle:(NSString *)title withMessage:(id)message commpleteBlock:(void(^)(NSInteger buttonIndex))block cancelTitle:(NSString *)cancelTitle determineTitle:(NSString *)determineTitle;

- (void)show;

@end
