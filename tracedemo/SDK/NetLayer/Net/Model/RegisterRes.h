//
//  RegisterRes.h
//  GuanHealth
//
//  Created by hermit on 15/2/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@interface RegisterRes : ResponseData

@property (nonatomic,   copy)   NSString    *verificationCode;
@property (nonatomic,   copy)   NSString    *headPortraitUrl;

@end
