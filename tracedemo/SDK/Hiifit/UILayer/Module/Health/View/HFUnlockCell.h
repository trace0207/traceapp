//
//  HFUnlockCell.h
//  SDCycleScrollView
//
//  Created by 朱伟特 on 15/8/11.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"
#import "HFGIFView.h"
#import "HFUnlockViewController.h"
#import "GetSchemeStepResultAck.h"


@protocol HFUnlockCellDelegate <NSObject>

@optional

- (void)nextButtonClick;
- (void)endButtonClick;
- (void)startAgainButtonClick;
- (void)restartButtonClick;

@end
@interface HFUnlockCell : BaseTableCell

@property (nonatomic, strong) GetSchemeStepResultData * schemeData;


@property (nonatomic, assign) HFUnlockType unlockType;

@property (nonatomic, weak) id<HFUnlockCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *eatName;
@property (weak, nonatomic) IBOutlet UILabel *walkName;
@property (weak, nonatomic) IBOutlet UILabel *sportName;

@property (weak, nonatomic) IBOutlet UILabel *achieveLabel;//少吃多餐，轻微运动

@property (weak, nonatomic) IBOutlet UILabel *holdOnLabel1;//天数第一个label
@property (weak, nonatomic) IBOutlet UILabel *holdOnLabel2;//天数第二个label
@property (weak, nonatomic) IBOutlet UILabel *holdOnLabel3;//天数第三个label
@property (weak, nonatomic) IBOutlet UILabel *holdOnLabel;//坚持了label
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;//天label
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;//运动一下，增强体质

@property (weak, nonatomic) IBOutlet UILabel *suggestLabel;//建议
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;//下个阶段button
@property (weak, nonatomic) IBOutlet UIButton *endButton;
@property (weak, nonatomic) IBOutlet UIButton *startAgainButton;
@property (weak, nonatomic) IBOutlet UILabel *suggestLabelOnFinishCell;
@property (weak, nonatomic) IBOutlet UIButton *reStartButton;

@end
