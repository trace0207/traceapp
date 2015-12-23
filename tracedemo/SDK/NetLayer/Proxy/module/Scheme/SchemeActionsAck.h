//
//  SchemeActionsAck.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

@class HF_BaseAck;

@protocol SchemeActionsData <NSObject>

@end

@interface SchemeActionsData : TK_BaseJsonModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger type;//2.gif  3.视频
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *picAddr;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *videoAddr;

@end

@interface SchemeActionsAck : HF_BaseAck
@property (nonatomic, strong) NSArray<SchemeActionsData> *data;
@end
