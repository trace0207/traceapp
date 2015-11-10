//
//  PostDetailRes.h
//  GuanHealth
//
//  Created by hermit on 15/5/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "PostDetailData.h"

@interface PostDetailRes : ResponseData

@property (nonatomic, strong) PostDetailData *data;

@end
