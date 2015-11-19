//
//  TK_ShareType.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/17.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_ShareCategory.h"

@implementation TK_ShareCategory


/**
 *  带参数初始化
 *
 *  @param title      品类名称
 *  @param categoryId 品类ID
 *
 *  @return Object
 */
+(instancetype)setTitle:(NSString *)title setId:(NSInteger)categoryId{
    TK_ShareCategory * shareCategory = [[TK_ShareCategory alloc]init];
    shareCategory.title = title;
    shareCategory.categoryId = categoryId;
    return shareCategory;
}

@end
