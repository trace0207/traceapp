//
//  HFFoodListCell.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GetUserDietaryMealByDayData;
@class HFFoodListCell;

typedef NS_ENUM(NSInteger, foodCellState) {
    PreviewState = 0,
    PreviewNOBtnState,
    FinishState,
    UnFinishState,
    unKnowState,
};

typedef NS_ENUM(NSInteger, cellPhotoState) {
    eat_Finish_State = 0,
    eat_Other_State,
};

@protocol HFFoodListCellDelegate <NSObject>

- (void)cellPhotoAction:(cellPhotoState)state atCell:(HFFoodListCell *)cell;


- (void)pushCalorieDetailViewAction:(NSInteger)calorieID;

@end



@interface HFFoodListCell : UITableViewCell

@property(nonatomic,weak)id<HFFoodListCellDelegate>delegate;

- (void)setcontentData:(GetUserDietaryMealByDayData *)data withFoodstate:(foodCellState)state atTodoy:(BOOL)bToday;

@end
