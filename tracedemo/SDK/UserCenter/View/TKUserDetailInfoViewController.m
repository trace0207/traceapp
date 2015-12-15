//
//  TKUserDetailInfoViewController.m
//  tracedemo
//
//  Created by cmcc on 15/12/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKUserDetailInfoViewController.h"
#import "TKUserDetailInfoTableVM.h"


@interface TKUserDetailInfoViewController()
{
    TKUserDetailInfoTableVM  * tableVM;
}

@end

@implementation TKUserDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self firstInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)firstInit
{
    tableVM = [[TKUserDetailInfoTableVM alloc]initWithDefaultTable];
    [self.view addSubview:tableVM.mTableView];
    [tableVM tkUpdateViewConstraint];
    
}

@end
