//
//  MainTableViewCell.h
//  GuanHealth
//
//  Created by hermit on 15/2/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"
#import "Data.h"
#import "ActivitiesData.h"

@protocol MainCellDelegate <NSObject>
@optional
- (void)goUserHomePage:(int)userId;
@end

@interface MainTableViewCell : BaseTableCell

@property (weak, nonatomic) IBOutlet UILabel        *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel        *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *headImageView;
@property (weak, nonatomic) IBOutlet UIButton       *userBtn;

@property (weak, nonatomic) id<MainCellDelegate>delegate;

- (void)setContentToCell:(id)data;

@end
