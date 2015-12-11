//
//  TK_SettingCell.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/10.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>


extern const NSInteger kLeftLabelTag;
extern const NSInteger kRightLabelTag;
extern const NSInteger kLeftImageIconTag;
extern const NSInteger kRightImageViewTag;
extern const NSInteger kRightSwitchTag;

@interface TK_SettingCell : UITableViewCell


@property (nonatomic,strong)UILabel * leftLabel;
@property (nonatomic,strong)UILabel * rightLabel;
@property (nonatomic,strong)UIImageView * rightHeadImageView;
@property (nonatomic,strong)UISwitch * rightSwitch;
@property (nonatomic,strong)UIImageView * leftImageIcon;





/**
 
 加载默认的 左右 textlabel样式的 lebel
 
 **/
+(TK_SettingCell *)loadDefaultTextType:(id)ower;


/**
 加载默认的 带左边icon的 布局
 **/
+(TK_SettingCell *)loadDefaultTextWithLeftIconType:(id)ower;

/**
 
 加载 右边 大图片的  cell 
 
 **/
+(TK_SettingCell *)loadRightImageViewType:(id)ower;


/**
 开关 item
 **/
+(TK_SettingCell *)loadSwitchType:(id)ower;


@end
