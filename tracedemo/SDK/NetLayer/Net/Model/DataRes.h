//
//  DataRes.h
//  GuanHealth
//
//  Created by hermit on 15/3/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "UserRes.h"

@interface DataRes : ResponseData

@property (strong, nonatomic) UserRes *user;

@end
