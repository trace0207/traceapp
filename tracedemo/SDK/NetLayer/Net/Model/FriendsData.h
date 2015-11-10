//
//  FriendsData.h
//  GuanHealth
//
//  Created by hermit on 15/4/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@protocol FriendsData

@end

@interface FriendsData : ResponseData

@property (nonatomic, assign) int userId;

@property (nonatomic, assign) int status;

@property (nonatomic, strong) NSString *nickName;

@property (nonatomic, strong) NSString *headPortraitUrl;

@end
