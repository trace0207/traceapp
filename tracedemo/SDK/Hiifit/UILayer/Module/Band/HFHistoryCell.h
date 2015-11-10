//
//  HFHistoryTableViewCell.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/8.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BandHistoryData;
@interface HFHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *caloriesLabel;

- (void)setContent:(BandHistoryData *)data;

@end
