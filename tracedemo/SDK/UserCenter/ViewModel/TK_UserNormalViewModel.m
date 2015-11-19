//
//  TK_UserNormalViewModel.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/17.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_UserNormalViewModel.h"

@implementation TK_UserNormalViewModel

-(instancetype)init{

    self = [super init];
    _shareCategorys = [self getShareCategory];
    return self;
}



-(NSMutableArray * )getShareCategory{
    
    NSMutableArray * array = [[NSMutableArray alloc]init];
    [array addObject:[TK_ShareCategory setTitle:@"服饰" setId:1]];
    [array addObject:[TK_ShareCategory setTitle:@"箱包" setId:2]];
    [array addObject:[TK_ShareCategory setTitle:@"手袋" setId:3]];
    [array addObject:[TK_ShareCategory setTitle:@"护肤" setId:4]];
    [array addObject:[TK_ShareCategory setTitle:@"香水" setId:5]];
    return array;
}

@end
