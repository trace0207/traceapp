//
//  BandHistoryAck.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/7.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

@class HF_BaseAck;

@protocol BandHistoryData <NSObject>
@end

@interface BandHistoryData : TK_BaseJsonModel

@property (nonatomic, assign) NSInteger step;
@property (nonatomic, assign) NSInteger calorie;

@property (nonatomic, assign) NSInteger manufacturer;//手环厂家
@property (nonatomic, copy)   NSString  *productModel;//手环型号
@property (nonatomic, copy)   NSString  *createDate;//手环记步日期

@end


@interface BandHistoryAck : HF_BaseAck

@property (nonatomic, strong) NSArray <BandHistoryData> *data;

@end
