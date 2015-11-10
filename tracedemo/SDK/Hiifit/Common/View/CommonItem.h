//
//  HabitItem.h
//  GuanHealth
//
//  Created by hermit on 15/4/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HabitList.h"
#import "ModelData.h"
#import "HFHabitAlarmClockRes.h"

#define kConItems   5
#define ItemWidth   kScreenWidth/kConItems

@class CommonItem;

@protocol HabitEdit <NSObject>
@optional
- (void)removeHabitItem:(CommonItem*)item  withTag:(NSInteger)tag;
- (void)chooseHabitItem:(CommonItem*)item  withTag:(NSInteger)tag;

@end

@interface CommonItem : UIView

@property (nonatomic, strong) UIImageView   *iconImageView;
@property (nonatomic, strong) UILabel       *textLabel;
@property (nonatomic, strong) UIButton      *chooseBtn;
@property (nonatomic, strong) UIButton      *cancelBtn;
@property (nonatomic, strong) UIImageView   *finishImage;
@property (nonatomic, assign) NSInteger     itemId;
@property (nonatomic, strong) id            data;

@property (nonatomic,   weak) id<HabitEdit> delegate;

- (void)setContentToCell:(id)data;

- (void)setActive:(BOOL)active;

@end