//
//  HFAboutUsTableViewCell.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/28.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFAboutUsTableViewCell.h"

@implementation HFAboutUsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
