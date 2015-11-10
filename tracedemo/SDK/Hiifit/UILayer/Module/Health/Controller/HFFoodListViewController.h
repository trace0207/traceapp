//
//  HFFoodListViewController.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKPicSelectViewController.h"

@protocol HFFoodListViewControllerDelegate <NSObject>

- (void)uploadFoodInfo;

@end


typedef NS_ENUM(NSInteger, dayFoodType) {
    Yesterday_Food_Type = 0,
    Today_Food_Type,
    Tommorrow_Food_Type,
};


@class HFTitleBar;
@interface HFFoodListViewController : TKPicSelectViewController

@property (nonatomic, assign) BOOL needShowGuideView;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet HFTitleBar *mTitleBar;
@property (weak, nonatomic)id<HFFoodListViewControllerDelegate>delegate;
@property(nonatomic)NSInteger  mCurrentDay;
@property(nonatomic)NSInteger  mMealType;
@property (nonatomic, assign) NSInteger isSubscribe;
- (instancetype)initWithAtToady:(dayFoodType)type preViewNextBtn:(BOOL)bHas;
@end
