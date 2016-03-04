//
//  BMyShowGoodsViewController.m
//  tracedemo
//
//  Created by cmcc on 16/3/3.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "BMyShowGoodsViewController.h"
#import "TKPublishShowGoodsVC.h"
#import "AppDelegate.h"
#import "TKShowGoodsListVM.h"

@interface BMyShowGoodsViewController ()
{
    TKShowGoodsListVM * vm;
}

@end

@implementation BMyShowGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidDefaultBackBtn = YES;
    [self initView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKaddNavigationTitle:@"我的晒单"];
    [self TKsetRightBarItemImage:IMG(@"tk_icon_camera_w") addTarget:self action:@selector(TKI_rightBarAction) forControlEvents:UIControlEventTouchUpInside];
}


-(void)initView
{
    vm = [[TKShowGoodsListVM alloc] initWithFreshAbleTable];
    [self.view addSubview:vm.pullRefreshView];
    [vm tkUpdateViewConstraint];
    [vm startPullDownRefreshing];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)TKI_rightBarAction
{
    TKPublishShowGoodsVC *vc = [[TKPublishShowGoodsVC alloc] init];
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
}

@end
