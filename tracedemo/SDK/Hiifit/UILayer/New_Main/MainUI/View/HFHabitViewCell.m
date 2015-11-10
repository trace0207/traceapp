//
//  TableViewCell.m
//  GuanHealth
//
//  Created by hermit on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHabitViewCell.h"

@implementation HFHabitViewCell

- (void)awakeFromNib {
    // Initialization code
    //self.contentView.backgroundColor = [UIColor hexChangeFloat:kColorBlack withAlpha:0.02f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:YES];
}

- (void)setContentToCell:(HFHabitListData *)habit
{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:habit.habitIconUrl] placeholderImage:IMG(@"heabit")];
    self.habitLabel.text = habit.habitName;
    self.peopleNumLabel.text = [NSString stringWithFormat:@"%@参与者",@(habit.subscribeNum)];
    self.clockImage.hidden = habit.hasClock == 1 ? NO:YES;
    self.finishedLabel.hidden = !habit.flag;
}

- (IBAction)addHabitAction:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(addNewHabit)])
    {
        [_delegate addNewHabit];
    }
    
    
}

@end
