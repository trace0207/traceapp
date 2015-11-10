//
//  HFHabitTimeCell.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHabitTimeCell.h"
#import "HFHabitAlarmClockRes.h"
@implementation HFHabitTimeCell
@synthesize delegate;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchClockState:(UISwitch *)sender
{
    if (delegate && [delegate respondsToSelector:@selector(switchHabitState:AtCell:)])
    {
        [delegate switchHabitState:sender AtCell:self];
    }
}

- (void)setContent:(HFHabitAlramClockListData *)data
{
    _mClockSwi.onTintColor = [UIColor HFColorStyle_5];
    NSString * time = [NSString stringWithFormat:@"%02ld:%02ld",(long)data.hour,(long)data.minute];
    _mStartTime.text = time;
    _mClockSwi.on = data.status;
    _mRepeatDayLabel.text = [UIKitTool transfromFromWeeksStr:data.weeks];
}
@end
