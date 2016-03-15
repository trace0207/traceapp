//
//  BHomePageViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 16/2/18.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "CHomePageViewController.h"
#import "BHomeChildAVC.h"
#import "BPageViewController.h"
#import "KTDropdownMenuView.h"
#import "UIColor+TK_Color.h"
@interface CHomePageViewController ()<HFSegmentViewDelegate>

@property (nonatomic,strong)BPageViewController * vc1;
@property (nonatomic,strong)BPageViewController * vc2;

@end

@implementation CHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hidDefaultBackBtn = YES;
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKaddNavigationTitleView:self.mSegView];
}

-(void)initView
{
    [self addChildViewController:self.vc1];
    [self addChildViewController:self.vc2];
    [self.view addSubview:self.vc1.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

- (void)selectSegmentIndex:(NSInteger)index
{
    if (index == 0)
    {
        [self transitionFromViewController:self.vc2 toViewController:self.vc1 duration:0.5 options:UIViewAnimationOptionCurveLinear animations:nil completion:^(BOOL finished) {
        }];
    }
    else
    {
        [self transitionFromViewController:self.vc1 toViewController:self.vc2 duration:0.5 options:UIViewAnimationOptionCurveLinear animations:nil completion:^(BOOL finished) {
            
            
        }];
    }
}

- (HFSegmentView *)mSegView
{
    if (!_mSegView)
    {
        _mSegView = [[HFSegmentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth == 320.f?130:167, 30)];
        _mSegView.textFont = kScreenWidth == 320?[UIFont systemFontOfSize:15]:[UIFont systemFontOfSize:17];
        _mSegView.delegate = self;
        [_mSegView setSegmentTitles:@[@"嗮单池",@"悬赏池"]];
    }
    return _mSegView;
}


-(BPageViewController *)vc2
{
    if(!_vc2)
    {
        _vc2 = [[BPageViewController alloc] init];
        _vc2.tabViewRightSpace = 90;
        _vc2.indicatorColor = [UIColor tkThemeColor1];
        _vc2.tabsViewBackgroundColor = [UIColor tkThemeColor2];
        _vc2.view.backgroundColor = [UIColor tkThemeColor2];
    }
    return _vc2;
}

-(BPageViewController *)vc1
{
    if(!_vc1)
    {
        _vc1 = [[BPageViewController alloc] init];
        _vc1.tabViewRightSpace = 90;
        _vc1.indicatorColor = [UIColor tkThemeColor1];
        _vc1.tabsViewBackgroundColor = [UIColor tkThemeColor2];
        _vc1.view.backgroundColor = [UIColor tkThemeColor2];
    }
    return _vc1;
}

@end
