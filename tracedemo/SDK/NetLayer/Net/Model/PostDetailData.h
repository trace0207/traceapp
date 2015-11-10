//
//  PostDetailData.h
//  GuanHealth
//
//  Created by hermit on 15/5/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "Data.h"

@protocol PostDetailData
@end

@interface PostDetailData : ResponseData

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger weiboId;
@property (nonatomic, assign) NSInteger praiseNum;
@property (nonatomic, assign) NSInteger praised;//当前用户是否点赞过微博 0 表示没有 1表示有
@property (nonatomic, assign) NSInteger commentNum;

@property (nonatomic, assign) NSInteger secondTime;//微博创建时间
@property (nonatomic, assign) NSInteger authorId;//微博创建者id

@property (nonatomic,   copy) NSString *title;
@property (nonatomic,   copy) NSString *content;
@property (nonatomic,   copy) NSString *name;           //习惯名称或微博名称
@property (nonatomic,   copy) NSString *headPortraitUrl;
@property (nonatomic,   copy) NSString *nickName;
@property (nonatomic,   copy) NSString *picAddr1;
@property (nonatomic,   copy) NSString *picAddr2;
@property (nonatomic,   copy) NSString *picAddr3;
@property (nonatomic,   copy) NSString *picAddr4;
@property (nonatomic,   copy) NSString *picAddr5;
@property (nonatomic,   copy) NSString *picAddr6;
@property (nonatomic,   copy) NSString *picAddr7;
@property (nonatomic,   copy) NSString *picAddr8;
@property (nonatomic,   copy) NSString *picAddr9;

//此处少一层桥接层  并不属于服务器数据
@property (nonatomic)PostCellExpandState  expandFlag;

- (void)copyFromData:(Data*)data;

@end
