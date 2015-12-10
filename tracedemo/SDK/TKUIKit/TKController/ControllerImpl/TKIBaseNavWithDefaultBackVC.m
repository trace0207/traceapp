//
//  TKIBaseNavWithDefaultBackVC.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/20.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"
#import "UIColor+TK_Color.h"

@interface TKIBaseNavWithDefaultBackVC ()

@end

@implementation TKIBaseNavWithDefaultBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor tkMainBackgroundColor];
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear: animated];
    if(!self.hidDefaultBackBtn)
    {
        [self TKI_setBarDefaultLeftBack];
    }else
    {
        [self.navigationController.navigationItem setHidesBackButton:YES];
    }
    NSString * title = self.navTitle;
    if(title != nil && title.length >0){
        [self TKaddNavigationTitle:title];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)hidDefaultBackBtn
{
    return _hidDefaultBackBtn;
}

@end
