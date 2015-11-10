//
//  MainViewController.h
//  GuanHealth
//
//  Created by hermit on 15/2/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonItem.h"
#import "HFHabitHeaderCell.h"

//首页的组织架构
typedef NS_ENUM(NSInteger, cellOrderList) {
    HFMainCellOrder_Banner = 0,
    HFMainCellOrder_Habit,
  //  HFMainCellOrder_PrimaryScheme,
    HFMainCellOrder_AdvanceScheme,
    HFMainCellOrder_Post,
};

@interface MainViewController : UIViewController

@property (nonatomic,   weak) IBOutlet UILabel                *bgLabel;
@property (nonatomic,   weak) IBOutlet UITableView            *tableView;
@property (nonatomic, strong)          HFHabitHeaderCell      *habitHeader;
@property (nonatomic, assign)          NSInteger              currentIndex;

@end
