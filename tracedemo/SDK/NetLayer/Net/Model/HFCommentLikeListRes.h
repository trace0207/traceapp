//
//  HFCommentLikeListRes.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "HFCommentLikeListData.h"
@interface HFCommentLikeListRes : ResponseData

@property(nonatomic,strong)NSArray<HFCommentLikeListData> * data;
@end
