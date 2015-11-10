//
//  LoginRes.h
//  GuanHealth
//
//  Created by hermit on 15/2/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@interface LoginRes : ResponseData

@property (nonatomic, assign) NSInteger unread_msg_count;
@property (nonatomic,   copy) NSString  *headPortraitUrl;
@property (nonatomic,   copy) NSString  *jdeviceid;//会话id

@end
