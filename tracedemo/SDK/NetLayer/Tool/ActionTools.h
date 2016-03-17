//
//  ActionTools.h
//  GuanHealth
//
//  Created by luotianjia on 15/8/10.
//  Copyright (c) 2015年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionTools : NSObject


+(NSString *)getRelativePathByArgClass:(Class)argClass;

+(NSString *)getRelativePathByString:(NSString *)keyStr;

@end
