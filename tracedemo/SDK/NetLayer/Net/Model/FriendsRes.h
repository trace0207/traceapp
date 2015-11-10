//
//  FriendsRes.h
//  GuanHealth
//
//  Created by hermit on 15/4/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "FriendsData.h"

@interface FriendsRes : ResponseData

@property (nonatomic, assign) int pageCount;
@property (nonatomic, assign) int total;
@property (nonatomic, assign) int pageSize;

@property (nonatomic, strong) NSArray<FriendsData>  *data;

@end
