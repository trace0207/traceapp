//
//  MyBandViewController.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/7.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "MyBandViewController.h"
#import "HFUnBindingViewController.h"
#import "HFBindingViewController.h"
#import "MyInfoCell.h"

@interface MyBandViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL  bBind;
}
@end

@implementation MyBandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"我的配件"];
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mTableView setBackgroundColor:RGBA(234, 234, 234, 1)];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString * bindBandId = [GlobInfo shareInstance].usr.bandDeviceId;
    if (bindBandId == nil || [bindBandId isEqualToString:@""])
    {
        bBind = NO;
    }
    else
    {
        bBind = YES;
    }

    [self.mTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInfoCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MyInfoCell" owner:self options:nil]firstObject];
    cell.detailLabel.hidden = NO;
    [cell.image setImage:IMG(@"band_icon")];
    cell.titleLabel.text = @"嗨健康手环";
    
    if (bBind)
    {
        cell.detailLabel.text = @"已绑定";
    }
    else
    {
        cell.detailLabel.text = @"未绑定";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!bBind) {
        HFBindingViewController * bindController = [[HFBindingViewController alloc] init];
        [self.navigationController pushViewController:bindController animated:YES];
    }
    else
    {
        HFUnBindingViewController * unBindController = [[HFUnBindingViewController alloc] init];
        [self.navigationController pushViewController:unBindController animated:YES];
    }
    
}

@end
