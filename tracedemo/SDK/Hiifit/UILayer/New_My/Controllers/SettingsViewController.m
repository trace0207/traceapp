//
//  SettingsViewController.m
//  GuanHealth
//
//  Created by hermit on 15/3/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoginViewController.h"
#import "HFAlertView.h"
#import "HFAboutUsViewController.h"
#import "HFHabitHelper.h"
#import "MyInfoCell.h"
#import "HFSwitchCell.h"
#import "HFThirdPartyCenter.h"
#import "HFFeedbackController.h"
#import "UIImage+Scale.h"
@interface SettingsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UserRes *user;
}
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footView;

@end

@implementation SettingsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        user = [[GlobInfo shareInstance]usr];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor HFColorStyle_6]];
    [self addNavigationTitle:@"设置"];

    [self initData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //_mPushSwi.on = [GlobInfo shareInstance].bPush;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor HFColorStyle_6];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _tableView;
}

- (void)leftBarItemAction:(id)sender
{
    [super leftBarItemAction:sender];
    [MobClick event:Set_Back];
}

- (void)initData
{
    NSMutableDictionary *dic00 = [NSMutableDictionary dictionary];
    [dic00 setObject:@"My_heartShape" forKey:KEY_IMG];
    [dic00 setObject:@"赞" forKey:KEY_TXT];
    
    NSMutableDictionary *dic01 = [NSMutableDictionary dictionary];
    [dic01 setObject:@"My_commentIcon" forKey:KEY_IMG];
    [dic01 setObject:@"评论" forKey:KEY_TXT];
    
    NSMutableDictionary *dic02 = [NSMutableDictionary dictionary];
    [dic02 setObject:@"My_newFans" forKey:KEY_IMG];
    [dic02 setObject:@"新粉丝通知" forKey:KEY_TXT];
    
    NSArray *array0 = [[NSArray alloc]initWithObjects:dic00,dic01,dic02, nil];
    
    
//    NSMutableDictionary *dic10 = [NSMutableDictionary dictionary];
//    [dic10 setObject:@"My_checkVersion" forKey:KEY_IMG];
//    [dic10 setObject:@"检测新版本" forKey:KEY_TXT];
    
    NSMutableDictionary * dic11 = [NSMutableDictionary dictionary];
    [dic11 setObject:@"My_refeed" forKey:KEY_IMG];
    [dic11 setObject:@"意见反馈" forKey:KEY_TXT];
    
    NSMutableDictionary * dic12 = [NSMutableDictionary dictionary];
    [dic12 setObject:@"My_invite" forKey:KEY_IMG];
    [dic12 setObject:@"邀请体验" forKey:KEY_TXT];
    
    NSMutableDictionary *dic13 = [NSMutableDictionary dictionary];
    [dic13 setObject:@"My_aboutUs" forKey:KEY_IMG];
    [dic13 setObject:@"关于我们" forKey:KEY_TXT];
    
    NSArray *array1 = [[NSArray alloc]initWithObjects: dic11, dic12,dic13, nil];
    [self.dataSource addObject:array0];
    [self.dataSource addObject:array1];
    
    [self.tableView reloadData];
}

- (void)exitAction:(id)sender
{
    [[[HIIProxy shareProxy] userProxy] logoutWithComplete:^(BOOL finish) {
        [[UIKitTool getAppdelegate] goLoginViewController];
    }];
}

- (void)switchSubscribeSetting:(UISwitch *)swi
{
    [self updateUserInfo:swi.tag];
    UserRes * pushUser = [[GlobInfo shareInstance] usr];
    NSMutableDictionary * pushDic= [NSMutableDictionary dictionary];
    [pushDic setObject:[NSNumber numberWithInteger:pushUser.isPraisePush] forKey:@"praisePush"];
    [pushDic setObject:[NSNumber numberWithInteger:pushUser.isCommPush] forKey:@"commenPush"];
    [pushDic setObject:[NSNumber numberWithInteger:pushUser.isFansPush] forKey:@"fansPush"];
    
    [[[HIIProxy shareProxy] homeProxy] switchPush:[NSDictionary dictionaryWithDictionary:pushDic] success:^(BOOL finished) {
        if (!finished) {
            swi.on = !swi.on;
        }
    }];
}

