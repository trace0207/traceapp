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
        }else{
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




@end
