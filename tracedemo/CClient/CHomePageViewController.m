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
#import "TKPayChooseView.h"
@interface CHomePageViewController ()
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic,strong)BPageViewController * vc1;
@property (nonatomic,strong)BPageViewController * vc2;
@property (nonatomic, strong)TKPayChooseView *payView;
@end

@implementation CHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.hidDefaultBackBtn = YES;
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKaddNavigationTitleView:self.segmentedControl];
        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
        [bt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [bt setTitle:@"支付" forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
        [self addLeftBarItemWithCustomView:bt];
}

-(void)initView
{
    [self addChildViewController:self.vc1];
    [self addChildViewController:self.vc2];
    [self.view addSubview:self.vc1.view];
    self.vc2.view.frame = CGRectMake(0, 0, TKScreenWidth, TKScreenHeight - 49 -20 - 44);
}
-(void)test
{
    self.payView.money = 1200;
    [self.payView show];
}
- (TKPayChooseView *)payView
{
    if (_payView == nil) {
        _payView = [[TKPayChooseView alloc]initWithPayType:PayTypeAll];
    }
    return _payView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}


- (UISegmentedControl *)segmentedControl
{
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"嗮单池",@"悬赏池"]];
        _segmentedControl.frame = CGRectMake(0, 0, 150, 30);
        _segmentedControl.selectedSegmentIndex = 0;
        [_segmentedControl addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _segmentedControl;
}
- (void)segmentedAction:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        [self addRightBarItemWithCustomView:nil];
        [self transitionFromViewController:self.vc2 toViewController:self.vc1 duration:0.5 options:UIViewAnimationOptionCurveLinear animations:nil completion:^(BOOL finished) {
        }];
    }else {
        [self transitionFromViewController:self.vc1 toViewController:self.vc2 duration:0.5 options:UIViewAnimationOptionCurveLinear animations:nil completion:^(BOOL finished) {
            
            
        }];
    }
}

-(BPageViewController *)vc2
{
    if(!_vc2)
    {
        _vc2 = [[BPageViewController alloc] init];
        _vc2.tabViewRightSpace = 90;
        _vc2.indicatorColor = [UIColor tkThemeColor1];
        _vc2.tabsViewBackgroundColor = [UIColor hexChangeFloat:TK_Color_nav_background];
        _vc2.view.backgroundColor = [UIColor tkThemeColor2];
        _vc2.dataType = C_AllReward;
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
        _vc1.tabsViewBackgroundColor = [UIColor hexChangeFloat:TK_Color_nav_background];
        _vc1.view.backgroundColor = [UIColor tkThemeColor2];
        _vc1.dataType = C_showGoods;
    }
    return _vc1;
}

@end
