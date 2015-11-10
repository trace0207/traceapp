//
//  HFRemindCell.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/29.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFRemindCell.h"

@implementation HFRemindCell

- (void)awakeFromNib {
    // Initialization code
    self.contentLabel.textColor = [UIColor HFColorStyle_7];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = @"手环和手机连接时，手机有新短信，手环会同步震动";
    
    
    [self.switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)switchAction:(UISwitch *)swi
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(switchState:AtCell:)])
    {
        [_delegate switchState:swi.on AtCell:self];
    }
    
    
}


@end
