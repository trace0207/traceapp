//
//  HFHabitViewController.h
//  GuanHealth
//
//  Created by hermit on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"

@interface HFHabitViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) UIView      *headerView;

@end
