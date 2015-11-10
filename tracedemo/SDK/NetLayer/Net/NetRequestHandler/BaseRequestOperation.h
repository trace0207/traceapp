//
//  BaseRequestOperation.h
//  GuanHealth
//
//  Created by hermit on 15/3/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "AFHTTPRequestOperation.h"
#import "IParser.h"
#import "ResponseData.h"

@interface BaseRequestOperation : AFHTTPRequestOperation
/**
 The iParse interface.
 */
@property (nonatomic, copy)   ParseBlock  parseBlock;

@property (nonatomic, copy)   NSString  * parseClass;

/**
 The iParse ResponseData.
 */
@property (nonatomic, strong) ResponseData  *parseResponse;

- (void)setCompletionBlockWithSuccess:(void (^)(BaseRequestOperation *operation, id responseObject))success
                              failure:(void (^)(BaseRequestOperation *operation, NSError *error))failure;

@end
