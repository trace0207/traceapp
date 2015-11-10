//
//  HFCommentListData.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
@protocol HFCommentLikeListData
@end
@interface HFCommentLikeListData : ResponseData

@property(nonatomic,strong)NSString * nickName;
@property(nonatomic,assign)NSInteger  userId;
@property(nonatomic, copy)NSString * headPortraitUrl;
@end
