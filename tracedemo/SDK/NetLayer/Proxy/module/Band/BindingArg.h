//
//  BindingArg.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/7.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HF_BaseArg.h"

@interface BindingArg : HF_BaseArg

@property (nonatomic, copy) NSString *bandDeviceId;//手环设备id，不为空绑定，为空解绑

@end
