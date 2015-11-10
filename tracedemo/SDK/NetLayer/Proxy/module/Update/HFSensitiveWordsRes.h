//
//  HFSensitiveWordsRes.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/6/16.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@interface HFSensitiveWordsData : ResponseData

@property (nonatomic, assign) long lastUpdateTime;
@property (nonatomic,   copy) NSString *sensitiveWords;

@end


@interface HFSensitiveWordsRes : ResponseData

@property (nonatomic, strong) HFSensitiveWordsData *data;

@end
