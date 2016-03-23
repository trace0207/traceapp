//
//  TKUserCenterViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/31.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKUserCenterViewController.h"
#import "TK_UserCenterVM.h"
#import "UIColor+TK_Color.h"
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
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2.0f)];
    backView.backgroundColor = [UIColor hexChangeFloat:TK_Color_nav_background];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, kScreenHeight/2., 0));
    }];
    
#if B_Client == 1
    
    vm = [[BUserCenterVM alloc] initWithDefaultTable];
   
#else
    vm = [[TK_UserCenterVM alloc] initWithDefaultTable];
#endif
    [self.view addSubview:vm.mTableView];
    self.view.backgroundColor = [UIColor whiteColor];
    [vm tkLoadDefaultData];
     [vm tkUpdateViewConstraint];
    
//    [vm.mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
//    }];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
    [self TKaddNavigationTitle:@"我"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
