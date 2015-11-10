//
//  HFTestView.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/9/27.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetQuizSubjectAgainAck.h"

@protocol HFTestViewDelegate <NSObject>

@optional
- (void)chooseAnswer:(BOOL)answer;
- (void)giveUpTest;
- (void)backToLastTest;

@end
@interface HFTestView : UIView

@property (nonatomic, strong) GetQuizSubjectAgainAck * againData;
@property (nonatomic, weak) id<HFTestViewDelegate>delegate;
@property (nonatomic, strong) UILabel * titleLabel;

- (void)changeImageNext:(NSInteger)index;
- (void)changeImageFormer:(NSInteger)index withButtonState:(NSString *)state;
- (void)changeButtonState;
@end
