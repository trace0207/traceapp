//
//  TKSHowGoodsDetailPageVC.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/16.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKSHowGoodsDetailPageVC.h"
#import "TKIShowGoodsDetailVM.h"

@interface TKSHowGoodsDetailPageVC ()
{
    TKIShowGoodsDetailVM * tableVM;
}

@end

@implementation TKSHowGoodsDetailPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"晒单详情";
    
    tableVM = [[TKIShowGoodsDetailVM alloc] initWithFreshAbleTable];
    [self.view addSubview:tableVM.pullRefreshView];
    [tableVM tkUpdateViewConstraint];
    self.view.backgroundColor = [UIColor redColor];
    [tableVM tkLoadDefaultData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
