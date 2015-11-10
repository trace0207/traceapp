//
//  TimeLineRes.h
//  GuanHealth
//
//  Created by hermit on 15/4/5.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "Data.h"

@interface TimeLineRes : ResponseData

@property (nonatomic, strong) NSArray<Data>    *data;

//@property (nonatomic, assign) int pageSize;         //每页的消息数
//@property (nonatomic, assign) int pageCount;        //总页数
//@property (nonatomic, assign) int total;            //总条数
@property (nonatomic, assign) float onlineTime;     //在线时长


//@property (nonatomic, assign) float healthScore;    //健康值

@end
