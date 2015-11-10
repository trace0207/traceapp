//
//  UIColor+Extended.m
//  frame
//
//  Created by duonuo on 14-6-20.
//  Copyright (c) 2014年 duonuo. All rights reserved.
//

#import "UIColor+Extended.h"

@implementation UIColor (extended)

+ (UIColor *)hexChangeFloat:(NSString *)hexColor withAlpha:(CGFloat)alpha
{
    if ([hexColor length]<6) {
        return nil;
    }
    
    unsigned int red_, green_, blue_;
    NSRange exceptionRange;
    exceptionRange.length = 2;
    
    //red
    exceptionRange.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:exceptionRange]]scanHexInt:&red_];
    
    //green
    exceptionRange.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:exceptionRange]]scanHexInt:&green_];
    
    //blue
    exceptionRange.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:exceptionRange]]scanHexInt:&blue_];
    
    UIColor *resultColor = [UIColor colorWithRed:(CGFloat)red_/255. green:(CGFloat)green_/255. blue:(CGFloat)blue_/255. alpha:alpha];
    return resultColor;
}

+ (UIColor *)hexChangeFloat:(NSString *)hexColor
{
    return [self hexChangeFloat:hexColor withAlpha:1];
}

+ (UIColor *)HFColorStyle_1
{
    return [self hexChangeFloat:@"333333"];
}

+ (UIColor *)HFColorStyle_2
{
    return [self hexChangeFloat:@"666666"];
}

+ (UIColor *)HFColorStyle_3
{
    return [self hexChangeFloat:@"999999"];
}

+ (UIColor *)HFColorStyle_4
{
    return [self hexChangeFloat:@"cccccc"];
}

+ (UIColor *)HFColorStyle_5
{
    return [self hexChangeFloat:@"7fbbd3"];
}

+ (UIColor *)HFColorStyle_6
{
    return [self hexChangeFloat:@"ebeded"];
}

+ (UIColor *)HFColorStyle_7
{
    return [self hexChangeFloat:@"cacece"];
}

+ (UIColor *)HFColorStyle_8
{
    return [self hexChangeFloat:@"f48f8f"];
}

@end
