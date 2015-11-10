//
//  HFHabitTimesListViewController.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHabitTimesListViewController.h"
#import "HFHabitTimeDetailViewController.h"
#import "HFHabitTimeCell.h"
#import "HFHabitHelper.h"
#import "HFHabitAlarmClockRes.h"
#import "HabitProxy.h"
#import "HFNoInfoView.h"
@interface HFHabitTimesListViewController ()<UITableViewDataSource,UITableViewDelegate,HFHabitTimeCellDelegate>
{
    UITableView * mTableView;
    
    NSMutableArray * mSources;
    
    HFNoInfoView * mNoView;
}
@property(nonatomic,strong)NSMutableArray * mSources;
@property(nonatomic,strong)UITableView * mTableView;
@end

@implementation HFHabitTimesListViewController
@synthesize mSources;
@synthesize mTableView;
@synthesize mHabitHeadUrl,mHabitId,mHabitName;
@synthesize mSubcribeNum;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavigationTitle:mHabitName];
    [self addRightBarItemWithTitle:_T(@"HF_Common_Add")];
    [self loadDataSource];
    //预设数据
    [self loadUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self loadDataSource];
//    if (!mTableView.hidden)
//    {
        [mTableView reloadData];
//    }
}

- (void)loadDataSource
{
    self.mSources = (NSMutableArray *)[[HFHabitHelper shareInstance] getClockListForHabitID:mHabitId];
    
    if ([mSources count] == 0 || mSources == nil)
    {
        mNoView.hidden = NO;
        mTableView.hidden = YES;
    }
    else
    {
        mNoView.hidden = YES;
        mTableView.hidden = NO;
    }
}

- (void)loadUI
{
    
    mTableView = [[UITableView alloc] initWithFrame:kScreenBounds style:UITableViewStylePlain];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:mTableView];
    [mTableView registerNib:[UINib nibWithNibName:@"HFHabitTimeCell" bundle:nil] forCellReuseIdentifier:@"HabitTimeCell"];
    
    mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    mNoView = [[HFNoInfoView alloc] initWithFrame:self.view.bounds Image:IMG(@"no_mood") Text:_T(@"HF_Habit_No_AlarmClock")];
    [self.view addSubview:mNoView];
}


- (void)rightBarItemAction:(id)sender
{
    [self pushToClockSettingsWithData:nil];
}

#pragma mark -
#pragma mark private

- (void)pushToClockSettingsWithData:(HFHabitAlramClockListData *)data
{
    HFHabitTimeDetailViewController * alarmDetailViewController = [[HFHabitTimeDetailViewController alloc] init];
    habitOperateType type = data == nil ? AddNewClock_Type : UpdataClock_Type;
    alarmDetailViewController.mType = type;
    alarmDetailViewController.mHabitId = mHabitId;
    alarmDetailViewController.data = data;
    [self.navigationController pushViewController:alarmDetailViewController animated:YES];
}

#pragma mark -
#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [mSources count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor HFColorStyle_6];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFHabitTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HabitTimeCell"];
    cell.delegate  = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section < [mSources count])
    {
        HFHabitAlramClockListData * data = [mSources objectAtIndex:indexPath.section];
        [cell setContent:data];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //编辑每一条数据
    [self pushToClockSettingsWithData:[mSources objectAtIndex:indexPath.section]];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        HFHabitAlramClockListData * data = [mSources objectAtIndex:indexPath.section];
        [self deleteHaibitClock:data atIndexPath:indexPath];
    }
}

- (void)deleteHaibitClock:(HFHabitAlramClockListData *)data atIndexPath:(NSIndexPath *)indexPath
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    WS(weakSelf)
    [[[HIIProxy shareProxy] habitProxy] deletaAlarmClockWithClockId:data.clockId completion:^(BOOL finish) {
        if (finish)
        {
            [weakSelf loadDataSource];
            [weakSelf.mTableView reloadData];
            [hud hide:YES];
        }
        else
        {
            [hud hide:YES];
        }
    }];
}

#pragma mark -
#pragma mark HFHabitTimeCellDelegate
- (void)switchHabitState:(UISwitch *)sender AtCell:(HFHabitTimeCell *)cell
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    
    NSInteger index = [mTableView indexPathForCell:cell].section;
    HFHabitAlramClockListData * data = [mSources objectAtIndex:index];
    data.status = sender.on;
    [[[HIIProxy shareProxy] habitProxy] updateAlarmClockWithAlarmClockData:data habitID:mHabitId completion:^(BOOL finish) {
        if (finish)
        {
            [hud hide:YES];
        }
        else
        {
            [hud hide:YES];
            sender.on = !sender.on;
            data.status = sender.on;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
