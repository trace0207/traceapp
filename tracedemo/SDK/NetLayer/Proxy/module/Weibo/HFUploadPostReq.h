//
//  HFUploadPostReq.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HFUploadPostReq : BaseHttpReq

@property (nonatomic, assign) NSInteger weiboType;
@property (nonatomic, assign) NSInteger tiebaId;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pic_addr_01;
@property (nonatomic, copy) NSString *pic_addr_02;
@property (nonatomic, copy) NSString *pic_addr_03;
@property (nonatomic, copy) NSString *pic_addr_04;
@property (nonatomic, copy) NSString *pic_addr_05;
@property (nonatomic, copy) NSString *pic_addr_06;
@property (nonatomic, copy) NSString *pic_addr_07;
@property (nonatomic, copy) NSString *pic_addr_08;
@property (nonatomic, copy) NSString *pic_addr_09;

@end
