//
//  HFFoodPreScrollView.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFFoodPreScrollViewDelegate <NSObject>

- (void)pushToCalorieInfoView:(NSInteger)calID;

@end


@interface HFFoodPreScrollView : UIScrollView

@property(nonatomic,weak)id<HFFoodPreScrollViewDelegate>mDelegate;
- (void)setContentData:(NSArray *)datas;

@end
