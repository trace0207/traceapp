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



+(void)showUserPage:(NSString *)userId isBuyer:(BOOL)isBuyer
{
    TKBuyerCenterViewController * bvc = [[TKBuyerCenterViewController alloc] init];
    bvc.isBuyer = isBuyer;
    [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
    if(self.isBuyer)
    {
        
        self.navTitle = @"买手主页";
    }else
    {
        self.navTitle = @"消费者主页";
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


-(void)initView
{
    vm = [[TKBuyerCenterVM alloc] initWithFreshAbleTable];
    vm.isBuyer = self.isBuyer;
    [self.view addSubview:vm.pullRefreshView];
    [vm tkUpdateViewConstraint];
    [vm startPullDownRefreshing];
}

@end
