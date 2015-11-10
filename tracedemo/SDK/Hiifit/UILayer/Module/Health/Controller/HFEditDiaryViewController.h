//
//  HFEditDiaryViewController.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/5.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "TKPicSelectViewController.h"
#import "GetSchemeDayInfoAck.h"
@class LoadSchemeDataAck;

@protocol HFEditDiaryViewControllerDelegate <NSObject>

@optional
/**
 *  发表成功告知外面
 */
- (void)retPushDiraySuccess;

@end

@interface HFEditDiaryViewController : TKPicSelectViewController
@property (nonatomic ,strong) GetSchemeDayInfoData * schemeData;
@property (nonatomic ,weak) id<HFEditDiaryViewControllerDelegate>delegate;
@end
