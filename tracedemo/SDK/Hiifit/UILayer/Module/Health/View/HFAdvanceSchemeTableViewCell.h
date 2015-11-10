//
//  HFAdvanceSchemeTableViewCell.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/9/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"
#import "GetAdvanceSchemeMainPageAck.h"
#import "HFLevelView.h"

@protocol HFAdvanceSchemeTableViewCellDelegate <NSObject>

- (void)jumpToTest;

- (void)giveupAdvanceScheme;

- (void)restartTest;
@end


@interface HFAdvanceSchemeTableViewCell : BaseTableCell
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *mTitleLable;
@property (weak, nonatomic) IBOutlet HFLevelView *mLevelView;
@property (weak, nonatomic) IBOutlet UILabel *mDayInfoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mAddView;
@property (weak, nonatomic) IBOutlet UIButton * moreButton;
@property (weak, nonatomic) IBOutlet UIButton *startTestBtn;

@property (weak, nonatomic) id<HFAdvanceSchemeTableViewCellDelegate>delegate;

- (void)setContentData:(GetAdvanceSchemeMainPageSubData *)data;

- (IBAction)moreAction:(UIButton *)sender;
- (IBAction)beginTestAction:(UIButton *)sender;

@end
