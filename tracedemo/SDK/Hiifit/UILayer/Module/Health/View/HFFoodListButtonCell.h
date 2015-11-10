//
//  HFFoodListButtonCell.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFFoodListButtonCellDelegate <NSObject>

- (void)nextDayAction;

@end

@interface HFFoodListButtonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *foodListBtn;
@property(nonatomic,weak)id<HFFoodListButtonCellDelegate>delegate;

- (IBAction)watchNextAction:(UIButton *)sender;

@end
