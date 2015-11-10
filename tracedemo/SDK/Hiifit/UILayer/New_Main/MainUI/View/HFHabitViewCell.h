//
//  TableViewCell.h
//  GuanHealth
//
//  Created by hermit on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFHabitListRes.h"
#import "BaseTableCell.h"
@protocol HFHabitViewCellDelegate <NSObject>

- (void)addNewHabit;

@end

@interface HFHabitViewCell : BaseTableCell

@property (nonatomic, weak) IBOutlet BasePortraitView *headImage;
@property (nonatomic, weak) IBOutlet UIImageView *clockImage;
@property (nonatomic, weak) IBOutlet UILabel *habitLabel;
@property (nonatomic, weak) IBOutlet UILabel *peopleNumLabel;
@property (nonatomic, weak) IBOutlet UILabel *finishedLabel;
@property (nonatomic, weak)id<HFHabitViewCellDelegate>delegate;

- (void)setContentToCell:(HFHabitListData *)habit;
- (IBAction)addHabitAction:(UIButton *)sender;

@end
