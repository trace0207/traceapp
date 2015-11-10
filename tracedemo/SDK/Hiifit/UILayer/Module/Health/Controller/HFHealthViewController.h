//
//  HFHealthViewController.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/7/30.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class LoadSchemeDataAck;

typedef  NS_ENUM(NSInteger, SchemeReqType)
{
    SchemeReq_Eat = 0,
    SchemeReq_Diary,
    SchemeReq_Sport,
    SchemeReq_Unknow,
};


@interface HFHealthViewController : BaseViewController

@property (nonatomic, assign) BOOL needShowGuideView;
@property (weak, nonatomic) IBOutlet UITableView *mMainTableView;
@property (nonatomic ) NSInteger mSchemeDay;

@end
