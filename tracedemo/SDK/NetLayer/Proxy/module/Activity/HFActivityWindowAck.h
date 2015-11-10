//
//  HFActivityWindowAck.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/30.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HF_BaseAck.h"

@interface HFActivityWindowData : TK_BaseJsonModel

@property (nonatomic, copy) NSString * picAddr;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, assign) NSInteger title;

@end

@interface HFActivityWindowAck : HF_BaseAck

@property (nonatomic, strong) HFActivityWindowData * data;

@end
