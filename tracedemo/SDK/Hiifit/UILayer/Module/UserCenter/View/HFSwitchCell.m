//
//  HFSwitchCell.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFSwitchCell.h"

@implementation HFSwitchCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, 52, 0, 0)];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0, 52, 0, 0)];
    }
    self.msgSwitch.onTintColor = [UIColor HFColorStyle_5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
