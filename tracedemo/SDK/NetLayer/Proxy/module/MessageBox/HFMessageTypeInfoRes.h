//
//  HFMessageTypeInfoRes.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/21.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@protocol HFMessageTypeInfoData <NSObject>
@end

@interface HFMessageTypeInfoData : ResponseData

@property(nonatomic,strong)NSString * operatorName;   //和系统关键字冲突
@property(nonatomic)NSInteger operatorId;
@property(nonatomic,strong)NSString * headPortraitUrl;
@property(nonatomic,strong)NSString * content;
@property(nonatomic)NSInteger flag;
@property(nonatomic)NSInteger goalId;
@property(nonatomic)NSInteger source;
@property(nonatomic,strong)NSString * goalContent;
@property(nonatomic,strong)NSString * picAddr1;
@property(nonatomic)NSInteger secondTime;
@end


@interface HFMessageTypeInfoRes : ResponseData
@property(nonatomic,strong)NSArray<HFMessageTypeInfoData> * data;
@end
