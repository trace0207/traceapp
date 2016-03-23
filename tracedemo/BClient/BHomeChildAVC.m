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


@interface BHomeChildAVC()
{
    
}
@end
@implementation BHomeChildAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.vm1.pullRefreshView];
    [self.vm1 tkUpdateViewConstraint];
    
}


-(void)loadData
{
    [self.vm1 startPullDownRefreshing];
}



-(TKIRewardVM *)vm1
{
    if(!_vm1)
    {
        _vm1 = [[TKIRewardVM alloc] initWithFreshAbleTable];
    }
    return _vm1;
}


-(void)dealloc
{
    _vm1 = nil;
}
@end
