//
//  HFWorldRankReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFWorldRankReq.h"

@implementation HFWorldRankReq

-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/game/sudoku!selectRankListInAll.action";
}
- (NSString *)reqMothod
{
    return @"POST";
}
@end
