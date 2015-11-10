//
//  TK_JsonModelAck.h
//  GuanHealth
//
//  Created by cmcc on 15/8/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TK_BaseJsonModel.h"
#import "JSONModel.h"

@interface TK_JsonModelAck : TK_BaseJsonModel
@property (nonatomic,strong) NSError<Ignore> * error;

@end
