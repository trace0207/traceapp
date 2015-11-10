//
//  ActionTools.m
//  GuanHealth
//
//  Created by luotianjia on 15/8/10.
//  Copyright (c) 2015年 cmcc. All rights reserved.
//

#import "ActionTools.h"

@implementation ActionTools


+(NSString*)getRelativePathByArgClass:(Class)argClass{
    
    NSString * className = NSStringFromClass(argClass);
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"HttpAction" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
   
   
    NSString * value =[data objectForKey:className];
    if(!value){
        value = @"/error";
    }
    return value;
}

@end
