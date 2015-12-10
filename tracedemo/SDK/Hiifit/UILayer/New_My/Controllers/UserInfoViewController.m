//
//  UserInfoViewController.m
//  GuanHealth
//
//  Created by hermit on 15/3/5.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserRes.h"
#import "SettingsViewController.h"
#import "MyInfoCell.h"
#import "UserViewController.h"
#import "HFCoopViewController.h"
#import "HFFeedbackController.h"
#import "HFThirdPartyCenter.h"
#import "MyBandViewController.h"
#import "HFMessageViewController.h"
#import "HFBoxViewController.h"
#import "UserCenterViewController.h"
#import "HFActivityListViewController.h"
#import "HFDevInfoViewController.h"
#import "HFBandViewController.h"
#import "HFBindingViewController.h"
#import "HFBindDeviceListController.h"
#import "WebViewController.h"
#import "GlobNotifyDefine.h"
#import "UIViewController+Customize.h"
#import "UIKitTool.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+TKNavigationBarSetting.h"
#import "TKUserCenter.h"
#import "TKUserPageViewController.h"
#import "TKIBaseNavWithDefaultBackVC.h"
#import "HFEditInfoViewController.h"
#import "TKUserCenter.h"
#import "TKEditUserInfoVC.h"


@interface UserInfoViewController()<HFDismissBandViewDelegate,HFMessageViewControllerDelegate>
{
    NSInteger unreadCount;
}
@property (nonatomic, strong) NSMutableArray *mMessageArray;
@property (nonatomic, strong) UIImageView *badgeView;
@end



@implementation UserInfoViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        [kNotificationCenter addObserver:self selector:@selector(getMessageUnread:) name:HFCheckMessageUnreadCount object:nil];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mHiScore.textColor = [UIColor HFColorStyle_5];
    [self initData];
}
- (void)initData
{
    
    NSMutableDictionary *dic10 = [NSMutableDictionary dictionary];
    [dic10 setObject:@"My_stepRecord" forKey:KEY_IMG];
    [dic10 setObject:@"我的订单" forKey:KEY_TXT];
    
    
    NSMutableDictionary *dic11 = [NSMutableDictionary dictionary];
    [dic11 setObject:@"My_stepRecord" forKey:KEY_IMG];
    [dic11 setObject:@"晒单相册" forKey:KEY_TXT];
    
    
    NSArray *array1 = [[NSArray alloc]initWithObjects:dic10,dic11,nil];
    
    
    NSMutableDictionary *dic20 = [NSMutableDictionary dictionary];
    [dic20 setObject:@"My_message" forKey:KEY_IMG];
    [dic20 setObject:@"我的账户" forKey:KEY_TXT];
    
    NSMutableDictionary *dic21 = [NSMutableDictionary dictionary];
    [dic21 setObject:@"My_hiBox" forKey:KEY_IMG];
    [dic21 setObject:@"我的卡券" forKey:KEY_TXT];
    
    NSMutableDictionary *dic22 = [NSMutableDictionary dictionary];
    [dic22 setObject:@"My_foodSearch" forKey:KEY_IMG];
    [dic22 setObject:@"附近买手" forKey:KEY_TXT];
    
    NSMutableDictionary * dic23 = [NSMutableDictionary dictionary];
    [dic23 setObject:@"My_activity" forKey:KEY_IMG];
    [dic23 setObject:@"活动" forKey:KEY_TXT];
    
    NSMutableDictionary * dic24 = [NSMutableDictionary dictionary];
    [dic24 setObject:@"My_setting" forKey:KEY_IMG];
    [dic24 setObject:@"设置" forKey:KEY_TXT];
    
    NSArray * array2 = [NSArray arrayWithObjects:dic20,dic21,dic22,dic23,dic24,nil];
    
    NSArray * array0 = [NSArray arrayWithObjects: [NSMutableDictionary dictionary],nil];
    
    [self.dataSource addObject:array0];
    [self.dataSource addObject:array1];
    [self.dataSource addObject:array2];
    
    self.tableView.backgroundColor = [UIColor HFColorStyle_6];
    [self.tableView reloadData];
}

-(void)dealloc
{
    [kNotificationCenter removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKremoveLeftBarButtonItem];
    [self TKremoveRightBarButtonItem];
    [self TKremoveNavigationTitle];
    [self TKaddNavigationTitle:@"我"];
    
    TKUser * user = [[TKUserCenter instance]getUser];
    if (user.headPortraitUrl.length>0) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:user.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"user"]];
        
    }else{
        [self.headImageView setImage:IMG(@"user")];
    }
    self.headLabel.text = user.nickName;
    
    self.mHiScore.text = [[NSNumber numberWithInteger:user.score]stringValue];
}

-(NSMutableArray *)mMessageArray
{
    if (!_mMessageArray) {
        NSNumber *num = [NSNumber numberWithInteger:0];
        _mMessageArray = [[NSMutableArray alloc]initWithObjects:num,num,num,num, nil];
    }
    return _mMessageArray;
}

