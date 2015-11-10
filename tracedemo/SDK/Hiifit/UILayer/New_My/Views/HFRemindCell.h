//
//  HFRemindCell.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/29.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  HFRemindCell;

@protocol HFRemindCellDelegate <NSObject>

- (void)switchState:(BOOL)state AtCell:(HFRemindCell *)cell;

@end


@interface HFRemindCell : BaseTableCell

@property (weak, nonatomic) IBOutlet UILabel *remindNameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, weak)id<HFRemindCellDelegate>delegate;

@end
