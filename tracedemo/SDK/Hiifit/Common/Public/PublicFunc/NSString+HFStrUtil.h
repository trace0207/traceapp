//
//  NSString+HFStrUtil.h
//  GuanHealth
//
//  Created by cmcc on 15/6/5.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HFStrUtil)

+ (NSString *)URLEncodedForString:(NSString *)text;
+ (NSString *)URLDecodedForString:(NSString *)text;


- (NSString *)URLEncodedForString;
- (NSString *)URLDecodedForString;
/**
 判断字符串是否为空
 **/
+(BOOL)isStrEmpty:(NSString *)string;


/**
 数组toString
 **/
+(NSString *)ArrayToNSString :(NSArray *) array withSeparator:(NSString *) separtor;


/**
  int 转换成 string
 **/
+(NSString *)tkStringFromNumber:(NSInteger)value;



/**
 拼接 数字 成 string
 **/
-(NSString *)tkStringByAppendInteger:(NSInteger)number;

@end
