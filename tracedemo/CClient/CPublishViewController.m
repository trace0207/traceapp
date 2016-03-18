//
//  CPublishViewController.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/16.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "CPublishViewController.h"

@interface CPublishViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation CPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"发布悬赏"];
    [self addLeftBarItemWithTitle:@"取消"];
    [self addRightBarItemWithTitle:@"发布"];
}

- (void)leftBarItemAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.alwaysBounceVertical = YES;
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return  _scrollView;
}

@end
