//
//  AbountViewController.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/20.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "AbountViewController.h"
#import "TKWebViewController.h"

@interface AbountViewController ()

@end

@implementation AbountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKaddNavigationTitle:@"关于"];
}

- (IBAction)attentionAction:(id)sender {
    
    [TKWebViewController showWebView:@"" url:ServerAttentionURL];
    
}
@end
