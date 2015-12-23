//
//  GetAdvanceSchemeMainPageAck.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/9/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

@class HF_BaseAck;


@interface GetAdvanceSchemeMainPageSubData : TK_BaseJsonModel

@property (nonatomic, copy) NSString * subSchemeName;
@property (nonatomic, assign) NSInteger subSchemeId;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger isSubscribe;
@property (nonatomic, assign) NSInteger days;

@end
@protocol GetAdvanceSchemeMainPageSubData <NSObject>

@end
@interface GetAdvanceSchemeMainPageData : TK_BaseJsonModel

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * desc1;
@property (nonatomic, copy) NSString * picAddr;
@property (nonatomic, assign) NSInteger userSchemeId;
@property (nonatomic, assign) NSInteger tieBaUnreadCount;

@property (nonatomic, strong) NSArray<GetAdvanceSchemeMainPageSubData>* homeSubSchemeList;

@end
@protocol GetAdvanceSchemeMainPageData <NSObject>

@end
@interface GetAdvanceSchemeMainPageAck : HF_BaseAck

@property (nonatomic, strong) GetAdvanceSchemeMainPageData * data;

@end
