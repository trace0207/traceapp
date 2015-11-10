//
//  HFActivityListCell.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HFActivityListData;
@interface HFActivityListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *activityBgImageView;
@property (weak, nonatomic) IBOutlet UILabel *activityName;
@property (weak, nonatomic) IBOutlet UILabel *activiInfo;
@property (weak, nonatomic) IBOutlet UIImageView *stautsImage;

- (void)setContentCell:(HFActivityListData *)data;

@end
