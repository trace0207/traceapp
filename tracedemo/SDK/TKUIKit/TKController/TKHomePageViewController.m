//
//  TKHomePageViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 15/10/29.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKHomePageViewController.h"
#import "HFSegmentView.h"

@interface TKHomePageViewController (){

    UIViewController * tab1;
    UIViewController * tab2;
}

@end

@implementation TKHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tab1 = [[UIViewController alloc] init];
    tab2 = [[UIViewController alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:tab1];
    [self addChildViewController:tab2];
    
//    [self addDefaultLeftBarItem];
//    
//    [self addChildViewController:self.healthViewController];
//    [self.view addSubview:self.healthViewController.view];
    //self.navigationItem.titleView = self.mSegView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationTitleView:self.mSegView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self setNavigationTitleView:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBarItemAction:(id)sender
{
    //进入到用户中心
    [MobClick event:AdvanceScheme_Communicate];
    HFPostBarController * post = [[HFPostBarController alloc] init];
    post.schemeId = self.adSchemeID;
    [self.navigationController pushViewController:post animated:YES];
}

#pragma mark -
#pragma mark getter

- (HFAdvanceHealthViewController *)healthViewController
{
    if (!_healthViewController)
    {
        _healthViewController = [[HFAdvanceHealthViewController alloc] init];
        _healthViewController.schemeID = self.adSchemeID;
        _healthViewController.bShowTest = self.bBeginUse;
    }
    return _healthViewController;
}

- (WebViewController *)faqViewController
{
    if (!_faqViewController)
    {
        _faqViewController = [[WebViewController alloc] init];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:KURLFAQ((long)self.adSchemeID) forKey:kParamURL];
        _faqViewController.param = dic;
        //   vc.moduleType = type;
        
    }
    return _faqViewController;
}

- (HFSegmentView *)mSegView
{
    if (!_mSegView)
    {
        _mSegView = [[HFSegmentView alloc] initWithFrame:CGRectMake((kScreenWidth - 185) / 2, 28, 185, 28)];
        _mSegView.delegate = self;
        [_mSegView setSegmentTitles:@[@"调理方案",@"常见问题"]];
    }
    return _mSegView;
}

#pragma mark -
#pragma mark HFSegmentViewDelegate

- (void)selectSegmentIndex:(NSInteger)index
{
    if (index == 0)
    {
        [self addChildViewController:self.healthViewController];
        [self transitionFromViewController:self.faqViewController toViewController:self.healthViewController duration:0.5 options:UIViewAnimationOptionCurveLinear animations:nil completion:^(BOOL finished) {
            [self.healthViewController didMoveToParentViewController:self];
            [self.faqViewController willMoveToParentViewController:nil];
            [self.faqViewController removeFromParentViewController];
        }];
    }
    else
    {
        [MobClick event:AdvanceScheme_CommonProblem];
        [self addChildViewController:self.faqViewController];
        [self transitionFromViewController:self.healthViewController toViewController:self.faqViewController duration:0.5 options:UIViewAnimationOptionCurveLinear animations:nil completion:^(BOOL finished) {
            [self.faqViewController didMoveToParentViewController:self];
            [self.healthViewController willMoveToParentViewController:nil];
            [self.healthViewController removeFromParentViewController];
            self.faqViewController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);
        }];
    }
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
