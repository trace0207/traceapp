//
//  RankViewCell.h
//  GuanHealth
//
//  Created by hermit on 15/5/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UploadGameData.h"
#import "BaseTableCell.h"
@interface RankViewCell : BaseTableCell

@property (nonatomic, weak) IBOutlet UIImageView *rankImage;
@property (nonatomic, weak) IBOutlet UIImageView *headImage;
@property (nonatomic, weak) IBOutlet UILabel     *rankLabel;
@property (nonatomic, weak) IBOutlet UILabel     *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel     *timeLabel;

- (void)setContentToCell:(UploadGameData*)data;

@end
