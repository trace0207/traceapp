//
//  TKSetPasswordViewController.m
//  tracedemo
//
//  Created by cmcc on 15/11/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKSetPasswordViewController.h"
#import "UIViewController+TKNavigationBarSetting.h"
#import "UIColor+TK_Color.h"

@interface TKSetPasswordViewController ()

@end

@implementation TKSetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{

    [self TKremoveLeftBarButtonItem];
    [self TKremoveNavigationTitle];
    UIColor * color  = [UIColor TKcolorWithHexString:TK_Color_nav_textActive];
    [self TKsetLeftBarItemText:@"返回"
                 withTextColor:color
                     addTarget:self action:@selector(cancelEvent) forControlEvents:UIControlEventTouchUpInside];
}

-(void)cancelEvent{

    [self.navigationController popViewControllerAnimated:YES];
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
