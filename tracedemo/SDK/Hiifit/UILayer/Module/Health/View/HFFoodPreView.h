//
//  HFFoodPreView.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GetUserDietaryMealCookListByDayData;

@protocol HFFoodPreViewDelegate <NSObject>

- (void)checkCalorieInfo:(NSInteger)corId;

@end


@interface HFFoodPreView : UIView

@property(nonatomic,weak)id<HFFoodPreViewDelegate> delegate;

- (void)setFoodViewData:(GetUserDietaryMealCookListByDayData *)data;

@end
