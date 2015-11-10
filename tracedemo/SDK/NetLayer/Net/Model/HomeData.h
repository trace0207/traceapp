//
//  HomeData.h
//  GuanHealth
//
//  Created by hermit on 15/4/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@interface HomeData : ResponseData

@property (nonatomic, assign)   int fansCount;
@property (nonatomic, assign)   int followCount;
@property (nonatomic, assign)   int sex;
@property (nonatomic, assign)   int status;         //1关注   0未关注

@property (nonatomic,   copy)   NSString  *nickName;
@property (nonatomic,   copy)   NSString  *signature;//签名
@property (nonatomic,   copy)   NSString  *headPortraitUrl;

- (BOOL)isGirl;

@end
