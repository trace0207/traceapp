//
//  TKIBaseNavWithDefaultBackVC.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/20.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"

@interface TKIBaseNavWithDefaultBackVC ()

@end

@implementation TKIBaseNavWithDefaultBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear: animated];
    [self TKI_setBarDefaultLeftBack];
    NSString * title = [self TK_getBarTitle];
    if(title != nil && title.length >0){
        [self TKaddNavigationTitle:title];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString *)TK_getBarTitle{

    return @"";
}

@end