-(UIImageView *)badgeView
{
    if (!_badgeView) {
        _badgeView = [[UIImageView alloc]initWithImage:IMG(@"My_redPoint")];
        _badgeView.frame = CGRectMake((5./6.)*kScreenWidth+8, 5, 8, 8);
        [self.tabBarController.tabBar addSubview:_badgeView];
    }
    return _badgeView;
}
- (void)getMessageUnread:(NSNotification *)notification
{
    HFMessageBoxData *data = (HFMessageBoxData *)[notification object];
    [self.mMessageArray removeAllObjects];
    [self.mMessageArray addObject:@(data.unReadComentCount)];
    [self.mMessageArray addObject:@(data.unReadPraiseCount)];
    [self.mMessageArray addObject:@(data.unReadFollowCount)];
    [self.mMessageArray addObject:@(data.unReadSystemCount)];
    unreadCount = data.unReadMessage;
    self.badgeView.hidden = NO;
}

#pragma mark - tableview delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray * list = [self.dataSource objectAtIndex:section];
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 88;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0  && indexPath.row == 0) {
        TKEditUserInfoVC * bvc = [[TKEditUserInfoVC alloc] init];
        [self.navigationController pushViewController:bvc animated:YES];
    }else
        if (indexPath.section == 1) {
            [self onTableRowSelectFromSectionOne:indexPath.row];
        }
        else
            if (indexPath.section == 2) {
                [self onTableRowSelectFromSectionTwo:indexPath.row];
            }
}



-(void)onTableRowSelectFromSectionOne:(NSInteger)row
{
    if (row == 0) {
        TKIBaseNavWithDefaultBackVC * bvc = [[TKIBaseNavWithDefaultBackVC alloc] init];
        bvc.navTitle = @"我的订单";
        [self.navigationController pushViewController:bvc animated:YES];
    }else if (row == 1){ //  晒单相册
        TKUserPageViewController * userPage = [[TKUserPageViewController alloc] init];
        userPage.userId = TKUserId;
        userPage.navTitle = @"我的晒单";
        [self.navigationController pushViewController:userPage animated:YES];
    }
    
}

-(void)onTableRowSelectFromSectionTwo:(NSInteger)row
{
    if (row == 0) {
        
        TKIBaseNavWithDefaultBackVC * bvc = [[TKIBaseNavWithDefaultBackVC alloc] init];
        bvc.navTitle = @"我的账户";
        [self.navigationController pushViewController:bvc animated:YES];
    }
    if (row == 1) {
        TKIBaseNavWithDefaultBackVC * bvc = [[TKIBaseNavWithDefaultBackVC alloc] init];
        bvc.navTitle = @"我的卡券";
        [self.navigationController pushViewController:bvc animated:YES];
    }
    else if (row == 2){
        
        TKIBaseNavWithDefaultBackVC * bvc = [[TKIBaseNavWithDefaultBackVC alloc] init];
        bvc.navTitle = @"附近买手";
        [self.navigationController pushViewController:bvc animated:YES];
        
    }
    else if(row == 3)
    {
        TKIBaseNavWithDefaultBackVC * bvc = [[TKIBaseNavWithDefaultBackVC alloc] init];
        bvc.navTitle = @"活动";
        [self.navigationController pushViewController:bvc animated:YES];
    }
    else if (row == 4) {
        SettingsViewController * setVC = [[SettingsViewController alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
        
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.headCell;
    }else{
        static NSString *identifier = @"MessageCell";
        MyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MyInfoCell" owner:self options:nil] objectAtIndex:1];
        }
        NSArray *list = [self.dataSource objectAtIndex:indexPath.section];
        NSDictionary *dic = [list objectAtIndex:indexPath.row];
        NSString *imageName = [dic objectForKey:KEY_IMG];
        NSString *text = [dic objectForKey:KEY_TXT];
        [cell.image setImage:[UIImage imageNamed:imageName]];
        [cell.titleLabel setText:text];
        [cell hiddenImageNew];
        [cell setUnreadCount:0];
        //        if (indexPath.section == 1 && indexPath.row == 0) {
        //            [cell setUnreadCount:unreadCount];
        //        }else {
        //            [cell setUnreadCount:0];
        //        }
        //        if (indexPath.row == 3 && indexPath.section == 1) {
        //            [cell judgeFirstLogin];
        //        }else{
        //            [cell hiddenImageNew];
        //        }
        return cell;
    }
}

#pragma mark -
#pragma mark HFDismissBandViewDelegate
- (void)dismissBandView:(UIViewController *)vc
{
    WS(weakSelf)
    [vc dismissViewControllerAnimated:NO completion:^{
        HFBindDeviceListController * bindList = [[HFBindDeviceListController alloc] init];
        bindList.bBindStatus = NO;
        [weakSelf.navigationController pushViewController:bindList animated:YES];
    }];
}
#pragma mark - message unread count delegate
- (void)updateMessageBoxIcon:(NSInteger)unread
{
    unreadCount = unread;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    if (unread == 0 && [kUserDefaults boolForKey:kParamFirstNew]) {
        [self.badgeView setHidden:YES];
    }else {
        [self.badgeView setHidden:NO];
    }
}
@end
