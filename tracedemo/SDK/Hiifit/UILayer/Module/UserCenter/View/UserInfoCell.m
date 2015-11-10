//
//  UserInfoCell.m
//  GuanHealth
//
//  Created by hermit on 15/5/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell

- (void)awakeFromNib {
    // Initialization code
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
    
    if([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [self setPreservesSuperviewLayoutMargins:NO];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
