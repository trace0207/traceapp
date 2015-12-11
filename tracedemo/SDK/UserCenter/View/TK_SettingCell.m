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
const NSInteger kRightSwitchTag = 9905;


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


+(TK_SettingCell *)loadDefaultTextWithLeftIconType:(id)ower
{
    return  [[[NSBundle mainBundle]loadNibNamed:@"TK_SettingCell" owner:ower options:nil]objectAtIndex:1];
}


+(TK_SettingCell *)loadRightImageViewType:(id)ower
{
    return  [[[NSBundle mainBundle]loadNibNamed:@"TK_SettingCell" owner:ower options:nil]objectAtIndex:2];
}


/**
 开关 item
 **/
+(TK_SettingCell *)loadSwitchType:(id)ower
{
    return  [[[NSBundle mainBundle]loadNibNamed:@"TK_SettingCell" owner:ower options:nil]objectAtIndex:3];
}



//@property (nonatomic,strong)UILabel * leftLabel;
//@property (nonatomic,strong)UILabel * rightLabel;
//@property (nonatomic,strong)UIImageView * rightHeadImageView;
//@property (nonatomic,strong)UISwitch * rightSwitch;
//@property (nonatomic,strong)UIImageView * leftImageIcon;

-(UILabel *)leftLabel{

    if(!_leftLabel)
    {
        _leftLabel = [self viewWithTag:kLeftLabelTag];
    }
    return _leftLabel;
}

-(UILabel *)rightLabel{
    
    if(!_rightLabel)
    {
        _rightLabel = [self viewWithTag:kRightLabelTag];
    }
    return _rightLabel;
}

-(UIImageView *)rightHeadImageView
{
    if(!_rightHeadImageView)
    {
        _rightHeadImageView = [self viewWithTag:kRightImageViewTag];
    }
    return _rightHeadImageView;
}
-(UIImageView *)leftImageIcon
{
    if(!_leftImageIcon)
    {
        _leftImageIcon = [self viewWithTag:kLeftImageIconTag];
    }
    return _leftImageIcon;
}

-(UISwitch *)rightSwitch
{

    if(!_rightSwitch)
    {
        _rightSwitch = [self viewWithTag:kRightSwitchTag];
    }
    return _rightSwitch;
}


@end
