//
//  MyPostListRes.h
//  GuanHealth
//
//  Created by hermit on 15/5/7.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "PostDetailData.h"
@interface MyPostListRes : ResponseData

@property (nonatomic, strong) NSArray<PostDetailData> *data;

@end
