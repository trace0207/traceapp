//
//  ActivitiesData.h
//  GuanHealth
//
//  Created by hermit on 15/4/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@protocol ActivitiesData

@end

@interface ActivitiesData : ResponseData

@property (nonatomic, assign)   int       id;
@property (nonatomic,   copy)   NSString *title;
@property (nonatomic,   copy)   NSString *content;
@property (nonatomic,   copy)   NSString *url;


@end
