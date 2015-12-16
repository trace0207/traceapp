//
//  TKICommentViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/16.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKICommentViewController.h"
#import "UIColor+TK_Color.h"

@interface TKICommentViewController ()

@end

@implementation TKICommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"发表评论";
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self TKsetRightBarItemText:@"发表" withTextColor:[UIColor tkMainActiveColor] addTarget:self  action:@selector(tkPublish) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tkPublish
{
    [[AppDelegate getMainNavigation] popViewControllerAnimated:YES];
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
