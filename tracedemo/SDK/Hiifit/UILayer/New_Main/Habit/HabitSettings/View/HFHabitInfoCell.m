//
//  HFHabitInfoCell.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHabitInfoCell.h"

@implementation HFHabitInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
#pragma mark public
- (void)setContentWithHaibitName:(NSString *)habitName subscriHabitNum:(NSInteger)num  habitUrl:(NSString *)habitUrl
{
    if (habitUrl == nil || [habitUrl isEqualToString:@""])
    {
        _habitView.image = IMG(@"default_habit");
    }
    else
    {
        [_habitView sd_setImageWithURL:[NSURL URLWithString:habitUrl] placeholderImage:IMG(@"default_habit")];
    }
    
    _mHabitNameLabel.text = habitName;
    _mHabiterLabel.text = [NSString stringWithFormat:@"%ld参与者",num];
}

- (void)setCellForHabitDes:(NSString *)info
{
    self.mTextField.text = info;
}


#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_delegate && [_delegate respondsToSelector:@selector(haibtInfoEdit:)])
    {
        [_delegate haibtInfoEdit:textField.text];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length > 20  && string.length>0)
    {
        return NO;
    }
    return YES;
}


@end
