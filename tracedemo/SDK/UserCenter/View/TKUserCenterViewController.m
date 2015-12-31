//
//  TKUserCenterViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/31.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKUserCenterViewController.h"
#import "TK_UserCenterVM.h"

@interface TKUserCenterViewController ()
{
    TK_UserCenterVM * vm;
}

@end

@implementation TKUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidDefaultBackBtn = YES;
    
    vm = [[TK_UserCenterVM alloc] initDefaultTableWithFrame:CGRectMake(0, 0, TKScreenWidth, TKScreenHeight - 64 - 49)];
    [self.view addSubview:vm.mTableView];
    [vm tkLoadDefaultData];
    
    
    // Do any additional setup after loading the view.
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
