//
//  HFHabitInfoCell.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFHabitAlarmClockRes.h"

@protocol HFHabitInfoCellDelegate <NSObject>

- (void)haibtInfoEdit:(NSString *)habitInfo;

@end

@interface HFHabitInfoCell : BaseTableCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BasePortraitView *habitView;
@property (weak, nonatomic) IBOutlet UILabel *mHabitNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mHabiterLabel;
@property (weak, nonatomic) id<HFHabitInfoCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITextField * mTextField;


- (void)setContentWithHaibitName:(NSString *)habitName subscriHabitNum:(NSInteger)num  habitUrl:(NSString *)habitUrl;

- (void)setCellForHabitDes:(NSString *)info;

@end
