//
//  HFHabitHeaderCell.h
//  GuanHealth
//
//  Created by hermit on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HabitList.h"
#import "CommonItem.h"
#import "HFHabitAlarmClockRes.h"

#define kHabitWidth kScreenWidth/4.5f

@class HFHabitHeaderCell;

@protocol HabitHeaderDelegate <NSObject>

- (void)addActionWithCell:(HFHabitHeaderCell *)cell;//跳到添加（H5）
- (void)moreActionWithCell:(HFHabitHeaderCell *)cell;//查看更多
- (void)goDetailAction:(CommonItem *)item withCell:(HFHabitHeaderCell *)cell;//跳到习惯详情页面

@end

@interface HFHabitHeaderCell : UITableViewCell<HabitEdit>

@property (nonatomic, assign) HFItemType  itemType;
@property (nonatomic, assign) NSUInteger  habitsCount;
@property (nonatomic, strong) CommonItem *addItem;
@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) UIView       *separatorLine;
@property (nonatomic,   weak) id<HabitHeaderDelegate>delegate;

- (void)setHabitsToCell:(NSArray*)sources;

- (void)headerTitle:(NSString *)title;

@end
