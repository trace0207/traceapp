//
//  ReportBandArg.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/7.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HF_BaseArg.h"

@interface ReportBandArg : HF_BaseArg

@property (nonatomic, assign) NSInteger step;//手环步数
@property (nonatomic, assign) NSInteger calorie;//手环卡路里的值
@property (nonatomic, assign) NSInteger manufacturer;//厂家，1:埃微
@property (nonatomic, copy) NSString *productModel;//产品型号
@property (nonatomic, strong) NSString * createDate;
@end
