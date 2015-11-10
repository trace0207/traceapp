//
//  HFFoodPreScrollView.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFFoodPreScrollView.h"
#import "HFFoodPreView.h"
#import "GetUserDietaryByDayAck.h"
#define FoodPreTag  100

@interface HFFoodPreScrollView()<HFFoodPreViewDelegate>
{
    NSInteger  mIndex;
}
@end

@implementation HFFoodPreScrollView

- (void)setContentData:(NSArray *)datas
{
    for (id obj in self.subviews)
    {
        if ([obj isKindOfClass:[HFFoodPreView class]])
        {
            HFFoodPreView * foodView = (HFFoodPreView *)obj;
            [foodView removeFromSuperview];
        }
    }
    
    NSInteger counts = [datas count];
    for (int i = 0; i < counts; i++)
    {
        HFFoodPreView * foodView = (HFFoodPreView *)[self viewWithTag:FoodPreTag + i];
        
        GetUserDietaryMealCookListByDayData * data = [datas objectAtIndex:i];
        
        if (!foodView)
        {
            foodView = [[HFFoodPreView alloc] init];
            foodView.tag = FoodPreTag + i;
            foodView.delegate = self;
            foodView.frame = CGRectMake(i * (150 + 15), 10, 150, 140);
            [foodView setFoodViewData:data];
            [self addSubview:foodView];
        }
        else
        {
            foodView.hidden = NO;
            [foodView setFoodViewData:data];
        }
        
    }
    
//    BOOL bOut = NO;
//    
//    while (!bOut)
//    {
//        HFFoodPreView * foodView = (HFFoodPreView *)[self viewWithTag:FoodPreTag + counts];
//        
//        if (!foodView)
//        {
//            bOut = YES;
//        }
//        else
//        {
//            foodView.hidden = YES;
//            counts++;
//        }
//    }
    
    
    mIndex = [datas count];
    
    //考虑到重用问题
    [self setContentSize:CGSizeMake(165 * mIndex - 15, 130)];
    
}

#pragma mark -
#pragma mark HFFoodPreViewDelegate
- (void)checkCalorieInfo:(NSInteger)corId
{
    if (_mDelegate && [_mDelegate respondsToSelector:@selector(pushToCalorieInfoView:)])
    {
        [_mDelegate pushToCalorieInfoView:corId];
    }
}


@end
