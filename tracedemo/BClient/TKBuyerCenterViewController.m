//
//  TKBuyerCenterViewController.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/31.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKBuyerCenterViewController.h"
#import "TKBuyerCenterVM.h"

@interface TKBuyerCenterViewController ()
{
    TKBuyerCenterVM * vm;
}
@end

@implementation TKBuyerCenterViewController



+(void)showUserPage:(NSString *)userId
{
    TKBuyerCenterViewController * bvc = [[TKBuyerCenterViewController alloc] init];
    [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKaddNavigationTitle:@"买手主页"];
}


-(void)initView
{
    vm = [[TKBuyerCenterVM alloc] initWithFreshAbleTable];
    [self.view addSubview:vm.pullRefreshView];
    [vm tkUpdateViewConstraint];
    [vm startPullDownRefreshing];
}

@end
