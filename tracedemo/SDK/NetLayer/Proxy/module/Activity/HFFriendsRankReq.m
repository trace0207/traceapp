//
//  HFFriendsRankReq.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFFriendsRankReq.h"

@implementation HFFriendsRankReq
-(NSString *)reqUrl
{
    return @"CloudHealth/req/mobile/common/game/sudoku!selectRankListInIdol.action";
}

- (NSString *)reqMothod
{
    return @"POST";
}

@end
