//
//  HFIntroduceViewController.h
//  SDCycleScrollView
//
//  Created by 朱伟特 on 15/8/10.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class LoadSchemeDataAck;
@interface HFIntroduceViewController : BaseViewController

@property (nonatomic, assign) BOOL needShowGuideView;
@property (nonatomic ,strong) LoadSchemeDataAck *schemeInfo;

@end
