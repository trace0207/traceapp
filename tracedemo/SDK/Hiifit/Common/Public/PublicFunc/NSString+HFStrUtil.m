//
//  NSString+HFStrUtil.m
//  GuanHealth
//
//  Created by cmcc on 15/6/5.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "NSString+HFStrUtil.h"

@implementation NSString (HFStrUtil)

+ (NSString *)URLEncodedForString:(NSString *)text
{
    return  [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString*)URLDecodedForString:(NSString *)text
{
    NSString * srt = [text stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];
    srt = [srt stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return srt;
}

- (NSString *)URLEncodedForString
{
    //return [NSString stringWithCString:[self UTF8String] encoding:NSUTF8StringEncoding];
    return  [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)URLDecodedForString{
    
    NSString * srt = [self stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];
    srt = [srt stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return srt;
}


+(BOOL)isStrEmpty:(NSString *)string{
 
    if(!string || string.length == 0 || [@"" isEqualToString:string]){
        
        return YES;
    }
    return NO;
}


+(NSString *)ArrayToNSString :(NSArray *) array withSeparator:(NSString *) separtor{


    NSMutableString * str = [[NSMutableString alloc] init];

    for(int i = 0 ;i< array.count;i++){
        id obj = array[i];
        if([obj isKindOfClass:[NSString class]]){
            [str appendString:(NSString *)obj];
            if(i != array.count -1){
                [str appendString:(NSString *)separtor];
            }
        }else if([obj isKindOfClass:[JSONModel class]])
        {
            [str appendString:@"\n"];
            NSString * classStr = NSStringFromClass([obj class]);
            [str appendString:classStr];
            [str appendString:@":"];
            [str appendString:[(JSONModel*)obj toJSONString]];
            
            if(i != array.count -1){
                [str appendString:(NSString *)separtor];
            }
            
        }
        else
        {
            NSString * classStr = NSStringFromClass([obj class]);
            [str appendString:classStr];
            if(i != array.count -1){
                [str appendString:(NSString *)separtor];
            }
        }
    }
    return str;
}



/**
 int 转换成 string
 **/
+(NSString *)tkStringFromNumber:(NSInteger)value{
    return [NSNumber numberWithLong:value].stringValue;
}



-(NSString *)tkStringByAppendInteger:(NSInteger)number
{
    return [self stringByAppendingString:[NSString tkStringFromNumber:number]];
}


/**
 判断是否是数字 ， 包括小数点
 **/
-(BOOL)tkIsNumberText
{
    NSString *regex = @"[0-9.]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@",regex];
    return [predicate evaluateWithObject:self];
}


//判断是否为整形：
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}



@end
