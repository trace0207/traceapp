//
//  HFConclusionView.h
//  UIButtonExtension
//
//  Created by 朱伟特 on 15/9/15.
//  Copyright (c) 2015年 朱伟特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"
#import "GetQuizConclusionAck.h"

@protocol HFConclusionViewDelegate <NSObject>

- (void)restartTest;
- (void)getScheme;
- (void)giveUp;
- (void)closeConclusion;

@end
@interface HFConclusionView : BaseTableCell

@property (nonatomic, strong) GetQuizConclusionAck * data;
@property (nonatomic, weak) id<HFConclusionViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *getSchemeButton;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *giveButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *testResultLabel;
- (IBAction)restart:(id)sender;
- (IBAction)getScheme:(id)sender;
- (IBAction)giveUpTest:(id)sender;
- (void)changeState;
@end
