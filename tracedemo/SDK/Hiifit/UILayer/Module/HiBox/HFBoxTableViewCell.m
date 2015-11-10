//
//  HFBoxTableViewCell.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/29.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFBoxTableViewCell.h"

@implementation HFBoxTableViewCell

- (void)awakeFromNib {
    // Initialization code
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0, 72, 0, 0)];
    }
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, 72, 0, 0)];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setContentToCell:(HiModuleListData *)data
{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:data.picAddr] placeholderImage:IMG(@"heabit")];
    self.titleLabel.text = data.modelName;
    self.detailLabel.text = data.note;
}

@end
