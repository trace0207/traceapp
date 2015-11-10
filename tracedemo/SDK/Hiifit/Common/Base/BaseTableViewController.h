//
//  BaseTableViewController.h
//  rentCar
//
//  Created by duonuo on 14-6-26.
//  Copyright (c) 2014年 duonuo. All rights reserved.
//

#import "BaseViewController.h"
#import "CLLRefreshHeadController.h"
@interface BaseTableViewController : BaseViewController<CLLRefreshHeadControllerDelegate>

@property (nonatomic,   weak) IBOutlet UITableView               *tableView;
@property (nonatomic, strong)          NSMutableArray            *dataSource;
@property (nonatomic, strong)          CLLRefreshHeadController  *refreshController;

@end
