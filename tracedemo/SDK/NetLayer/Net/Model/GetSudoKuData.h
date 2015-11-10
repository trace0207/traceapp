//
//  GetSudoKuData.h
//  GuanHealth
//
//  Created by hermit on 15/5/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@interface GetSudoKuData : ResponseData

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *solution;

@property (nonatomic, assign) int degree;
@property (nonatomic, assign) int id;

@end
