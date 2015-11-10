//
//  HFHabitTimesListViewController.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseViewController.h"
#import "HFHabitListRes.h"

@interface HFHabitTimesListViewController : BaseViewController
{
    NSInteger mHabitId;
    
    NSString * mHabitName;
    
    NSString * mHabitHeadUrl;
}
@property(nonatomic)NSInteger mHabitId;
@property(nonatomic,copy)NSString * mHabitName;
@property(nonatomic,copy)NSString * mHabitHeadUrl;
@property(nonatomic)NSInteger  mSubcribeNum;
@end
