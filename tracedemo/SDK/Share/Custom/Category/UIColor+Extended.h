//
//  UIColor+Extended.h
//  frame
//
//  Created by duonuo on 14-6-20.
//  Copyright (c) 2014年 duonuo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIColor (extended)
+ (UIColor *)hexChangeFloat:(NSString *)hexColor;

+ (UIColor *)hexChangeFloat:(NSString *)hexColor withAlpha:(CGFloat)alpha;

+ (UIColor *)HFColorStyle_1;

+ (UIColor *)HFColorStyle_2;

+ (UIColor *)HFColorStyle_3;

+ (UIColor *)HFColorStyle_4;

+ (UIColor *)HFColorStyle_5;//主颜色

+ (UIColor *)HFColorStyle_6;//背景色

+ (UIColor *)HFColorStyle_7;//分割线

+ (UIColor *)HFColorStyle_8;//手环警告字体

@end

