//
//  VercodeRes.h
//  GuanHealth
//
//  Created by hermit on 15/3/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@interface VercodeRes : ResponseData

@property (nonatomic,   copy)   NSString    *verificationCode;
@property (nonatomic,   copy)   NSString    *headPortraitUrl;

@end
