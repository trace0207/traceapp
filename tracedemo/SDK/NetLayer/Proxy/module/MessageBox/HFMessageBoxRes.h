//
//  HFMessageBoxRes.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/21.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@interface HFMessageBoxData : ResponseData

@property(nonatomic,assign)NSInteger unReadComentCount;       //未读的评论条数
@property(nonatomic,assign)NSInteger unReadFollowCount;       //未读的关注条数
@property(nonatomic,assign)NSInteger unReadPraiseCount;       //未读的点赞条数
@property(nonatomic,assign)NSInteger unReadSystemCount;       //未读的系统条数
@property(nonatomic,assign)NSInteger unReadMessage;           //未读的消息
@end

@interface HFMessageBoxRes : ResponseData

@property(nonatomic, strong)HFMessageBoxData * data;
@end
