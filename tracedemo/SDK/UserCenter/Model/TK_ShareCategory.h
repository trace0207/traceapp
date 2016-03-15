//
//  TK_ShareType.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/17.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TK_ShareCategory : NSObject
/**
 *  类型描述
 */
@property (nonatomic,strong)NSString * title;

/**
 *  品类id
 */
@property (nonatomic,strong) NSString *categoryId;

@property (nonatomic,strong) NSString * createTime;

@property (nonatomic,strong) NSString * sum;

/**
 *  带参数初始化
 *
 *  @param title      品类名称
 *  @param categoryId 品类ID
 *
 *  @return Object
 */
+(instancetype)setTitle:(NSString *)title setId:(NSString *)categoryId time:(NSString *)createTime sum:(NSString *)sum;

@end
