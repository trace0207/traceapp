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
    // Do any additional setup after loading the view.
    
    vm = [[TKIMessageCenterVM alloc]initFreshAbleTableWithFrame:CGRectMake(0, 0, TKScreenWidth, TKScreenHeight - 64 - 49)];
    [self.view addSubview:vm.pullRefreshView];
  
    [vm tkLoadDefaultData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [vm startPullDownRefreshing];
//    [vm tkUpdateViewConstraint];
}

@end
