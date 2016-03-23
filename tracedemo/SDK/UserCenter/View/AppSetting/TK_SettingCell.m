//
//  TK_SettingCell.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/10.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_SettingCell.h"

//const NSInteger kLeftLabelTag = 9901;
//const NSInteger kRightLabelTag = 9902;
//const NSInteger kLeftImageIconTag = 9911;
//const NSInteger kRightImageViewTag = 9911;
//const NSInteger kRightSwitchTag = 9921;


const NSInteger kLebel1 = 9901;
const NSInteger kLebel2 = 9902;
const NSInteger kLebel3 = 9903;
const NSInteger kLebel4 = 9904;

const NSInteger kImage1 = 9911;
const NSInteger kImage2 = 9912;
const NSInteger kImage3 = 9913;

const NSInteger kHeadImage = 9900;
const NSInteger kSwitch = 9910;



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
 加载 中间 大图片的  cell
 **/
+(TK_SettingCell *)loadCenterImageType:(id)ower
{
     return   [[[NSBundle mainBundle]loadNibNamed:@"TK_SettingCell" owner:ower options:nil]objectAtIndex:5];
}


/**
 
 加载左边大图片的  cell
 
 **/
+(TK_SettingCell *)loadLeftImageViewType:(id)ower
{
    return  [[[NSBundle mainBundle]loadNibNamed:@"TK_SettingCell" owner:ower options:nil]objectAtIndex:4];
}


/**
 开关 item
 **/
+(TK_SettingCell *)loadSwitchType:(id)ower
{
    return  [[[NSBundle mainBundle]loadNibNamed:@"TK_SettingCell" owner:ower options:nil]objectAtIndex:3];
}

+(TK_SettingCell *)loadNoImageSwitchType:(id)ower
{
    return  [[[NSBundle mainBundle]loadNibNamed:@"TK_SettingCell" owner:ower options:nil]objectAtIndex:6];
}

//@property (nonatomic,strong)UILabel * leftLabel;
//@property (nonatomic,strong)UILabel * rightLabel;
//@property (nonatomic,strong)UIImageView * rightHeadImageView;
//@property (nonatomic,strong)UISwitch * rightSwitch;
//@property (nonatomic,strong)UIImageView * leftImageIcon;

//-(UILabel *)leftLabel{
//
//    if(!_leftLabel)
//    {
//        _leftLabel = [self viewWithTag:kLeftLabelTag];
//    }
//    return _leftLabel;
//}
//
//-(UILabel *)rightLabel{
//    
//    if(!_rightLabel)
//    {
//        _rightLabel = [self viewWithTag:kRightLabelTag];
//    }
//    return _rightLabel;
//}
//
//-(UIImageView *)rightHeadImageView
//{
//    if(!_rightHeadImageView)
//    {
//        _rightHeadImageView = [self viewWithTag:kRightImageViewTag];
//    }
//    return _rightHeadImageView;
//}

//
//-(UIImageView *)leftHeadImageView
//{
//    if(!_rightHeadImageView)
//    {
//        _rightHeadImageView = [self viewWithTag:kRightImageViewTag];
//    }
//    return _rightHeadImageView;
//}
//
//
//-(UIImageView *)leftImageIcon
//{
//    if(!_leftImageIcon)
//    {
//        _leftImageIcon = [self viewWithTag:kLeftImageIconTag];
//    }
//    return _leftImageIcon;
//}
//
//-(UISwitch *)rightSwitch
//{
//
//    if(!_rightSwitch)
//    {
//        _rightSwitch = [self viewWithTag:kRightSwitchTag];
//    }
//    return _rightSwitch;
//}




-(UILabel *)label1
{
    if(!_label1)
    {
        _label1 = [self viewWithTag:kLebel1];
    }
    return _label1;
}

-(UILabel *)label2
{
    if(!_label2)
    {
        _label2 = [self viewWithTag:kLebel2];
        _label2.textColor = [UIColor hexChangeFloat:@"666666"];
    }
    return _label2;
}

-(UILabel *)label3
{
    if(!_label3)
    {
        _label3 = [self viewWithTag:kLebel3];
    }
    return _label3;
}

-(UILabel *)label4
{
    if(!_label4)
    {
        _label4 = [self viewWithTag:kLebel4];
    }
    return _label4;
}


-(UIImageView *)icon1
{
    if(!_icon1)
    {
        _icon1 = [self viewWithTag:kImage1];
    }
    return _icon1;
}

-(UIImageView *)icon2
{
    if(!_icon2)
    {
        _icon2 = [self viewWithTag:kImage2];
    }
    return _icon2;
}

-(UIImageView *)icon3
{
    if(!_icon3)
    {
        _icon3 = [self viewWithTag:kImage3];
    }
    return _icon3;
}

-(UISwitch *)switchView
{
    if(!_switchView)
    {
        _switchView = [self viewWithTag:kSwitch];
    }
    return _switchView;
}

-(TKHeadImageView *)headImage
{
    if(!_headImage)
    {
        _headImage = [self viewWithTag:kHeadImage];
    }
    return _headImage;
}


@end
