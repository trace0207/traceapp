//
//  CPublishRewardViewController.m
//  tracedemo
//
//  Created by cmcc on 16/3/9.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "CPublishRewardViewController.h"
#import "UIColor+TK_Color.h"

@interface CPublishRewardViewController ()

@end

@implementation CPublishRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    // Do any additional setup after loading the view from its nib.
}


-(void)initView
{
    self.hidDefaultBackBtn = YES;
    self.navTitle = @"发布悬赏";
    [self.mainScrollView setContentSize:CGSizeMake(TKScreenWidth, TKScreenHeight)];
    [self.mainScrollView addSubview:self.mainView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKsetLeftBarItemText:@"取消" withTextColor:[UIColor tkThemeColor1] addTarget:self action:@selector(TKI_leftBarAction) forControlEvents:UIControlEventTouchUpInside];
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


-(void)TKI_leftBarAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelAction:(UIButton *)sender {
    
    [self TKI_leftBarAction];
    
}
@end
