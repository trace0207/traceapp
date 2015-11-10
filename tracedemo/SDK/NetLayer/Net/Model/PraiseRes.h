//
//  PraiseRes.h
//  GuanHealth
//
//  Created by hermit on 15/4/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "JSONModel.h"

@protocol PraiseRes
@end

@interface PraiseRes : JSONModel

@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic,   copy) NSString   *headImageUrl;

@end
