//
//  TK_SettingCell.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/10.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKHeadImageView.h"


//extern const NSInteger kLeftLabelTag;
//extern const NSInteger kRightLabelTag;
//extern const NSInteger kLeftImageIconTag;
//extern const NSInteger kRightImageViewTag;
//extern const NSInteger kRightSwitchTag;

@interface TK_SettingCell : UITableViewCell


//@property (nonatomic,strong)UILabel * leftLabel;
//@property (nonatomic,strong)UILabel * rightLabel;
//@property (nonatomic,strong)TKHeadImageView * rightHeadImageView;
//@property (nonatomic,strong)TKHeadImageView * leftHeadImageView;
//@property (nonatomic,strong)UISwitch * rightSwitch;
//@property (nonatomic,strong)UIImageView * leftImageIcon;





// 从上到下 从左到右，依次排列
@property (nonatomic,strong)UILabel * label1;
@property (nonatomic,strong)UILabel * label2;
@property (nonatomic,strong)UILabel * label3;
@property (nonatomic,strong)UILabel * label4;

//头像 只会有一个
@property (nonatomic,strong)TKHeadImageView * headImage;

// icon 可能有多个
@property (nonatomic,strong)UIImageView * icon1;
@property (nonatomic,strong)UIImageView * icon2;
@property (nonatomic,strong)UIImageView * icon3;

//开关  只会有一个
@property (nonatomic,strong)UISwitch * switchView;

/**
 
 加载默认的 左右 textlabel样式的 label
 
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
 加载 中间 大图片的  cell
 **/
+(TK_SettingCell *)loadCenterImageType:(id)ower;


/**
 
 加载左边大图片的  cell
 
 **/
+(TK_SettingCell *)loadLeftImageViewType:(id)ower;


/**
 开关 item
 **/
+(TK_SettingCell *)loadSwitchType:(id)ower;


@end
