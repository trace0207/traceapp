//
//  TKAppSettingViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/11.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKAppSettingViewController.h"
#import "LoginViewController.h"
#import "HFAlertView.h"
#import "TKAboutUsViewController.h"
#import "HFHabitHelper.h"
#import "MyInfoCell.h"
#import "HFSwitchCell.h"
#import "HFThirdPartyCenter.h"
#import "HFFeedbackController.h"
#import "UIImage+Scale.h"
#import "TKUserCenter.h"
#import "UIColor+TK_Color.h"
#import "TK_SettingCell.h"

@interface TKAppSettingViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footView;

@end




@implementation TKAppSettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"设置";
    [self initData];
    [self setTableView:[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped]];
    self.tableView.backgroundColor = [UIColor tkMainBackgroundColor];
    [self.view addSubview:self.tableView];
//    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    
}



-(NSMutableArray *)dataSource
{
    if(!_dataSource)
    {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)leftBarItemAction:(id)sender
{
    [super leftBarItemAction:sender];
    [MobClick event:Set_Back];
}

- (void)initData
{
    NSMutableDictionary *dic00 = [NSMutableDictionary dictionary];
    [dic00 setObject:@"My_newFans" forKey:KEY_IMG];
    [dic00 setObject:@"消息通知" forKey:KEY_TXT];
    
    NSMutableDictionary *dic01 = [NSMutableDictionary dictionary];
    [dic01 setObject:@"My_newFans" forKey:KEY_IMG];
    [dic01 setObject:@"私信通知" forKey:KEY_TXT];
    
    NSArray *array0 = [[NSArray alloc]initWithObjects:dic00,dic01,nil];
    
    
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
    [dic13 setObject:@"关于神器" forKey:KEY_TXT];
    
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
//    [self updateUserInfo:swi.tag];
//    UserRes * pushUser = [[GlobInfo shareInstance] usr];
//    NSMutableDictionary * pushDic= [NSMutableDictionary dictionary];
//    [pushDic setObject:[NSNumber numberWithInteger:pushUser.isPraisePush] forKey:@"praisePush"];
//    [pushDic setObject:[NSNumber numberWithInteger:pushUser.isCommPush] forKey:@"commenPush"];
//    [pushDic setObject:[NSNumber numberWithInteger:pushUser.isFansPush] forKey:@"fansPush"];
//    
//    [[[HIIProxy shareProxy] homeProxy] switchPush:[NSDictionary dictionaryWithDictionary:pushDic] success:^(BOOL finished) {
//        if (!finished) {
//            swi.on = !swi.on;
//        }
//    }];
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
    TKAboutUsViewController *vc = [[TKAboutUsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - private method

- (UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        _footView.backgroundColor = [UIColor clearColor];
        UIButton *exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 200-100, kScreenWidth-30, 44)];
        [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [exitBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [exitBtn setTitleColor:[UIColor tkMainTextColorForActiveBg] forState:UIControlStateNormal];
        //UIImage *image = [IMG(@"My_bigButton") resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 10, 20)];
//        UIImage *image = [UIImage scaleWithImage:@"My_bigButton"];
//        [exitBtn setBackgroundImage:image forState:UIControlStateNormal];
        [exitBtn setBackgroundImage:[UIColor TKcreateImageWithColor:[UIColor tkMainActiveColor]] forState:UIControlStateNormal];
        [exitBtn setBackgroundImage:[UIColor TKcreateImageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
//        [exitBtn.layer setCornerRadius:10.0f];
        
        
        
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
        TK_SettingCell * cell = [TK_SettingCell loadSwitchType:self];
        [cell.leftImageIcon setImage:IMG(imageName)];
        cell.leftLabel.text = title;
        return cell;
    }else if (indexPath.section == 1) {
        
        TK_SettingCell * cell = [TK_SettingCell loadDefaultTextWithLeftIconType:self];
        [cell.leftImageIcon setImage:IMG(imageName)];
        cell.leftLabel.text = title;
        cell.rightLabel.hidden = YES;
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
