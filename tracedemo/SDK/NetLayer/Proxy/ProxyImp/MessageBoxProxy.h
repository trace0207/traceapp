//
//  HFMessageManager.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/22.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFMessageBoxRes.h"
typedef void (^messageBlock)(HFMessageBoxData *);
typedef void (^messageInfoSuccessBlock)(NSArray *);
typedef void (^messageInfoFailBlock) (void);
typedef void (^messageStateBlock)();

@interface MessageBoxProxy : NSObject

//请求未读消息条数
- (void)hasUnReadMessageWithCompletion:(messageBlock)block;
//请求type，未读信息
- (void)reqMessageInfoWithType:(NSInteger)type
                        atPage:(NSInteger)page
                       success:(messageInfoSuccessBlock)successBlock
                          fail:(messageInfoFailBlock)fail;
//重置消息已读
- (void)resetMessageInfoStateWithType:(NSInteger)type withCompletion:(messageStateBlock)block;

@end
