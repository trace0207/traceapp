//
//  ImagesRes.h
//  GuanHealth
//
//  Created by hermit on 15/4/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "JSONModel.h"

@protocol ImagesRes

@end

@interface ImagesRes : JSONModel

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *smallUrl;

@end
