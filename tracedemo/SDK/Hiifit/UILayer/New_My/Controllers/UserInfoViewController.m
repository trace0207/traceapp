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
    NSMutableDictionary *dic20 = [NSMutableDictionary dictionary];
    [dic20 setObject:@"My_message" forKey:KEY_IMG];
    [dic20 setObject:@"我的账户" forKey:KEY_TXT];
    
    NSMutableDictionary *dic21 = [NSMutableDictionary dictionary];
    [dic21 setObject:@"My_stepRecord" forKey:KEY_IMG];
    [dic21 setObject:@"晒单相册" forKey:KEY_TXT];
    
    NSMutableDictionary *dic22 = [NSMutableDictionary dictionary];
    [dic22 setObject:@"My_hiBox" forKey:KEY_IMG];
    [dic22 setObject:@"我的卡券" forKey:KEY_TXT];
    
    NSMutableDictionary *dic23 = [NSMutableDictionary dictionary];
    [dic23 setObject:@"My_foodSearch" forKey:KEY_IMG];
    [dic23 setObject:@"附近买手" forKey:KEY_TXT];
    
    NSArray *array2 = [[NSArray alloc]initWithObjects:dic20,dic21,dic22,dic23, nil];
    
    NSMutableDictionary * activityDic = [NSMutableDictionary dictionary];
    [activityDic setObject:@"My_activity" forKey:KEY_IMG];
    [activityDic setObject:@"活动" forKey:KEY_TXT];
    
    NSMutableDictionary * setDic = [NSMutableDictionary dictionary];
    [setDic setObject:@"My_setting" forKey:KEY_IMG];
    [setDic setObject:@"设置" forKey:KEY_TXT];
    
    NSArray * sectionTwoArray = [NSArray arrayWithObjects:activityDic, setDic, nil];
    
    [self.dataSource addObject:array2];
    [self.dataSource addObject:sectionTwoArray];
    
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
    [self TKaddNavigationTitle:@"个人中心"];
    UserRes *user = [GlobInfo shareInstance].usr;
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
    return self.dataSource.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        NSArray *list = [self.dataSource objectAtIndex:section - 1];
        return list.count;
    }else{
        NSArray * list = [self.dataSource objectAtIndex:section - 1];
        return list.count;
    }
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
        [MobClick event:Myinfo_Head];
        UserCenterViewController * userCenter = [[UserCenterViewController alloc] init];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[NSNumber numberWithInteger:[[[GlobInfo shareInstance] usr] id]] forKey:kParamUserId];
        userCenter.param = dic;
        [self.navigationController pushViewController:userCenter animated:YES];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [MobClick event:Home_Message_Icon_Click];
            HFMessageViewController * messageViewController = [[HFMessageViewController alloc] init];
            messageViewController.delegate = self;
            messageViewController.mSourceMessageCountArr = self.mMessageArray;
            [self.tabBarItem setBadgeValue:nil];
            [self.navigationController pushViewController:messageViewController animated:YES];
        }else if (indexPath.row == 1){
            HFDevInfoViewController *vc = [[HFDevInfoViewController alloc]initWithNibName:@"HFDevInfoViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2){
            //邀请体验代码
            HFBoxViewController * boxVC = [[HFBoxViewController alloc] init];
            [self.navigationController pushViewController:boxVC animated:YES];
            
        }else if (indexPath.row == 3) {
            WebViewController * webVC = [[WebViewController alloc] init];
            NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:kURLFoodSearch, kParamURL, nil];
            webVC.param = dic;
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }
    if (indexPath.row == 3 && indexPath.section == 1) {
        if (![kUserDefaults boolForKey:kParamFirstNew]) {
            [kUserDefaults setBool:YES forKey:kParamFirstNew];
            [kUserDefaults synchronize];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:1];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self updateMessageBoxIcon:unreadCount];
        }
    }

    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            HFActivityListViewController * activityVC = [[HFActivityListViewController alloc] init];
            [self.navigationController pushViewController:activityVC animated:YES];
        }
        if (indexPath.row == 1) {
            SettingsViewController * setVC = [[SettingsViewController alloc] init];
            [self.navigationController pushViewController:setVC animated:YES];
        }
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
        NSArray *list = [self.dataSource objectAtIndex:indexPath.section - 1];
        NSDictionary *dic = [list objectAtIndex:indexPath.row];
        NSString *imageName = [dic objectForKey:KEY_IMG];
        NSString *text = [dic objectForKey:KEY_TXT];
        [cell.image setImage:[UIImage imageNamed:imageName]];
        [cell.titleLabel setText:text];
        if (indexPath.section == 1 && indexPath.row == 0) {
            [cell setUnreadCount:unreadCount];
        }else {
            [cell setUnreadCount:0];
        }
        if (indexPath.row == 3 && indexPath.section == 1) {
            [cell judgeFirstLogin];
        }else{
            [cell hiddenImageNew];
        }
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
