//
//  HFEditInfoCell.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/26.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFEditInfoCell.h"

@implementation HFEditInfoCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.signLabel.numberOfLines = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
