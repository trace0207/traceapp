//
//  BHomePageViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 16/2/18.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "BHomePageViewController.h"
#import "BHomeChildAVC.h"

@interface BHomePageViewController ()<HFSegmentViewDelegate>

@property (nonatomic,strong)BHomeChildAVC * vc1;
@property (nonatomic,strong)BHomeChildAVC * vc2;
@property (nonatomic,strong)UIViewController * currentVC;

@end

@implementation BHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidDefaultBackBtn = YES;
    // Do any additional setup after loading the view from its nib.
    [self initView];
}


-(void)initView
{
    [self addChildViewController:self.vc1];
    [self.view addSubview:self.vc1.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self TKaddNavigationTitleView:self.mSegView];
}


//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

- (void)selectSegmentIndex:(NSInteger)index
{
    if (index == 0)
    {
        [self addChildViewController:self.vc1];
        [self transitionFromViewController:self.vc2 toViewController:self.vc1 duration:0.5 options:UIViewAnimationOptionCurveLinear animations:nil completion:^(BOOL finished) {
            [self.vc1 didMoveToParentViewController:self];
            [self.vc2 willMoveToParentViewController:nil];
            [self.vc2 removeFromParentViewController];
        }];
    }
    else
    {
        [self addChildViewController:self.vc2];
        self.vc2.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);
        [self transitionFromViewController:self.vc1 toViewController:self.vc2 duration:0.5 options:UIViewAnimationOptionCurveLinear animations:nil completion:^(BOOL finished) {
            [self.vc2 didMoveToParentViewController:self];
            [self.vc1 willMoveToParentViewController:nil];
            [self.vc1 removeFromParentViewController];
            
        }];
    }
}

- (HFSegmentView *)mSegView
{
    if (!_mSegView)
    {
        _mSegView = [[HFSegmentView alloc] initWithFrame:CGRectMake((kScreenWidth - 185) / 2, 28, 185, 28)];
        _mSegView.delegate = self;
        [_mSegView setSegmentTitles:@[@"悬赏广场",@"我的客户"]];
    }
    return _mSegView;
}


-(BHomeChildAVC *)vc2
{
    if(!_vc2)
    {
        _vc2 = [[BHomeChildAVC alloc] initWithNibName:@"BHomeChildAVC" bundle:nil];
    }
    return _vc2;
}

-(BHomeChildAVC *)vc1
{
    if(!_vc1)
    {
        _vc1 = [[BHomeChildAVC alloc] initWithNibName:@"BHomeChildAVC" bundle:nil];
    }
    return _vc1;
}

@end
