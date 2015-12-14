//
//  UIColor+TK_Color.h
//  tracedemo
//
//  Created by cmcc on 15/9/12.
//  Copyright (c) 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKColorDefine.h"

@interface UIColor (TK_Color)


#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

+ (UIColor *)TKcolorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)TKcolorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)TKcreateImageWithColor:(UIColor *)color;


/*
 主题色
 */
+ (UIColor *)tkMainActiveColor;


/**
 默认的 分割线颜色
 **/
+ (UIColor *)tkDefaultLineColor;


/**
 主题背景色 上面的text颜色
 **/
+(UIColor *)tkMainTextColorForActiveBg;

/**
 默认背景上面的text颜色
 **/
+(UIColor *)tkMainTextColorForDefaultBg;


/**
 主背景色
 **/
+ (UIColor *)tkMainBackgroundColor;

/**
 color转换成 Image
 **/
+ (UIImage*) tkCreateImageWithColor: (UIColor*) color;

@end
