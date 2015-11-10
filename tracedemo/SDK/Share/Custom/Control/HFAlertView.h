//
//
//  GuanHealth
//
//  Created by hermit on 15/3/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFAlertView : UIView

+ (instancetype)initWithTitle:(NSString *)title withMessage:(NSString *)message commpleteBlock:(void(^)(NSInteger buttonIndex))block cancelTitle:(NSString *)cancelTitle determineTitle:(NSString *)determineTitle;

- (void)show;

@end
