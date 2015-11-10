//
//  HFMainActivityRes.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@protocol HFMainActivityData <NSObject>
@end

@interface HFMainActivityData : ResponseData

//@property(nonatomic)NSInteger sortId;
@property(nonatomic)NSInteger type;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * url;
//@property(nonatomic,copy)NSString * picIos;
@property(nonatomic,copy)NSString * picUrl;
@end

@interface HFMainActivityRes : ResponseData

@property(nonatomic,strong)  NSArray<HFMainActivityData> *data;

@end
