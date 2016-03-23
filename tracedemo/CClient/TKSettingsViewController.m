//
//  SettingsViewController.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/23.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKSettingsViewController.h"
#import "TK_SettingCell.h"
@interface TKSettingsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TKSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [tableView setTableFooterView:[UIView new]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKaddNavigationTitle:@"设置"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TK_SettingCell *cell = [TK_SettingCell loadNoImageSwitchType:self];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.label1.text = @"消息提醒";
        return cell;
    }else {
        TK_SettingCell *cell = [TK_SettingCell loadDefaultTextType:self];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.label1.text = @"清空缓存";
        cell.label2.text = @"66M";
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
