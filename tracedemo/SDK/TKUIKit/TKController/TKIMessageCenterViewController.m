//
//  TKIMessageCenterViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/15.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKIMessageCenterViewController.h"
#import "TKIMessageCenterVM.h"

@interface TKIMessageCenterViewController ()
{
    TKIMessageCenterVM * vm;
}

@end

@implementation TKIMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    vm = [[TKIMessageCenterVM alloc]initFreshAbleTableWithFrame:CGRectMake(0, 0, TKScreenWidth, TKScreenHeight - 64 - 49)];
    [self.view addSubview:vm.pullRefreshView];
  
    [vm tkLoadDefaultData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

@end
