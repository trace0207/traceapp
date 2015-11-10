//
//  HFHabitListRes.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@protocol HFHabitListData
@end

@interface HFHabitListData : ResponseData

@property(nonatomic,copy)   NSString * habitIconUrl;
@property(nonatomic,assign) NSInteger hasClock;
@property(nonatomic,assign) BOOL flag;
@property(nonatomic,assign) NSInteger subscribeNum;
@property(nonatomic,copy)   NSString * habitName;
@property(nonatomic,assign) NSInteger dummyNum;
@property(nonatomic,assign) NSInteger habitId;
@property(nonatomic,copy)  NSString * habitNote;
@end


@interface HFHabitListRes : ResponseData

@property (nonatomic, strong) NSArray<HFHabitListData> *data;

@end
