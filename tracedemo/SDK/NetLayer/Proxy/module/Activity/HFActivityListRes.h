//
//  HFActivityListRes.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@protocol HFActivityListData <NSObject>

@end

@interface HFActivityListData : ResponseData

@property(nonatomic)NSInteger id;
@property(nonatomic,copy)NSString * title;
@property(nonatomic)NSInteger type;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * startTimeFormat;
@property(nonatomic,copy)NSString * endTimeFormat;
@property(nonatomic)NSInteger status;
@property(nonatomic,copy)NSString * picAddrUrl;
@property(nonatomic)NSInteger startDays;
@property(nonatomic)NSInteger endDays;
@end


@interface HFActivityListRes : ResponseData

@property(nonatomic)NSInteger pageCount;
@property(nonatomic)NSInteger total;
@property(nonatomic)NSInteger pageSize;
@property(nonatomic,strong)NSArray<HFActivityListData> * data;

@end
