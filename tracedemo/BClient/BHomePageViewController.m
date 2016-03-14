//
//  BHomePageViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 16/2/18.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "BHomePageViewController.h"
#import "BHomeChildAVC.h"
#import "BPageViewController.h"
#import "KTDropdownMenuView.h"
#import "UIColor+TK_Color.h"
@interface BHomePageViewController ()<HFSegmentViewDelegate>

@property (nonatomic,strong)BPageViewController * vc1;
@property (nonatomic,strong)BPageViewController * vc2;
@property (nonatomic,strong)KTDropdownMenuView *menuView;

@end

@implementation BHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hidDefaultBackBtn = YES;
    [self initView];
}

- (KTDropdownMenuView *)menuView
{
    if (_menuView == nil) {
         NSArray *titles = @[@"悬赏中", @"已释放悬赏"];
        _menuView = [[KTDropdownMenuView alloc] initWithFrame:CGRectMake(0, 0,80, 44) titles:titles];
        _menuView.cellColor = [UIColor clearColor];
        _menuView.cellSeparatorColor = [UIColor lightGrayColor];
        _menuView.selectedAtIndex = ^(int index)
        {
            NSLog(@"selected title:%@", titles[index]);
        };
        _menuView.textFont = [UIFont systemFontOfSize:15];
        _menuView.backgroundAlpha = 0.0f;
        _menuView.width = 133;
        _menuView.edgesRight = -10;
        _menuView.textColor = [UIColor TKcolorWithHexString:TK_Color_nav_textDefault];
        _menuView.cellAccessoryCheckmarkColor = [UIColor TKcolorWithHexString:TK_Color_nav_textDefault];
    }
    return _menuView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKaddNavigationTitleView:self.mSegView];
    if (self.mSegView.currentIndex == 1) {
        [self addRightBarItemWithCustomView:self.menuView];
    }
}

-(void)initView
{
    [self addChildViewController:self.vc1];
    [self addChildViewController:self.vc2];
    [self.view addSubview:self.vc2.view];
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
        [self addRightBarItemWithCustomView:nil];
        [self transitionFromViewController:self.vc2 toViewController:self.vc1 duration:0.5 options:UIViewAnimationOptionCurveLinear animations:nil completion:^(BOOL finished) {
        }];
    }
    else
    {
        [self addRightBarItemWithCustomView:self.menuView];
        [self transitionFromViewController:self.vc1 toViewController:self.vc2 duration:0.5 options:UIViewAnimationOptionCurveLinear animations:nil completion:^(BOOL finished) {

            
        }];
    }
}

- (HFSegmentView *)mSegView
{
    if (!_mSegView)
    {
        _mSegView = [[HFSegmentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth == 320.f?130:167, 30)];
        _mSegView.currentIndex = 1;
        _mSegView.textFont = kScreenWidth == 320?[UIFont systemFontOfSize:15]:[UIFont systemFontOfSize:17];
        _mSegView.delegate = self;
        [_mSegView setSegmentTitles:@[@"悬赏广场",@"我的客户"]];
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
