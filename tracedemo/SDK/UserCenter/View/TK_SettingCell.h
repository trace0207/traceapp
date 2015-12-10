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

@interface TK_SettingCell : UITableViewCell



/**
 
 加载默认的 左右 textlabel样式的 lebel
 
 **/
+(TK_SettingCell *)loadDefaultTextType:(id)ower;


/**
 
 加载 右边 大图片的  cell 
 
 **/
+(TK_SettingCell *)loadRightImageViewType:(id)ower;

@end
