//
//  TK_SettingCell.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/10.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_SettingCell.h"

const NSInteger kLeftLabelTag = 9901;
const NSInteger kRightLabelTag = 9902;
const NSInteger kLeftImageIconTag = 9903;
const NSInteger kRightImageViewTag = 9904;


@implementation TK_SettingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(TK_SettingCell *)loadDefaultTextType:(id)ower
{
   return  [[[NSBundle mainBundle]loadNibNamed:@"TK_SettingCell" owner:ower options:nil]objectAtIndex:0];
}


+(TK_SettingCell *)loadRightImageViewType:(id)ower
{
    return  [[[NSBundle mainBundle]loadNibNamed:@"TK_SettingCell" owner:ower options:nil]objectAtIndex:2];
}


@end
