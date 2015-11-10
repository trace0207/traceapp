//
//  HFAddHabitViewController.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/10/23.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import "HFAddHabitViewController.h"
#import "HFHabitInfoCell.h"
#import "HFHabitTimeCell.h"
#import "HFHabitRecordViewController.h"
#import "HFHabitTimeDetailViewController.h"

@interface HFAddHabitViewController ()<UITableViewDataSource,UITableViewDelegate,HFHabitTimeCellDelegate,HFAddHabitDelegate,HFHabitInfoCellDelegate>

@property(nonatomic,copy)NSString * mHabitInfo;
@property(nonatomic,strong)UITableView * mTableView;
@property(nonatomic,strong)UIView * mClockHeader;
@property(nonatomic,strong)UIView * mDesHeader;

@property(nonatomic,strong)HFHabitAlramClockListData * clockData;

@end

@implementation HFAddHabitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"创建习惯"];
    [self addRightBarItemWithTitle:@"创建"];
    
    if (!_mTableView)
    {
        _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        _mTableView.tableFooterView = [[UIView alloc] init];
        _mTableView.backgroundColor = [UIColor HFColorStyle_6];
        _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mTableView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)rightBarItemAction:(id)sender
{
    //进行习惯的创建
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    
    WS(weakSelf)
    [[[HIIProxy shareProxy]habitProxy]creatHabitWithHabitName:self.mHabitName andDes:self.mHabitInfo andData:self.clockData Success:^(HFCreateHabitRes *res) {
        [hud hide:YES];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        
    } fail:^{
        [hud hide:YES];
        DDLogInfo(@"创建习惯失败!");
    }];
    
}

- (void)addAlarmAction:(UIButton *)btn
{
    //添加提醒
    
}

#pragma mark -
#pragma mark UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 80.0;
    }
    else if (indexPath.section == 1)
    {
        return 40.0;
    }
    else
    {
        return 75.0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        HFHabitInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"habit_info"];
        
        if (!cell)
        {
            cell = [[HFHabitInfoCell alloc] initWithIndex:0];
        }
        
        [cell setContentWithHaibitName:self.mHabitName subscriHabitNum:0 habitUrl:nil];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        HFHabitInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"habit_des"];
        
        if (!cell)
        {
            cell = [[HFHabitInfoCell alloc] initWithIndex:1];
            cell.delegate = self;
        }
        [cell setCellForHabitDes:self.mHabitInfo];
        return cell;
    }
    else
    {
        HFHabitTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HabitTimeCell"];
        
        if (!cell)
        {
            cell = [[HFHabitTimeCell alloc] initWithIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        [cell setContent:self.clockData];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 0)
    {
        return 40.0;
    }
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return nil;
    }
    else if (section == 1)
    {
        return self.mDesHeader;
    }
    else
    {
        return self.mClockHeader;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        HFHabitTimeDetailViewController * alarmDetailViewController = [[HFHabitTimeDetailViewController alloc] init];
        alarmDetailViewController.mType = CreateHabit_Type;
        alarmDetailViewController.data = nil;
        alarmDetailViewController.delegate = self;
        [self.navigationController pushViewController:alarmDetailViewController animated:YES];
    }
}

#pragma mark -
#pragma mark HFAddHabitDelegate
- (void)finishAction:(HFHabitAlramClockListData *)data
{
    self.clockData = data;
    [self.mTableView reloadData];
}


#pragma mark -
#pragma mark HFHabitTimeCellDelegate
- (void)switchHabitState:(UISwitch *)swi AtCell:(HFHabitTimeCell *)cell
{
    self.clockData.status = swi.on;
}

#pragma mark -
#pragma mark HFHabitInfoCellDelegate
- (void)haibtInfoEdit:(NSString *)habitInfo
{
    self.mHabitInfo = habitInfo;
}


#pragma mark -
#pragma mark getter

- (HFHabitAlramClockListData *)clockData
{
    if (!_clockData)
    {
        _clockData = [[HFHabitAlramClockListData alloc] init];
        
        _clockData.weeks = @"1111111";
        
        NSDate * date = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HHmm"];
        NSString * dateStr = [formatter stringFromDate:date];
        
        _clockData.hour = [[dateStr substringWithRange:NSMakeRange(0, 2)] integerValue];
        _clockData.minute = [[dateStr substringWithRange:NSMakeRange(2, 2)] integerValue];
        _clockData.status = NO;
    }
    
    return _clockData;
}


- (UIView *)mClockHeader
{
    if (!_mClockHeader)
    {
        _mClockHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _mClockHeader.backgroundColor = [UIColor clearColor];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 300, 20)];
        title.text = @"提醒(选填)";
        title.font = [UIFont systemFontOfSize:14.0];
        title.textColor = [UIColor HFColorStyle_3];
        [_mClockHeader addSubview:title];
        
    }
    return _mClockHeader;
}

- (UIView *)mDesHeader
{
    if (!_mDesHeader)
    {
        _mDesHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _mDesHeader.backgroundColor = [UIColor clearColor];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 300, 20)];
        title.text = @"习惯介绍(选填)";
        title.font = [UIFont systemFontOfSize:14.0];
        title.textColor = [UIColor HFColorStyle_3];
        [_mDesHeader addSubview:title];
        
    }
    return _mDesHeader;
}


@end
