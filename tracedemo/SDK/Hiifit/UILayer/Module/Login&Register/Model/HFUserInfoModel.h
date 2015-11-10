//
//  HFUserInfoModel.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/16.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFUserInfoModel : NSObject

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger userType;
@property (nonatomic, assign) NSInteger sex;


@end
