//
//  FriendsCell.m
//  GuanHealth
//
//  Created by hermit on 15/4/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "FriendsCell.h"

@implementation FriendsCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.followBtn setBackgroundImage:[UIImage imageNamed:@"interested"] forState:UIControlStateNormal];
    [self.followBtn setBackgroundImage:[UIImage imageNamed:@"interest"] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    // Configure the view for the selected state
}

- (void)setValueToCell:(FriendsData *)data
{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:data.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
    [self.nameLabel setText:data.nickName];
    if (data.status) {
        self.followBtn.selected = NO;
    }else{
        self.followBtn.selected = YES;
    }
}

@end
