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
#import "GlobNotifyDefine.h"
#import "TKAfterSalesViewController.h"
#import "TKUserCenter.h"
@interface CHomePageViewController ()
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic,strong)BPageViewController * vc1;
@property (nonatomic,strong)BPageViewController * vc2;
@property (nonatomic, strong)TKPayChooseView *payView;
@end

@implementation CHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserNormalDataReady) name:TKBrandCategoryReady object:nil];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.hidDefaultBackBtn = YES;
    [self initView];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma  mark  notify Event
-(void)onUserNormalDataReady
{
    [self.vc1 reloadTitleViewAndData];
}


#pragma private method
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKaddNavigationTitleView:self.segmentedControl];
//        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
//        [bt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [bt setTitle:@"投诉" forState:UIControlStateNormal];
//        [bt addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
//        [self addLeftBarItemWithCustomView:bt];
    
    if([TKUserCenter instance].freashReward)
    {
        self.segmentedControl.selectedSegmentIndex = 1;
        [self onSelectTabAtIndex:1];
        [TKUserCenter instance].freashReward = NO;
        [self.vc2 reloadTitleViewAndData];
    }
}

-(void)initView
{
    [self addChildViewController:self.vc1];
    [self.view addSubview:self.vc1.view];
    [self.vc1 reloadTitleViewAndData];
}
-(void)test
{

    NSString * orderId = @"123";
    [TKAfterSalesViewController showAfterSalesView:orderId];
    
    
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


- (UISegmentedControl *)segmentedControl
{
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"晒单池",@"悬赏池"]];
        _segmentedControl.frame = CGRectMake(0, 0, 150, 30);
        _segmentedControl.selectedSegmentIndex = 0;
        [_segmentedControl addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _segmentedControl;
}
- (void)segmentedAction:(UISegmentedControl *)seg
{
    [self onSelectTabAtIndex:seg.selectedSegmentIndex];
}

-(void)onSelectTabAtIndex:(NSInteger)index
{
    WS(weakSelf)
    if (index == 0) {
        [self addRightBarItemWithCustomView:nil];
        [self addChildViewController:self.vc1];
        [self transitionFromViewController:self.vc2 toViewController:self.vc1 duration:0.5 options:UIViewAnimationOptionCurveLinear animations:nil completion:^(BOOL finished) {
            [weakSelf.vc1 didMoveToParentViewController:self];
//            [weakSelf.vc2 willMoveToParentViewController:nil];
//            [weakSelf.vc2 removeFromParentViewController];
            [weakSelf.vc1.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
            }];
            
            if(!self.vc1.titleReady)
            {
                [self.vc1 reloadTitleViewAndData];
            }
            
        }];
    }else {
        [self addChildViewController:self.vc2];
        [self transitionFromViewController:self.vc1 toViewController:self.vc2 duration:0.5 options:UIViewAnimationOptionCurveLinear animations:nil completion:^(BOOL finished) {
            
            [weakSelf.vc2 didMoveToParentViewController:self];
//            [weakSelf.vc1 willMoveToParentViewController:nil];
//            [weakSelf.vc1 removeFromParentViewController];
            [weakSelf.vc2.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
            }];
            if(!weakSelf.vc2.titleReady)
            {
                [weakSelf.vc2 reloadTitleViewAndData];
            }
        }];
        
    }
 
}

-(BPageViewController *)vc2
{
    if(!_vc2)
    {
        _vc2 = [[BPageViewController alloc] init];
        _vc2.dataType = C_AllReward;
        _vc2.tabViewRightSpace = 90;
        _vc2.indicatorColor = [UIColor tkThemeColor1];
        _vc2.tabsViewBackgroundColor = [UIColor tkThemeColor2];
        
    }
    return _vc2;
}

-(BPageViewController *)vc1
{
    if(!_vc1)
    {
        _vc1 = [[BPageViewController alloc] init];
        _vc1.dataType = C_showGoods;
        _vc1.tabViewRightSpace = 90;
        _vc1.indicatorColor = [UIColor tkThemeColor1];
        _vc1.tabsViewBackgroundColor = [UIColor tkThemeColor2];
    }
    return _vc1;
}

@end
