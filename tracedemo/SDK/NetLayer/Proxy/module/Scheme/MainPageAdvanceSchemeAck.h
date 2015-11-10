//
//  MainPageAdvanceSchemeAck.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/9/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "TK_BaseJsonModel.h"
@protocol MainPageAdvanceSubSchemeData <NSObject>
@end

@interface MainPageAdvanceSubSchemeData : TK_BaseJsonModel
@property (nonatomic, copy) NSString * subName;
@property (nonatomic, assign) NSInteger subSchemeId;
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, copy) NSString * iconAddr;
@end



@protocol MainPageAdvanceSchemeData <NSObject>
@end

@interface MainPageAdvanceSchemeData : TK_BaseJsonModel

@property (nonatomic, copy) NSString * crowd;
@property (nonatomic, copy) NSString * iconAddr;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger isSubscribe;
@property (nonatomic, assign) NSInteger subscribeNum;
@property (nonatomic, strong) NSString * picAddr;
@property (nonatomic, assign) NSInteger isNew;
@property (nonatomic, strong) NSArray<MainPageAdvanceSubSchemeData> * subSchemeList;

@end

@interface MainPageAdvanceSchemeAck : HF_BaseAck

@property (nonatomic, strong) NSArray <MainPageAdvanceSchemeData>* data;

@end
