//
//  CommentRes.h
//  GuanHealth
//
//  Created by hermit on 15/4/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@protocol CommentRes

@end

@interface CommentRes : ResponseData

@property (nonatomic,   copy) NSString   *headImageUrl;
@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic,   copy) NSString   *content;

@end
