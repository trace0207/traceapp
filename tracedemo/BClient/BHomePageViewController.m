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
//#import "HFAlertView.h"
#import "TKAlertView.h"
#import "CountDownView.h"
#import "UIImage+Scale.h"
@interface BHomePageViewController ()<HFSegmentViewDelegate>

@property (nonatomic,strong)BPageViewController * vc1;
@property (nonatomic,strong)BPageViewController * vc2;
@property (nonatomic,strong)KTDropdownMenuView *menuView;


@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation BHomePageViewController

- (UISegmentedControl *)segmentedControl
{
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"悬赏广场",@"我的客户"]];
        _segmentedControl.frame = CGRectMake(0, 0, 170, 30);
        _segmentedControl.selectedSegmentIndex = 1;
        //_segmentedControl.tintColor = [UIColor hexChangeFloat:TK_Color_nav_background];
//        UIImage *img = [UIImage scaleWithImage:@"btn_bg_unable"];
//        [_segmentedControl setImage:img forSegmentAtIndex:0];
//        [_segmentedControl setImage:img forSegmentAtIndex:1];
    }
    return _segmentedControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.hidDefaultBackBtn = YES;
    [self initView];
}

- (KTDropdownMenuView *)menuView
{
    if (_menuView == nil) {
         NSArray *titles = @[@"悬赏中", @"已释放"];
        _menuView = [[KTDropdownMenuView alloc] initWithFrame:CGRectMake(0, 0,60, 44) titles:titles];
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
    [self TKaddNavigationTitleView:self.segmentedControl];
    if (self.mSegView.currentIndex == 1) {
        [self addRightBarItemWithCustomView:self.menuView];
    }
    UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [bt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [bt setTitle:@"弹窗" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self addLeftBarItemWithCustomView:bt];
}

- (void)test
{

    //成功场景
//    [TKAlertView showSuccessWithTitle:@"晒单成功！" withMessage:@"你不能这么厉害好吗？" commpleteBlock:^(NSInteger buttonIndex) {
//        
//    } cancelTitle:@"取消" determineTitle:@"确定"];
    
    //失败场景
//    [TKAlertView showFailedWithTitle:@"晒单失败!" withMessage:@"你为什么这么弱？" commpleteBlock:^(NSInteger buttonIndex) {
//        
//    } cancelTitle:@"我错了" determineTitle:nil];
    

    
    //富文本场景
//    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc]initWithString:@"请支付预付款：1200元\n（预付款将打入平台账户，不会直接打给买手）"];
//    
//    NSDictionary *dic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
//    
//    [attriString addAttributes:dic1 range:NSMakeRange(0, 7)];
//    
//    NSDictionary *dic2 = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]};
//    [attriString addAttributes:dic2 range:NSMakeRange(7, 5)];
//    
//    NSDictionary *dic3 = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor lightGrayColor]};
//    [attriString addAttributes:dic3 range:NSMakeRange(13, 21)];
//    
//    [TKAlertView showAltertWithTitle:@"请支付悬赏金" withMessage:attriString commpleteBlock:^(NSInteger buttonIndex) {
//        
//    } cancelTitle:@"取消" determineTitle:@"确定并支付"];
    
    //发货时间弹窗界面
    [TKAlertView showDeliveryTimeWithBlock:^(NSInteger buttonIndex) {
        
    }];
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
        _vc2.tabsViewBackgroundColor = [UIColor hexChangeFloat:TK_Color_nav_background];
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
        _vc1.tabsViewBackgroundColor = [UIColor hexChangeFloat:TK_Color_nav_background];
        _vc1.view.backgroundColor = [UIColor tkThemeColor2];
    }
    return _vc1;
}

@end
