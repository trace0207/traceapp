//
//  HFHabitTimeCell.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HFHabitAlramClockListData;
@class HFHabitTimeCell;
@protocol HFHabitTimeCellDelegate <NSObject>

- (void)switchHabitState:(UISwitch *)swi AtCell:(HFHabitTimeCell *)cell;

@end


@interface HFHabitTimeCell : BaseTableCell
@property (weak, nonatomic) IBOutlet UILabel *mStartTime;
@property (weak, nonatomic) IBOutlet UILabel *mRepeatDayLabel;
@property (weak, nonatomic) IBOutlet UISwitch *mClockSwi;
@property (weak, nonatomic) id<HFHabitTimeCellDelegate>delegate;
- (IBAction)switchClockState:(UISwitch *)sender;

- (void)setContent:(HFHabitAlramClockListData *)data;
@end
