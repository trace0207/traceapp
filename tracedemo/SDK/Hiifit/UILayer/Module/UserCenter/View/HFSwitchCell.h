//
//  HFSwitchCell.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFSwitchCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *image;
@property (nonatomic, weak) IBOutlet UILabel     *titleLabel;
@property (nonatomic, weak) IBOutlet UISwitch    *msgSwitch;

@end
