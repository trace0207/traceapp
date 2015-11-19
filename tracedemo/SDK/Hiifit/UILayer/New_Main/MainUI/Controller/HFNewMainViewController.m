//
//  HFNewMainViewController.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/10/19.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import "HFNewMainViewController.h"
#import "MainPageAdvanceSchemeAck.h"
#import "HFMainActivityRes.h"
#import "HFBannerCell.h"
#import "WebViewController.h"
#import "HFAdvanceSchemeCell.h"
#import "ChildSchemeViewController.h"
#import "HFAdvanceSchemeContainerViewController.h"
#import "HFNewMainHeaderView.h"
#import "HFHabitViewCell.h"
#import "HFHabitRecordViewController.h"
#import "HFMenuControl.h"
#import "HFActivityWindowAck.h"
#import "HFSchemeListViewController.h"
#import "HFActivityView.h"
#import "SetInfoViewController.h"
#import "UserRes.h"
#import "GlobNotifyDefine.h"
#import "UIViewController+TKNavigationBarSetting.h"
#define kActivityBannerScale 1.8f
@interface HFNewMainViewController()<UITableViewDataSource,UITableViewDelegate,HFBannerCellDelegate,HFAdvanceSchemeCellDelegate,HFNewMainHeaderViewDelegate,HFHabitViewCellDelegate,HFPunchCardDelegate,HFMenuDelegate,HFActivityViewDelegate>
{
    dispatch_group_t group;
    
    NewMainFunction funcType;
    
    CGFloat  schemeOffset;
    
    CGFloat  habitOffset;
    BOOL    bReload;
    
}
@property(nonatomic,copy)NSMutableArray * habits;
@property(nonatomic,copy)MainPageAdvanceSchemeData * adSchemeData;
@property(nonatomic,strong)UITableView * schemeTableView;
@property(nonatomic,strong)UITableView * habitTableView;
@property(nonatomic,strong)HFNewMainHeaderView * mHeadView;
@property(nonatomic,copy)NSMutableArray * imageUrls;
@property(nonatomic,copy)NSMutableArray * activities;
@property(nonatomic,strong)HFMenuControl * menu;
@property(nonatomic,strong)HFBannerCell * activityView;
@property (nonatomic, strong) UserRes *user;


@end



@implementation HFNewMainViewController

#pragma mark -
#pragma mark Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.user = [[GlobInfo shareInstance]usr];
    schemeOffset = 0.0;
    habitOffset = 0.0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    funcType = HFNewMainCellFunc_Scheme;
    group = dispatch_group_create();
//    [self initNetData];
    
    
    //进行布局排版
    [self.view sendSubviewToBack:self.schemeTableView];
    [self.view insertSubview:self.activityView aboveSubview:self.schemeTableView];
    [self.view insertSubview:self.mHeadView aboveSubview:self.activityView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKremoveNavigationTitle];
    [self TKremoveRightBarButtonItem];
    [self TKremoveLeftBarButtonItem];
    [self TKaddNavigationTitle:@"搜索"];
//    [self TKsetRightBarItemImage:IMG(@"new_add")
//                       addTarget:self
//                          action:@selector(rightBarItemAction:)
//                forControlEvents:UIControlEventTouchUpInside];
//    if (bReload)
//    {
//        //进行数据请求
//        [self getAdvanceSchemeInfo];
//        [self getHabitsData];
//        WS(weakSelf)
//        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//            NSLog(@"结束了整组的请求队列");
//            if (funcType == HFNewMainCellFunc_Scheme)
//            {
//                [weakSelf.schemeTableView reloadData];
//            }
//            else
//            {
//                [weakSelf.habitTableView reloadData];
//            }
//            
//        });
//    }
//    else
//    {
//        bReload = YES;
//    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    if (![self.user hasSetUserInfo])
//    {
//        SetInfoViewController *vc = [[SetInfoViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

}

- (void)rightBarItemAction:(id)sender
{
    [self.menu showMenu];
}

#pragma mark -
#pragma mark Net

- (void)initNetData
{
    [self getSuspendActivity];
    [self getActivitiesData];
    [self getAdvanceSchemeInfo];
    [self getHabitsData];
    [self getUnreadMessageCount];
    WS(weakSelf)
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"结束了整组的请求队列");
        [weakSelf.schemeTableView reloadData];
        
        [weakSelf.activityView setBannerToCell:self.imageUrls];
    });
}

