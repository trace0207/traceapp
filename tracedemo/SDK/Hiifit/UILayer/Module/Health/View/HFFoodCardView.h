//
//  HFFoodCardView.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GetFoodsByMealData;

@protocol HFFoodCardViewDelegate <NSObject>

/**
 *  推送到Meal的类型
 *
 *  @param mealType mealType
 */
- (void)pushMealsDetail:(NSInteger)mealType;

@end

@interface HFFoodCardView : UIView

@property(nonatomic,weak)id<HFFoodCardViewDelegate>delegate;

- (void)setContentData:(GetFoodsByMealData *)data atHistory:(BOOL)histroy;

@end
