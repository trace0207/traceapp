//
//  HFUnlockViewController.h
//  SDCycleScrollView
//
//  Created by 朱伟特 on 15/8/3.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadSchemeDataAck.h"
#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, HFUnlockType){
    HFAdapt = 2,//强化阶段
    HFSteady,//维稳阶段
    HFOver,//结束阶段
    HFReStart//重新开始
};

@interface HFUnlockViewController : BaseViewController

- (id)initWithType:(HFUnlockType)unlockType;
@property (nonatomic, strong) LoadSchemeDataAck         *schemeData;
@property (nonatomic, assign) HFUnlockType unlockType;
@end