/**
 *  获取悬浮窗的广告
 */
- (void)getSuspendActivity
{
    WS(weakSelf)
    [[[HIIProxy shareProxy]activityProxy]loadActivityWindow:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            HFActivityWindowAck *res = (HFActivityWindowAck *)ack;
            [weakSelf showActivityView:res.data];
        }
    }];
}

- (void)showActivityView:(HFActivityWindowData*)data
{
    NSString *url = [kUserDefaults stringForKey:kParamDisplayAD];
    if (url && [url isEqualToString:data.url]) {
        return;
    }
    
    HFActivityView *acView = [[HFActivityView alloc]initWithImage:data.picAddr activityUrl:data.url];
    acView.delegate = self;
    [acView show];
    
    [kUserDefaults setObject:data.url forKey:kParamDisplayAD];
    [kUserDefaults synchronize];
}

//获取广告数据
- (void)getActivitiesData
{
    dispatch_group_enter(group);
    WS(weakSelf)
    [[[HIIProxy shareProxy]activityProxy]requestBannerActivitiesPosition:1 complete:^(NSArray *data, BOOL success) {
        if(success){
            weakSelf.imageUrls = [weakSelf getImagesFromActivityData:data];
            [weakSelf.activities removeAllObjects];
            [weakSelf.activities addObjectsFromArray:data];
        }
        dispatch_group_leave(group);
    }];
}

//获取未读消息数
- (void)getUnreadMessageCount
{
    WS(weakSelf)
    [[[HIIProxy shareProxy] messageBoxProxy] hasUnReadMessageWithCompletion:^(HFMessageBoxData * res) {
        [weakSelf resetMessageInfo:res];
    }];
}
- (void)resetMessageInfo:(HFMessageBoxData *)res
{
    if (res.unReadMessage>0) {
        [kNotificationCenter postNotificationName:HFCheckMessageUnreadCount object:res userInfo:nil];
    }
}

//获取习惯数据
- (void)getHabitsData
{
    dispatch_group_enter(group);
    
    NSLog(@"开始请求习惯数据");
    WS(weakSelf)
    [[[HIIProxy shareProxy] habitProxy] requestHabitListWithTime:0 Success:^(HFHabitListRes *res) {
        dispatch_group_leave(group);
        NSLog(@"离开请求习惯数据");
        [weakSelf.habits removeAllObjects];
        [weakSelf.habits addObjectsFromArray:res.data];
    } fail:^{
        NSLog(@"离开请求习惯数据");
        dispatch_group_leave(group);
    }];
}

//获取高级方案信息
- (void)getAdvanceSchemeInfo
{
    dispatch_group_enter(group);
    WS(weakSelf)
    [[[HIIProxy shareProxy] schemeProxy] getAdvanceSchemeWithBlock:^(HF_BaseAck *ack) {
        MainPageAdvanceSchemeAck * ret = (MainPageAdvanceSchemeAck *)ack;
        
        if (ret.data.count >0)
        {
            MainPageAdvanceSchemeData * data = [ret.data lastObject];
            weakSelf.adSchemeData = data;
        }
        else
        {
            DDLogDebug(@"数据少于一个!,请知悉");
        }
        
        dispatch_group_leave(group);
    }];
    
}

#pragma mark -
#pragma mark private

- (NSMutableArray *)getImagesFromActivityData:(NSArray *)activtyData
{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:activtyData.count];
    for (HFMainActivityData *data in activtyData) {
        if (data.picUrl) {
            [arr addObject:data.picUrl];
        }
    }
    return arr;
}

- (void)addNewScheme
{
    HFSchemeListViewController * schemeList = [[HFSchemeListViewController alloc] init];
    [self.navigationController pushViewController:schemeList animated:YES];
}

