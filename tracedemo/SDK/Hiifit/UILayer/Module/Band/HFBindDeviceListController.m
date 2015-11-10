//
//  HFMyDeviceController.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/29.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFBindDeviceListController.h"
#import "HFMyDeviceCell.h"
#import "HFBindingViewController.h"
#import "HFUnBindingViewController.h"
@interface HFBindDeviceListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation HFBindDeviceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"我的设备"];
    [self loadUI];
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PrivateFunction
- (void)loadUI
{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
}
- (void)initData
{
    NSMutableDictionary * dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:@"嗨健康手环" forKey:KEY_TXT];
    [dic1 setObject:@"My_HiiFit" forKey:KEY_IMG];
    self.dataArray = [NSMutableArray arrayWithObjects:dic1, nil];
    [self.tableView reloadData];
}
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    HFMyDeviceCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[HFMyDeviceCell alloc] initWithIndex:0];
        NSMutableDictionary * dic = [self.dataArray objectAtIndex:indexPath.row];
        NSString * name = [dic objectForKey:KEY_TXT];
        NSString * image = [dic objectForKey:KEY_IMG];
        cell.nameLabel.text = name;
        cell.deviceImage.image = IMG(image);
        if (!self.bBindStatus)
        {
            cell.bindLabel.text = @"未绑定";
        }
        else
        {
            cell.bindLabel.text = @"已绑定";
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        if (!self.bBindStatus)
        {
            HFBindingViewController *vc = [[HFBindingViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            HFUnBindingViewController * unBindController = [[HFUnBindingViewController alloc] init];
            [self.navigationController pushViewController:unBindController animated:YES];
        }
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
#pragma mark - LazyLoading
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor HFColorStyle_6];
    }
    return _tableView;
}
- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, kScreenWidth - 15, 21)];
        label.textColor = [UIColor HFColorStyle_3];
        label.text = @"目前只支持绑定以下设备，将来会有更多选择哦~";
        label.font = [UIFont systemFontOfSize:13.0];
        [_headerView addSubview:label];
    }
    return _headerView;
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
