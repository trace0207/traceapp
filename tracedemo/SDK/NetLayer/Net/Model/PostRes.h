//
//  PostRes.h
//  GuanHealth
//
//  Created by hermit on 15/4/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "ImagesRes.h"
#import "PraiseRes.h"
#import "CommentRes.h"

@interface PostRes : ResponseData

@property (nonatomic,   copy) NSString      *headImageUrl;
@property (nonatomic,   copy) NSString      *name;
@property (nonatomic,   copy) NSString      *habit;
@property (nonatomic, strong) NSDate        *date;
@property (nonatomic,   copy) NSString      *content;

@property (nonatomic, strong) NSArray<ImagesRes>  *images;
@property (nonatomic, strong) NSArray<PraiseRes>  *praises;
@property (nonatomic, strong) NSArray<CommentRes> *comments;

@end
