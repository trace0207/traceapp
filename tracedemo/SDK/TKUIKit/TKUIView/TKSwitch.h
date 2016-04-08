//
//  TKSwitch.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/4/7.
//  Copyright © 2016年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKSwitch : UIControl

@property (nonatomic, strong) UIColor *onTextColor;
@property (nonatomic, strong) UIColor *offTextColor;
@property (nonatomic, strong) UIColor *onTintColor;
@property (nonatomic, strong) UIColor *offTintColor;
@property (nonatomic, strong) UIImage *thumbImage;

@property (nonatomic, assign) CGFloat ballSize;

@property (nonatomic, strong) UIFont *textFont;

@property (nonatomic, strong) NSString *onText;
@property (nonatomic, strong) NSString *offText;

@property (nonatomic, assign, getter = isOn) BOOL on;
- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end