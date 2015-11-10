//
//  HFVideoViewController.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"
#import "GetSuggestAck.h"
#import "GetSchemeDayInfoAck.h"

@class LoadSchemeDataAck;
@protocol HFVideoViewControllerDelegate <NSObject>

@optional
- (void)retSportFinsih;

@end

@interface HFVideoViewController : BaseViewController

@property (nonatomic, assign) BOOL fromGoodIdea;
@property (nonatomic, assign) BOOL showFinishedBtn;

@property (nonatomic, strong) GetSuggestData *sportData;
@property (nonatomic ,strong) GetSchemeDayInfoData *schemeData;
@property (nonatomic, strong) NSArray *sportDataArray;
@property (nonatomic, assign) NSInteger startIndex;

@property(nonatomic,weak)id<HFVideoViewControllerDelegate>delegate;
@end
