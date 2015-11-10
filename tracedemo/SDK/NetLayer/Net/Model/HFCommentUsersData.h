//
//  HFCommentUsersData.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@protocol HFCommentUsersData
@end

@interface HFCommentUsersData : ResponseData

@property(nonatomic,strong)NSString * followerNickName;
@property(nonatomic)NSInteger followerId;
@property(nonatomic)NSInteger authorId;
@property(nonatomic,strong)NSString * headPortraitUrl;
@property(nonatomic,strong)NSString * content;
@property(nonatomic,strong)NSString * authorNickName;
@property (nonatomic) NSInteger commentId;
@property (nonatomic, assign) NSInteger createTime;

@end
