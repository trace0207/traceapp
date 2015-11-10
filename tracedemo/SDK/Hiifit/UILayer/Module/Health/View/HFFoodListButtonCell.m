//
//  HFFoodListButtonCell.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFFoodListButtonCell.h"
#import "UIImage+Scale.h"

@implementation HFFoodListButtonCell

- (void)awakeFromNib {
    // Initialization code
    [self.foodListBtn setBackgroundImage:[UIImage scaleWithImage:@"My_bigButton"] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)watchNextAction:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(nextDayAction)])
    {
        [_delegate nextDayAction];
    }
    
}
@end
