//
//  BHomeChildAVC.m
//  tracedemo
//
//  Created by 罗田佳 on 16/2/18.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "BHomeChildAVC.h"
#import "BHomeChildAScrolBox.h"
#import "TKIShowGoodsVM.h"
#import "TKIRewardVM.h"

@interface BHomeChildAVC ()
{
    TKIRewardVM * vm1;
}
@end
@implementation BHomeChildAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    vm1 = [[TKIRewardVM alloc] initWithFreshAbleTable ];
    [self.view addSubview:vm1.pullRefreshView];
    [vm1 tkUpdateViewConstraint];
    [vm1 startPullDownRefreshing];
}
@end
