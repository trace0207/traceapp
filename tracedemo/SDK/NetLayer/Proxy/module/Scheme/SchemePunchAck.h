//
//  SchemePunchAck.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HF_BaseAck.h"

@protocol SchemePunchList <NSObject>
@end
@interface SchemePunchList : TK_BaseJsonModel
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger createTimeUTC;
@property (nonatomic, assign) NSInteger tiebaId;
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *headPortraitUrl;
@end

@interface SchemePunchData : TK_BaseJsonModel
@property (nonatomic, assign) NSInteger complateCount;
@property (nonatomic, strong) NSArray<SchemePunchList> *list;
@end

@interface SchemePunchAck : HF_BaseAck
@property (nonatomic, strong) SchemePunchData *data;
@end
