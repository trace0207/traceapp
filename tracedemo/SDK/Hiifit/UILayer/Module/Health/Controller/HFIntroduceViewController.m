//
//  HFIntroduceViewController.m
//  SDCycleScrollView
//
//  Created by 朱伟特 on 15/8/10.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "HFIntroduceViewController.h"
#import "HFIntroduceCell.h"
#import "HFHealthViewController.h"
#import "LoadSchemeDataAck.h"
@interface HFIntroduceViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation HFIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"颈椎调理介绍"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    if (self.schemeInfo.isSubscribe == 0) {
        UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        backgroundView.backgroundColor = [UIColor HFColorStyle_6];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, 15, kScreenWidth - 30, 50);
        [button setTitle:@"立即使用" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor HFColorStyle_5];
        button.layer.cornerRadius = button.frame.size.height / 2;
        [backgroundView addSubview:button];
        [button addTarget:self action:@selector(useRightNow) forControlEvents:UIControlEventTouchUpInside];
        self.tableView.tableFooterView = backgroundView;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        HFIntroduceCell * introduceCell1 = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
        if (!introduceCell1) {
            introduceCell1 = [[HFIntroduceCell alloc] initWithIndex:0];
        }
        return introduceCell1;
    }
    if (indexPath.row == 1) {
        HFIntroduceCell * introduceCell2 = [tableView dequeueReusableCellWithIdentifier:@"secondCell"];
        if (!introduceCell2) {
            introduceCell2 = [[HFIntroduceCell alloc] initWithIndex:1];
        }
        return introduceCell2;
    }
    if (indexPath.row == 2) {
        HFIntroduceCell * introduceCell3 = [tableView dequeueReusableCellWithIdentifier:@"thirdCell"];
        if (!introduceCell3) {
            introduceCell3 = [[HFIntroduceCell alloc] initWithIndex:2];
        }
        return introduceCell3;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 177;
    }
    if (indexPath.row == 1) {
        return 324;
    }
    if (indexPath.row == 2) {
        return 125;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark -
#pragma mark HFIntroduceCellDelegate
- (void)useRightNow
{
    [MobClick event:Scheme_StartScheme_Click];
    
    WS(weakSelf)
    [[[HIIProxy shareProxy]schemeProxy]modifyScheme:self.schemeInfo.id schemeStatus:HFModifySchemeTypeStart withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            [weakSelf goHealthVC];
        }
    }];
    
}

- (void)goHealthVC
{
    HFHealthViewController * healthViewController = [[HFHealthViewController alloc] init];
    healthViewController.mSchemeDay = self.schemeInfo.currDay;
    healthViewController.needShowGuideView = self.needShowGuideView;
    [self.navigationController pushViewController:healthViewController animated:YES];
}
- (void)leftBarItemAction:(id)sender
{
    [MobClick event:Scheme_IntroduceBack_Click];
    [self.navigationController popViewControllerAnimated:YES];
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
