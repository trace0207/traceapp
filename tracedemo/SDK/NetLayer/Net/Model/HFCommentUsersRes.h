//
//  HFCommentUsersRes.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "HFCommentUsersData.h"
@interface HFCommentUsersRes : ResponseData

@property(nonatomic)NSInteger pageCount;
@property(nonatomic)NSInteger total;
@property(nonatomic)NSInteger pageSize;
@property(nonatomic,strong)NSArray<HFCommentUsersData> * data;
@end