- (void)updateUserInfo:(HFPushType)pushType
{
    NSString *key = nil;
    if (pushType == HFpushComm) {
        key = @"isCommPush";
    }else if (pushType == HFPushPraise) {
        key = @"isPraisePush";
    }else {
        key = @"isFansPush";
    }
    
    NSDictionary *userDic = [[[GlobInfo shareInstance]usr]toDictionary];
    NSInteger open = [[userDic objectForKey:key]integerValue];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:userDic];
    NSNumber *flag = open?[NSNumber numberWithInteger:0]:[NSNumber numberWithInteger:1];
    [dic setObject:flag forKey:key];
    [[GlobInfo shareInstance]setUserInfo:dic];
}

- (void)goAboutUsView
{
    [MobClick event:Set_About_Us];
    HFAboutUsViewController *vc = [[HFAboutUsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - private method

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        _footView.backgroundColor = [UIColor clearColor];
        UIButton *exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 200-100, kScreenWidth-30, 44)];
        [exitBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
        [exitBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [exitBtn setTitleColor:[UIColor hexChangeFloat:@"F1F1F1" withAlpha:1.0f] forState:UIControlStateNormal];
        //UIImage *image = [IMG(@"My_bigButton") resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 10, 20)];
        UIImage *image = [UIImage scaleWithImage:@"My_bigButton"];
        [exitBtn setBackgroundImage:image forState:UIControlStateNormal];
        [exitBtn addTarget:self action:@selector(exitAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:exitBtn];
    }
    return _footView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *list = [_dataSource objectAtIndex:section];
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *list = [_dataSource objectAtIndex:indexPath.section];
    NSDictionary *dic = [list objectAtIndex:indexPath.row];
    NSString *title = [dic objectForKey:KEY_TXT];
    NSString *imageName = [dic objectForKey:KEY_IMG];
    if (indexPath.section == 0) {
        HFSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HFSwitchCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HFSwitchCell" owner:self options:nil]firstObject];
            [cell.msgSwitch addTarget:self action:@selector(switchSubscribeSetting:) forControlEvents:UIControlEventValueChanged];
        }
        cell.msgSwitch.tag =indexPath.row;
        if (indexPath.row == HFPushPraise) {
            cell.msgSwitch.on = user.isPraisePush;
        }
        if (indexPath.row == HFpushComm) {
            cell.msgSwitch.on = user.isCommPush;
        }
        if (indexPath.row == HFPushFuns) {
            cell.msgSwitch.on = user.isFansPush;
        }
        [cell.image setImage:[UIImage imageNamed:imageName]];
        cell.titleLabel.text = title;
        return cell;
    }else if (indexPath.section == 1) {
        MyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyInfoCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MyInfoCell" owner:self options:nil]firstObject];
        }
        [cell.image setImage:[UIImage imageNamed:imageName]];
        cell.titleLabel.text = title;
        
//        if (indexPath.row == 0)
//        {
//            cell.detailLabel.hidden = NO;
//            cell.detailLabel.text = [[HFDeviceInfo shareInstance] getAppVersion];
//        }
        
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01f;
    }else {
        return 200.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [MobClick event:MyInfo_My_Feedback];
            HFFeedbackController *vc = [[HFFeedbackController alloc]initWithNibName:@"HFFeedbackController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];

        }
        if (indexPath.row == 1) {
            //邀请体验代码
           [[HFThirdPartyCenter shareInstance]shareSDKInviteFriends:self];
        }
        if (indexPath.row == 2) {
            [self goAboutUsView];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]init];
    if (section == 0) {
        label.text = @"    消息推送";
    }else {
        label.text = @"    其他设置";
    }
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor hexChangeFloat:@"1F1F1F" withAlpha:1.0f];
    return label;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return self.footView;
    }
    return nil;
}

@end
