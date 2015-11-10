//
//  HFUnlockCell.m
//  SDCycleScrollView
//
//  Created by 朱伟特 on 15/8/11.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "HFUnlockCell.h"

@interface HFUnlockCell()

@property (nonatomic, strong) NSMutableArray * dataArray;

@end
@implementation HFUnlockCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.suggestLabel.numberOfLines = 0;
    self.suggestLabelOnFinishCell.numberOfLines = 0;
    [self.nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.nextStepButton.layer.cornerRadius = self.nextStepButton.frame.size.height / 2;
    self.nextStepButton.backgroundColor = [UIColor HFColorStyle_5];
    self.nextStepButton.layer.masksToBounds = YES;
    
    self.endButton.layer.cornerRadius = self.endButton.frame.size.height / 2;
    [self.endButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.endButton.layer.masksToBounds = YES;
    
    self.startAgainButton.layer.cornerRadius = self.startAgainButton.frame.size.height / 2;
    [self.startAgainButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.startAgainButton.layer.masksToBounds = YES;
    self.startAgainButton.backgroundColor = [UIColor HFColorStyle_5];

    [self.reStartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.reStartButton.backgroundColor = [UIColor HFColorStyle_5];
    self.reStartButton.layer.cornerRadius = self.reStartButton.frame.size.height / 2;
    self.reStartButton.layer.masksToBounds = YES;

    self.holdOnLabel3.hidden = YES;
    self.holdOnLabel.hidden = YES;
    self.dayLabel.hidden = YES;
    self.thirdLabel.hidden = YES;
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, 35, 0, 0)];
    }
//    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self setLayoutMargins:UIEdgeInsetsMake(0, 35, 0, 0)];
//    }
//    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
//        [self setPreservesSuperviewLayoutMargins:YES];
//    }
}
- (void)setUnlockType:(HFUnlockType)unlockType
{
    if (unlockType != HFAdapt) {
        self.holdOnLabel3.hidden = NO;
        self.holdOnLabel.hidden = NO;
        self.dayLabel.hidden = NO;
        self.thirdLabel.hidden = NO;
    }
    if (unlockType == HFAdapt) {
        [self.nextStepButton setTitle:@"进入强化阶段" forState:UIControlStateNormal];
        [self.nextStepButton addTarget:self action:@selector(gotoNextStep) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.nextStepButton addTarget:self action:@selector(gotoNextStep) forControlEvents:UIControlEventTouchUpInside];
    if (unlockType == HFSteady) {
        [self.nextStepButton setTitle:@"进入维稳阶段" forState:UIControlStateNormal];
        [self.nextStepButton addTarget:self action:@selector(gotoNextStep) forControlEvents:UIControlEventTouchUpInside];
    }
    if (unlockType == HFOver) {
        [self.endButton setTitle:@"结束" forState:UIControlStateNormal];
        [self.startAgainButton setTitle:@"重新开始" forState:UIControlStateNormal];
        [self.endButton addTarget:self action:@selector(endSchemeNow) forControlEvents:UIControlEventTouchUpInside];
        [self.startAgainButton addTarget:self action:@selector(startSchemeAgainNow) forControlEvents:UIControlEventTouchUpInside];
    }
    if (unlockType == HFReStart) {
        [self.reStartButton setTitle:@"重新开始" forState:UIControlStateNormal];
        [self.reStartButton addTarget:self action:@selector(reStartScheme) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    for (GetSchemeStepResultListData * data in dataArray) {
        if (data.subType == 1) {
            self.holdOnLabel1.text = [NSString stringWithFormat:@"%lu", (unsigned long)data.completeDays];
            self.eatName.text = data.subSetName;
        }
        if (data.subType == 2) {
            self.holdOnLabel2.text = [NSString stringWithFormat:@"%lu", (unsigned long)data.completeDays];
            self.walkName.text = data.subSetName;
        }
        if (data.subType == 4) {
            self.holdOnLabel3.text = [NSString stringWithFormat:@"%lu", (unsigned long)data.completeDays];
            self.sportName.text = data.subSetName;
        }
    }
}
- (void)setSchemeData:(GetSchemeStepResultData *)schemeData
{
    self.achieveLabel.text = schemeData.stageTarget;
    self.suggestLabel.text = schemeData.stageSuggest;
    self.suggestLabelOnFinishCell.text = schemeData.stageSuggest;
    self.dataArray = schemeData.list;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)gotoNextStep
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(nextButtonClick)]) {
        [self.delegate nextButtonClick];
    }
}
- (void)endSchemeNow
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(endButtonClick)]) {
        [self.delegate endButtonClick];
    }
}
- (void)startSchemeAgainNow
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(startAgainButtonClick)]) {
        [self.delegate startAgainButtonClick];
    }
}
- (void)reStartScheme
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(restartButtonClick)]) {
        [self.delegate restartButtonClick];
    }
}
@end
