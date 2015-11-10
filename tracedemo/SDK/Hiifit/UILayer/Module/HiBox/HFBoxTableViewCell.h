//
//  HFBoxTableViewCell.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/29.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiModuleListData.h"

@interface HFBoxTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *headImageView;
@property (nonatomic, weak) IBOutlet UILabel     *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel     *detailLabel;

- (void)setContentToCell:(HiModuleListData *)data;

@end
