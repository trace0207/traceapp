//
//  HFHabitViewController.m
//  GuanHealth
//
//  Created by hermit on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHabitViewController.h"
#import "WebViewController.h"
#import "HFDateHeaderView.h"
#import "HFHabitViewCell.h"
#import "HabitProxy.h"
#import "HFHabitRecordViewController.h"
#import "HFHabitTimeDetailViewController.h"

@interface HFHabitViewController ()<HFDateDelegate,HFPunchCardDelegate>
{
    NSInteger days;
}

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HFHabitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationTitle:@"习惯"];
    [self addRightBarItemWithTitle:@"添加习惯"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    HFDateHeaderView *headerView = [[HFDateHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    headerView.delegate = self;
    [headerView setTitileWithDate:[NSDate date] nearDay:0];
    [self.tableView setTableHeaderView:headerView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self getHabitList:days];
}

- (void)rightBarItemAction:(id)sender
{
    WebViewController *vc = [[WebViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:kURLHabitList forKey:kParamURL];
    [dic setObject:KEY_ADD_HABIT forKey:kParamFrom];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getHabitList:(NSInteger)day
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    WS(weakSelf)
    [[[HIIProxy shareProxy] habitProxy] requestHabitListWithTime:days Success:^(HFHabitListRes *res) {
        if (res.data.count==0) {
            //[weakSelf removeNullView];
            [self addNullViewToTableView];
        }else{
            [self removeNullView];
        }
        if (!weakSelf.dataSource) {
            weakSelf.dataSource = [[NSMutableArray alloc]init];
        }
        if (weakSelf.dataSource.count) {
            [weakSelf.dataSource removeAllObjects];
        }
        [weakSelf.dataSource addObjectsFromArray:res.data];
        [weakSelf.tableView reloadData];
        [hud hide:YES];
    } fail:^{
        [hud hide:YES];
    }];
}

- (void)addNullViewToTableView
{
    UIView *view = [self.tableView viewWithTag:404];
    if (view) {
        [view removeFromSuperview];
    }
    UIView *nullView = [[UIView alloc]initWithFrame:CGRectMake(0, self.tableView.tableHeaderView.frame.size.height, kScreenWidth, kScreenHeight-64-self.tableView.tableHeaderView.frame.size.height)];
    nullView.tag = 404;
    //nullView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    nullView.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 78)];
    [imageView setImage:IMG(@"no_mood")];
    imageView.center = CGPointMake(nullView.frame.size.width/2, nullView.frame.size.height/2-60);
    [nullView addSubview:imageView];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height, nullView.frame.size.width, 60)];
    lable.numberOfLines = 0;
    lable.font = [UIFont systemFontOfSize:16.0f];
    lable.textColor = [UIColor hexChangeFloat:@"bbbbbb" withAlpha:1.0f];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"Come on!\n点击右上角添加习惯";
    [nullView addSubview:lable];
    
    [self.tableView addSubview:nullView];
}

- (void)removeNullView
{
    UIView *view = [self.tableView viewWithTag:404];
    if (view) {
        [view removeFromSuperview];
    }
}

#pragma mark - table view delegate and data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFHabitViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HFHabitViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HFHabitViewCell" owner:self options:nil]firstObject];
    }
    HFHabitListData *habit = [self.dataSource objectAtIndex:indexPath.section];
    [cell setContentToCell:habit];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (days != 0)
    {
        return;
    }
    
    HFHabitListData *habit = [self.dataSource objectAtIndex:indexPath.section];
    HFHabitRecordViewController *vc = [[HFHabitRecordViewController alloc]initWithNibName:@"HFHabitRecordViewController" bundle:nil];
    vc.habitId = habit.habitId;
    vc.habitName = habit.habitName;
    vc.habitIconUrl = habit.habitIconUrl;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (days != 0) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        HFHabitListData *data = [self.dataSource objectAtIndex:indexPath.section];
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
        WS(weakSelf)
        [[[HIIProxy shareProxy]habitProxy]deleteHabitWithId:data.habitId completion:^(BOOL finish) {
            if (finish) {
                [weakSelf.dataSource removeObjectAtIndex:indexPath.section];
                [tableView reloadData];
            }
            [hud hide:YES];
        }];
    }
}

#pragma mark date header delegate
- (void)leftPage:(HFDateHeaderView *)dateHeader
{
    days += 1;
    
    NSDate *date = [NSDate currentDatePlusDays:0-days];
    [self getHabitList:days];
    [dateHeader setTitileWithDate:date nearDay:days];
    if (days == 6) {
        [dateHeader setLeftViewHidden:YES];
    }else{
        [dateHeader setRightViewHidden:NO];
    }
}

- (void)rightPage:(HFDateHeaderView *)dateHeader
{
    days -= 1;
    
    NSDate *date = [NSDate currentDatePlusDays:0-days];
    [self getHabitList:days];
    [dateHeader setTitileWithDate:date nearDay:days];
    if (days == 0) {
        [dateHeader setRightViewHidden:YES];
    }else{
        [dateHeader setLeftViewHidden:NO];
    }
}

#pragma mark punch card delegate

- (void)PunchCard:(NSInteger)habitId withStatus:(NSInteger)status
{
    for (NSUInteger i = 0; i < self.dataSource.count; i++) {
        HFHabitListData *habit = [self.dataSource objectAtIndex:i];
        if (habit.habitId == habitId) {
            habit.flag = status;
            [self.dataSource replaceObjectAtIndex:i withObject:habit];
            break;
        }
    }
}

@end
