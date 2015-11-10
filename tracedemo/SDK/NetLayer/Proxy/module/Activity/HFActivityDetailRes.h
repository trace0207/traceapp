//
//  HFActivityDetailRes.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@interface HFActivityDetailData : ResponseData

@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * startTimeFormat;
@end


@interface HFActivityDetailRes : ResponseData

@end