#pragma mark -
#pragma mark UITableViewDelegate && DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == HFNewMainCellOrganization_Banner)
    {
        return 1;
    }
    else
    {
        if (funcType == HFNewMainCellFunc_Scheme)
        {
            return 2;
        }
        else
        {
            return [self.habits count] + 1;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == HFNewMainCellOrganization_Other)
    {
        return 44.0;
    }
    
    return 0.0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == HFNewMainCellOrganization_Banner)
    {
        return kScreenWidth/kActivityBannerScale;
    }
    else
    {
        if (funcType == HFNewMainCellFunc_Scheme)
        {
            
            if (self.adSchemeData.isSubscribe)
            {
                if (indexPath.row == 1)
                {
                    return 200.0;
                }
            }
            else
            {
                if (indexPath.row == 0)
                {
                    return 90.0;
                }
            }
            
            return [HFAdvanceSchemeCell cellHeightForData:self.adSchemeData atIndex:indexPath.row];
        }
        else
        {
            
            if ([self.habits count] == 0)
            {
                return 230.0;
            }
            else
            {
                
                if (indexPath.row == [self.habits count])
                {
                    return 90.0;
                }
                else
                {
                    return 75.0;
                }
            }
            
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == HFNewMainCellOrganization_Other) {
   
        if (funcType == HFNewMainCellFunc_Scheme)
        {
            NSString *indentifier;
            NSInteger index;
            
            if (self.adSchemeData.isSubscribe)
            {
                if (indexPath.row != 0)
                {
                    HFAdvanceSchemeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"adscheme_footer"];
                    if (!cell)
                    {
                        cell= [[HFAdvanceSchemeCell alloc]initWithIndex:5];

                    }
                    return cell;
                }
            }
            else
            {
                if (indexPath.row == 0)
                {
                    HFAdvanceSchemeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"adscheme_header"];
                    if (!cell)
                    {
                        cell= [[HFAdvanceSchemeCell alloc]initWithIndex:4];
                    }
                    return cell;
                }
            }
            
            AdvanceSchemeType type = [HFAdvanceSchemeCell cellTypeForData:self.adSchemeData];
            if (type == AdvanceScheme_None)
            {
                indentifier = @"adScheme_none";
                index = 1;
            }
            else if (type == AdvanceScheme_One)
            {
                indentifier = @"adScheme_one";
                index = 0;
            }
            else if (type == AdvanceScheme_Begin)
            {
                indentifier = @"adScheme_begin";
                index = 3;
            }
            else
            {
                indentifier = @"adScheme_more";
                index = 2;
            }
            if (self.adSchemeData)
            {
                HFAdvanceSchemeCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
                if (!cell)
                {
                    cell= [[HFAdvanceSchemeCell alloc]initWithIndex:index];
                    cell.delegate = self;
                }
                [cell setContentData:self.adSchemeData];
                return cell;
            }
            else
            {
                return [[UITableViewCell alloc]init];
            }
        }
        else
        {
            NSString * indentifier;
            
            NSInteger index;
            
            if ([self.habits count] == 0)
            {
                indentifier = @"habit_None";
                index = 1;
            }
            else if (indexPath.row == [self.habits count])
            {
                indentifier = @"habit_more";
                index = 2;
            }
            else
            {
                indentifier = @"HFHabitViewCell";
                index = 0;
            }
            
            HFHabitViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
            
            if (!cell)
            {
                cell = [[HFHabitViewCell alloc] initWithIndex:index];
                cell.delegate = self;
            }
            
            if ([self.habits count] != 0 && indexPath.row < [self.habits count]) {
                HFHabitListData *habit = [self.habits objectAtIndex:indexPath.row];
                [cell setContentToCell:habit];
            }
            
            return cell;
        }
        
    }
    
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == HFNewMainCellOrganization_Other )
    {
        if (funcType == HFNewMainCellFunc_Habit)
        {
            if (indexPath.row < [self.habits count])
            {
                HFHabitListData * data = [self.habits objectAtIndex:indexPath.row];
                
                HFHabitRecordViewController *vc = [[HFHabitRecordViewController alloc]initWithNibName:@"HFHabitRecordViewController" bundle:nil];
                vc.delegate = self;
                vc.habitId = data.habitId;
                vc.habitName = data.habitName;
                vc.habitIconUrl = data.habitIconUrl;
                vc.popViewController = self;
                [self.navigationController pushViewController: vc animated:YES];
            }
        }
        else
        {
            if (self.adSchemeData.isSubscribe)
            {
                [self detailSchemeClick:self.adSchemeData.id];
            }
            else
            {
                [self beginUseAction:self.adSchemeData.id];
            }
            
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (funcType == HFNewMainCellFunc_Scheme)
    {
        return NO;
    }
    else
    {
        if (indexPath.row == [self.habits count])
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        HFHabitListData *data = [self.habits objectAtIndex:indexPath.row];
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
        WS(weakSelf)
        [[[HIIProxy shareProxy]habitProxy]deleteHabitWithId:data.habitId completion:^(BOOL finish) {
            if (finish) {
                [weakSelf.habits removeObjectAtIndex:indexPath.row];
                [weakSelf.habitTableView reloadData];
            }
            [hud hide:YES];
        }];
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (funcType == HFNewMainCellFunc_Scheme)
    {
        schemeOffset = scrollView.contentOffset.y;
    }
    else
    {
        habitOffset = scrollView.contentOffset.y;
    }
    
    
    CGRect activtyRect = self.activityView.frame;
    CGRect headRect = self.mHeadView.frame;
    
    activtyRect.origin.y = - scrollView.contentOffset.y;
    self.activityView.frame = activtyRect;
    
    if (scrollView.contentOffset.y > kScreenWidth/kActivityBannerScale)
    {
        headRect.origin.y = 0;
    }
    else
    {
        headRect.origin.y = kScreenWidth/kActivityBannerScale - scrollView.contentOffset.y;
    }
    
    self.mHeadView.frame = headRect;
    
}


#pragma mark - 
#pragma mark HFPunchCardDelegate
- (void)PunchCard:(NSInteger)habitId withStatus:(NSInteger)status
{
    //刷新打卡状态
//    for (HFHabitListData * data in self.habits)
//    {
//        if (data.habitId == habitId)
//        {
//            data.flag = status;
//            
//            NSInteger row = [self.habits indexOfObject:data];
//            
//            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:HFNewMainCellOrganization_Other]] withRowAnimation:UITableViewRowAnimationNone];
//            
//            break;
//        }
//    }
    
}



#pragma mark -
#pragma mark HFBannerCellDelegate
- (void)didSelectItemAtIndex:(NSInteger)index
{
    HFMainActivityData *data = [self.activities objectAtIndex:index];
    if (data.url.length>0) {
        WebViewController *vc = [[WebViewController alloc]init];
        vc.moduleType = HIModuleTypeBanner;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (![data.url hasPrefix:@"http"]) {
            data.url = [NSString stringWithFormat:@"%@%@",kBaseURL,data.url];
        }
        [dic setValue:data.url forKey:kParamURL];
        vc.param = dic;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -
#pragma mark HFNewMainHeaderViewDelegate
- (void)buttonClick:(NSInteger)index
{
    if (index == funcType)
    {
        return;
    }
    
    funcType = (NewMainFunction)index;
    
   // CGFloat headOrign = self.mHeadView.frame.origin.y;
    
    CGFloat offset = -self.activityView.frame.origin.y > kScreenWidth/kActivityBannerScale ? kScreenWidth/kActivityBannerScale : -self.activityView.frame.origin.y;
    
    CGFloat contentOffset = 0.0;
    //切换到另外一个TableView
    if (funcType == HFNewMainCellFunc_Scheme)
    {
        contentOffset = offset;
      
        self.schemeTableView.contentOffset = CGPointMake(0, contentOffset);
        
        [self.view insertSubview:self.schemeTableView aboveSubview:self.habitTableView];
        
        [self.schemeTableView reloadData];
    }
    else
    {
        
        contentOffset = offset;
    
        self.habitTableView.contentOffset = CGPointMake(0, contentOffset);
        
        [self.view insertSubview:self.habitTableView aboveSubview:self.schemeTableView];
        
        [self.habitTableView reloadData];
    }
}

#pragma mark -
#pragma mark HFHabitViewCellDelegate
- (void)addNewHabit
{
    WebViewController *vc = [[WebViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:kURLHabitList forKey:kParamURL];
    [dic setObject:KEY_ADD_HABIT forKey:kParamFrom];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -
#pragma mark HFAdvanceSchemeCell

- (void)detailSchemeClick:(NSInteger)schemeID
{
    [MobClick event:AdvanceScheme_Detail];
    HFAdvanceSchemeContainerViewController * advCtrl = [[HFAdvanceSchemeContainerViewController alloc] init];
    advCtrl.adSchemeID = schemeID;
    advCtrl.bBeginUse = NO;
    [self.navigationController pushViewController:advCtrl animated:YES];
}

- (void)mainSchemeClick:(NSInteger)subSchemeId schemeName:(NSString *)schemeName
{
    switch (subSchemeId) {
        case 3:
            [MobClick event:AdvanceScheme_Rudiments];
            break;
        case 4:
            [MobClick event:AdvanceScheme_Advance];
            break;
        case 5:
            [MobClick event:AdvanceScheme_Strengthen];
            break;
        default:
            break;
    }
    ChildSchemeViewController * scheme = [[ChildSchemeViewController alloc] init];
    scheme.subSchemeId = subSchemeId;
    scheme.subscribeSize = [self.adSchemeData.subSchemeList count];
    scheme.schemeId = self.adSchemeData.id;
    scheme.subSchemeName = schemeName;
    
    [self.navigationController pushViewController:scheme animated:YES];
}

- (void)beginUseAction:(NSInteger)schemeID
{
    [MobClick event:AdvanceScheme_Start_Click];
    HFAdvanceSchemeContainerViewController * advCtrl = [[HFAdvanceSchemeContainerViewController alloc] init];
    advCtrl.adSchemeID = schemeID;
    advCtrl.bBeginUse = YES;
    [self.navigationController pushViewController:advCtrl animated:YES];
}

#pragma mark -
#pragma mark HFMenuDelegate
- (void)MenuDidSelectIndex:(NSInteger)index
{
    if (index == 0)
    {
        [self addNewScheme];
    }
    else
    {
        [self addNewHabit];
    }
}

#pragma mark -
#pragma mark Getter

- (HFBannerCell *)activityView
{
    if (!_activityView)
    {
        _activityView = [[HFBannerCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/kActivityBannerScale)];
        _activityView.delegate = self;
        [self.view addSubview:_activityView];
    }
    return _activityView;
}


- (HFMenuControl *)menu
{
    if (!_menu) {
        _menu = [[HFMenuControl alloc]initWithCategorys:nil];
        _menu.delegate = self;
    }
    return _menu;
}

- (NSMutableArray *)habits
{
    if (!_habits)
    {
        _habits = [[NSMutableArray alloc] init];
    }
    return _habits;
}

- (UITableView *)schemeTableView
{
    if (!_schemeTableView)
    {
        WS(weakSelf)
        _schemeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _schemeTableView.delegate = self;
        _schemeTableView.dataSource = self;
        _schemeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _schemeTableView.backgroundColor = [UIColor HFColorStyle_6];
        [_schemeTableView setTableFooterView:[[UIView alloc] init]];
        [self.view addSubview:_schemeTableView];
        
        [_schemeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _schemeTableView;
}

- (UITableView *)habitTableView
{
    if (!_habitTableView)
    {
        WS(weakSelf)
        _habitTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _habitTableView.delegate = self;
        _habitTableView.dataSource = self;
        _habitTableView.backgroundColor = [UIColor HFColorStyle_6];
        _habitTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_habitTableView setTableFooterView:[[UIView alloc] init]];
        [self.view addSubview:_habitTableView];
        
        [_habitTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _habitTableView;
}


- (UIView *)mHeadView
{
    if (!_mHeadView)
    {
        _mHeadView = [[HFNewMainHeaderView alloc] initWithFrame:CGRectMake(0, kScreenWidth/kActivityBannerScale, self.view.frame.size.width, 44) withTitles:@[@"我的调理方案",@"我的习惯"]];
        _mHeadView.delegate = self;
        _mHeadView.backgroundColor = [UIColor whiteColor];
    }
    return _mHeadView;
}

- (NSMutableArray *)imageUrls
{
    if (!_imageUrls)
    {
        _imageUrls = [[NSMutableArray alloc] init];
    }
    return _imageUrls;
}

- (NSMutableArray *)activities
{
    if (!_activities)
    {
        _activities = [[NSMutableArray alloc] init];
    }
    return _activities;
}
#pragma mark - activity

- (void)goActivityView:(NSString *)url
{
    WebViewController *vc = [[WebViewController alloc]init];
    vc.moduleType = HIModuleTypeActivity;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:url forKey:kParamURL];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
