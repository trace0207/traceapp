//
//  TKBuyerCenterViewController.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/31.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKBuyerCenterViewController.h"
#import "TKBuyerCenterVM.h"
#import "TKLoginViewController.h"
#import "TKUserCenter.h"
#import "CPublishRewardViewController.h"

@interface TKBuyerCenterViewController ()<TKShowGoodsVMDelegate,LoginDelegate>
{
    TKBuyerCenterVM * vm;
    TKIShowGoodsRowM *rowData; // 缓存的 item 数据，用户登录回来之后跳转
}
@end

@implementation TKBuyerCenterViewController



+(void)showUserPage:(NSString *)userId isBuyer:(BOOL)isBuyer
{
    TKBuyerCenterViewController * bvc = [[TKBuyerCenterViewController alloc] init];
    bvc.isBuyer = isBuyer;
    bvc.userId = userId;
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
    vm.userId = self.userId;
    vm.showGoodsDelegate = self;
    [self.view addSubview:vm.pullRefreshView];
    [vm tkUpdateViewConstraint];
    [vm startPullDownRefreshing];
}

-(void)onFollowAction:(TKIShowGoodsRowM *)row
{
    if(![TKUserCenter instance].isLogin)
    {
        rowData = row;
        [TKLoginViewController showLoginViewPage:self];
    }
    else
    {
        CPublishRewardViewController * vc = [[CPublishRewardViewController alloc] init];
        vc.showGoodsrowData = row;
        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        [[AppDelegate getMainNavigation] presentViewController:nvc animated:YES completion:nil];
    }

}

-(void)onLoginSuccess
{
    CPublishRewardViewController * vc = [[CPublishRewardViewController alloc] init];
    vc.showGoodsrowData = rowData;
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [[AppDelegate getMainNavigation] presentViewController:nvc animated:YES completion:nil];
    rowData = nil;
}

@end
