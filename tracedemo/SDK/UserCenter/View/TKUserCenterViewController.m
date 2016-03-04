//
//  TKUserCenterViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/31.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKUserCenterViewController.h"
#import "TK_UserCenterVM.h"
#if B_Client == 1
#import "BUserCenterVM.h"
#endif

@interface TKUserCenterViewController ()
{
    TK_UserCenterVM * vm;
}

@end

@implementation TKUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidDefaultBackBtn = YES;
#if B_Client == 1
    vm = [[BUserCenterVM alloc] initDefaultTableWithFrame:CGRectMake(0, 0, TKScreenWidth, TKScreenHeight - 64 - 49)];
#else
    vm = [[TK_UserCenterVM alloc] initDefaultTableWithFrame:CGRectMake(0, 0, TKScreenWidth, TKScreenHeight - 64 - 49)];
#endif
    [self.view addSubview:vm.mTableView];
    [vm tkLoadDefaultData];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKaddNavigationTitle:@"我"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
