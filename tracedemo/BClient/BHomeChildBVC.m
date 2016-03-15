//
//  BHomeChildBVC.m
//  tracedemo
//
//  Created by 罗田佳 on 16/2/18.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "BHomeChildBVC.h"
#import "TKIRewardVM.h"

@interface BHomeChildBVC ()
{
    TKIRewardVM * vm;
}

@end

@implementation BHomeChildBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initContentView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initContentView
{
    vm = [[TKIRewardVM alloc] initWithFreshAbleTable];
    [self.contentView addSubview:vm.pullRefreshView];
    [vm tkUpdateViewConstraint];
    //[vm.mTableView setSeparatorColor:[UIColor clearColor]];
    [vm tkLoadDefaultData];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
