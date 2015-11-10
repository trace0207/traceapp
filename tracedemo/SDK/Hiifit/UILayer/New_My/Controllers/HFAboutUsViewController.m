//
//  HFAboutUsViewController.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/21.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFAboutUsViewController.h"
#import "HFAboutUsCell.h"
#import "MyInfoCell.h"
#import <SinaWeiboConnection/SinaWeiboConnection.h>
#import <ShareSDK/ShareSDK.h>
#import "WebViewController.h"
#import "HFPrivacyViewController.h"
#import "HFAboutUsTableViewCell.h"

@interface HFAboutUsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * dicArray;
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation HFAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"关于我们"];
    [self loadUI];
    //[self loadData];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - privateFunction
- (void)loadUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor HFColorStyle_6];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
//    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }

    
    HFAboutUsCell * cell = [[HFAboutUsCell alloc] initWithIndex:0];
    self.tableView.tableHeaderView = cell;
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 221 - 44 * 3 - 75)];
    UILabel * label3 = [[UILabel alloc] init];
    label3.textColor = [UIColor HFColorStyle_7];
    [bottomView addSubview:label3];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:11.0f];
    label3.text = @"邮箱:hiiservice@hiifit.com";
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_centerX).with.offset(0);
        make.bottom.equalTo(bottomView.mas_bottom).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(130, 15));
    }];
    
    UILabel * label2 = [[UILabel alloc] init];
    [bottomView addSubview:label2];
    [label2 setTextColor:[UIColor HFColorStyle_7]];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:11.0f];
    label2.text = @"电话：400-10086-86";
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_centerX).with.offset(-0);
        make.bottom.equalTo(bottomView.mas_bottom).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(130, 15));
    }];

    UILabel * label1 = [[UILabel alloc] init];
    label1.text = @"中移杭州技术科技有限公司";
    label1.textColor = [UIColor HFColorStyle_7];
    label1.font = [UIFont systemFontOfSize:11.0f];
    label1.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView.mas_centerX);
        make.bottom.equalTo(label2.mas_top).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(190, 15));
    }];
    
    
    self.tableView.tableFooterView = bottomView;
}
//- (void)loadData
//{
//    NSMutableDictionary * introDic = [NSMutableDictionary dictionary];
//    [introDic setObject:@"功能介绍" forKey:KEY_TXT];
//    [introDic setObject:@"" forKey:KEY_IMG];
//    
//    NSMutableDictionary * weiboDic = [NSMutableDictionary dictionary];
//    [weiboDic setObject:@"" forKey:KEY_IMG];
//    [weiboDic setObject:@"关注嗨健康微博" forKey:KEY_TXT];
//    
//    NSMutableDictionary * secretDic = [NSMutableDictionary dictionary];
//    [secretDic setObject:@"用户隐私协议" forKey:KEY_TXT];
//    [secretDic setObject:@"" forKey:KEY_IMG];
//    
//    [self.dicArray addObject:introDic];
//    [self.dicArray addObject:weiboDic];
//    [self.dicArray addObject:secretDic];
//    [self.tableView reloadData];
//}
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dicArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"aboutUsIdenfitier";
    HFAboutUsTableViewCell * infoCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!infoCell) {
        infoCell = [[HFAboutUsTableViewCell alloc] initWithIndex:0];
//        NSMutableDictionary * dic = [self.dicArray objectAtIndex:indexPath.row];
//        NSString * text = [dic objectForKey:KEY_TXT];
        infoCell.nameLabel.text = [self.dicArray objectAtIndex:indexPath.row];
    }
    return infoCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        WebViewController * webVC = [[WebViewController alloc] init];
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:kURLFunctionPage, kParamURL, nil];
        webVC.param = dic;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    if (indexPath.row == 1) {
        WebViewController * web = [[WebViewController alloc] init];
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://weibo.com/u/3554757421?from=myfollow_all", kParamURL, nil];
        web.param = dic;
        [self.navigationController pushViewController:web animated:YES];
    }
    if (indexPath.row == 2) {
        WebViewController * webView = [[WebViewController alloc] init];
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://183.131.13.104/CloudHealth/web/declare.html", kParamURL, nil];
        webView.param = dic;
        [self.navigationController pushViewController:webView animated:YES];
    }
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 189;
//}
#pragma mark - LazyLoading
- (NSMutableArray *)dicArray
{
    if (!_dicArray) {
        _dicArray = [NSMutableArray arrayWithObjects:@"功能介绍", @"关注嗨健康微博", @"用户隐私协议", nil];
    }
    return _dicArray;
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
