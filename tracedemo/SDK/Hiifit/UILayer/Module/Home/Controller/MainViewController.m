//
//  MainViewController.m
//  GuanHealth
//
//  Created by hermit on 15/2/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "LoginViewController.h"
#import "SignThreeViewController.h"
#import "WebViewController.h"
#import "UserCenterViewController.h"
#import "QuadCurveMenu.h"
#import "SentPostViewController.h"
#import "SudoViewController.h"
#import "TimeLineRes.h"
#import "ActivitiesRes.h"
#import "ModuleRes.h"
#import "PostDetailData.h"
#import "HFBoxViewController.h"
#import "FindViewController.h"
#import "HabitRes.h"
#import "HFCommentViewController.h"
#import "SetInfoViewController.h"
#import "HFMessageViewController.h"
#import "PostCell.h"
#import "MessageBoxProxy.h"
#import "HFHabitViewController.h"
#import "HabitProxy.h"
#import "HFHabitRecordViewController.h"
#import "HFHabitHelper.h"
#import "HFMainActivityRes.h"
#import "HFActivityListViewController.h"
#import "HFBannerCell.h"
#import "HFHealthViewController.h"
#import "HFSchemeCell.h"
#import "HFIntroduceViewController.h"
#import "HFUnlockViewController.h"
#import "HFRefreshController.h"
#import "HFMainActivityRes.h"
#import "HFBandViewController.h"
#import "HFDevInfoViewController.h"
#import "HFBindingViewController.h"
#import "BandCenter.h"
#import "HFAdvanceSchemeCell.h"
#import "HFAdvanceSchemeContainerViewController.h"
#import "ChildSchemeViewController.h"
#import "MainPageAdvanceSchemeAck.h"
#import "HFCaculateHeightModel.h"
#import "GlobNotifyDefine.h"
//banner条的宽高比例
#define kBannerScale 1.8f
@interface MainViewController ()
<QuadCurveMenuDelegate,
 HabitEdit,
 PostCellDelegate,
 HFCommentViewControllerDelegate,
 HFMessageViewControllerDelegate,
 HabitHeaderDelegate,
 MainCellDelegate,
 UITableViewDataSource,
 UITableViewDelegate,
 HFBannerCellDelegate,
 HFRefreshControllerDelegate,
 HFDismissBandViewDelegate,HFAdvanceSchemeCellDelegate>
{
    NSMutableArray * mMessageArray;
    
    MBProgressHUD *  HUD;
    HFRefreshController *refreshController;
    dispatch_group_t group;
    
    WaitRefreshState   waitState;
}

@property (nonatomic, strong) NSMutableArray            *dataSource;
@property (nonatomic, assign) int                       currentId;
@property (nonatomic, strong) NSMutableArray            *habits;
@property (nonatomic, strong) NSMutableArray            *activities;
@property (nonatomic, strong) NSMutableArray            *heights;
@property (nonatomic, strong) UserRes                   *user;
@property (nonatomic, strong) NSMutableArray            *imageUrls;
@property (nonatomic, strong) LoadSchemeDataAck         *schemeData;
@property (nonatomic, strong) MainPageAdvanceSchemeData  *adSchemeData;
//导航视图
@property (nonatomic, strong) UIView *navBarView;
@property (nonatomic, strong) UIImageView *navBackImage;
@property (nonatomic, strong) UIButton                  *mHeadButton;
@property (nonatomic, strong) UIButton                  *mMsgButton;
@property (nonatomic, strong) UIButton                  *mActivityButton;
@property (nonatomic, strong) UIImageView          *mHeadImage;
@property (nonatomic, strong) UIImageView * bgGuideView;

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    waitState = Wait_Refresh_ALL;
    
    self.view.backgroundColor = [UIColor whiteColor];
   
    group = dispatch_group_create();
    [self initSource];
    [self initUI];
}

- (void)initSource
{
    _currentId = 0;
    self.user = [GlobInfo shareInstance].usr;
    mMessageArray = [[NSMutableArray alloc] init];
    self.habits = [[NSMutableArray alloc] init];
    self.dataSource = [[NSMutableArray alloc]init];
    self.heights = [[NSMutableArray alloc] init];
    
    [self initData];
}

- (void)initUI
{
    _navBarView = [[UIView alloc]init];
    _navBarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_navBarView];
    WS(weakSelf)
    [_navBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(@64);
    }];
    
    _navBackImage = [[UIImageView alloc]init];
    [_navBackImage setImage:IMG(@"bg_color")];
    //[_navBackImage setHighlightedImage:IMG(@"shadow")];
    //_navBackImage.alpha = 0.7f;
    [_navBarView addSubview:_navBackImage];
    
    [_navBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    _mHeadImage = [[UIImageView alloc] init];
    _mHeadImage.clipsToBounds = YES;
    [_mHeadImage.layer setBorderWidth:2];
    [_mHeadImage.layer setCornerRadius:18.0f];
    [_mHeadImage.layer setBorderColor:[UIColor whiteColor].CGColor];
    [_navBarView addSubview:_mHeadImage];
    
    [_mHeadImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_navBarView.mas_left).with.offset(15);
        make.top.equalTo(_navBarView.mas_top).with.offset(24);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    
    _mHeadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //_mHeadButton.frame = CGRectMake(15, 20, 44, 44);
    [_mHeadButton addTarget:self action:@selector(userAction:) forControlEvents:UIControlEventTouchUpInside];
    [_navBarView addSubview:_mHeadButton];
    
    [_mHeadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_navBarView.mas_left).with.offset(15);
        make.top.equalTo(_navBarView.mas_top).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    _mActivityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mActivityButton setBackgroundImage:[UIImage imageNamed:@"activity"] forState:UIControlStateNormal];
    [_mActivityButton addTarget:self action:@selector(moreActivityList) forControlEvents:UIControlEventTouchUpInside];
    [_navBarView addSubview:_mActivityButton];
    
    [_mActivityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_navBarView.mas_right).with.offset(-15);
        make.top.equalTo(_navBarView.mas_top).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(21, 23));
    }];
    
    _mMsgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //_mMsgButton.frame = CGRectMake(kScreenWidth - 85.0, 29, 27, 22);
    [_mMsgButton setBackgroundImage:[UIImage imageNamed:@"message_no_tip"] forState:UIControlStateNormal];
    [_mMsgButton addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
    [_navBarView addSubview:_mMsgButton];
    
    [_mMsgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_mActivityButton.mas_left).with.offset(-12);
        make.top.equalTo(_navBarView.mas_top).with.offset(28);
        make.size.mas_equalTo(CGSizeMake(27, 22));
    }];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
//    NSLog(@"%f,%f,%f,%f",self.tableView.contentInset.top,self.tableView.contentInset.left,self.tableView.contentInset.right,self.tableView.contentInset.bottom);
    
    [self initMenus];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [kNotificationCenter addObserver:self selector:@selector(publishSuccessPost) name:PublishSuccessNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(receviceNotication:) name:ReloadMianForLocalNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(receviceNotication:) name:DeletePostNoticaition object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _navBarView.hidden = NO;
    
    if (waitState == Wait_Refresh_ALL)
    {
        [self initData];
        //[GlobInfo shareInstance].bNeedReloadMain = NO;
    }
    else
    {
        if (waitState & Wait_Refresh_Habit)
        {
            [self getHabitsData];
        }
        
        if (waitState & Wait_Refresh_AdScheme)
        {
            [self getAdvanceSchemeInfo];
        }
        
        if (waitState & Wait_Refresh_Banner)
        {
            //刷新banner
            [self getActivitiesData];
        }
        
        if (waitState & Wait_Refresh_TimeLine)
        {
            [self getTimeLineData:YES];
        }
        
        if (waitState & Wait_Refresh_MsgBox)
        {
            [self getUnreadMessageCount];
        }
    }
    
    if (![self.user hasSetUserInfo])
    {
        SetInfoViewController *vc = [[SetInfoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        self.user = [GlobInfo shareInstance].usr;
        [self setUserInfo:self.user];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    waitState = Wait_Refresh_None;
    waitState |= Wait_Refresh_MsgBox;
  //  waitState |= Wait_Refresh_Scheme;
    waitState |= Wait_Refresh_Habit;
    waitState |= Wait_Refresh_AdScheme;
//    waitState |= Wait_Refresh_Banner;
//    waitState |= Wait_Refresh_TimeLine;
    
    _navBarView.hidden = YES;
}

- (void)dealloc
{
    [kNotificationCenter removeObserver:self name:DeletePostNoticaition object:nil];
    [kNotificationCenter removeObserver:self name:ReloadMianForLocalNotification object:nil];
    [kNotificationCenter removeObserver:self name:PublishSuccessNotification object:nil];
}

- (void)setUserInfo:(UserRes*)usr
{
    if (usr.headPortraitUrl.length>0) {
        [self.mHeadImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:usr.headPortraitUrl]] placeholderImage:IMG(@"head_default")];
    }else{
        [self.mHeadImage setImage:IMG(@"head_default")];
    }
}

- (void)initData
{
    WS(weakSelf)
    if ([self.user hasSetUserInfo]) {
        //check网络有效性
        if (![[BaseHFHttpClient shareInstance]bNetReachable])
        {
            [[HFHUDView shareInstance] ShowTips:_T(@"HF_Common_Check_Net") delayTime:1.0 atView:NULL];
            return;
        }
        
//        if (!HUD)
//        {
//            HUD = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
//        }
        
        [weakSelf getTimeLineData:NO];
        [weakSelf getHabitsData];
     //   [weakSelf getSchemeInfo];
        [weakSelf getActivitiesData];
        [weakSelf getUnreadMessageCount];
        [weakSelf getAdvanceSchemeInfo];
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSLog(@"结束了整组的请求队列");
//            if (HUD) {
//                [HUD hide:YES];
//                HUD = nil;
//            }
            [refreshController endRefreshing];
            
        });
    }
}


/**
 刷新时间轴数据， 发表完心情后触发
 **/
-(void)refreshTimeLineDataOnPublishSuccess{

//    if (!HUD)
//    {
//        HUD = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
//    }
    
    [self getTimeLineData:YES];
}


//获取未读消息数
- (void)getUnreadMessageCount
{
    WS(weakSelf)
    [[[HIIProxy shareProxy] messageBoxProxy] hasUnReadMessageWithCompletion:^(HFMessageBoxData * res) {
        [weakSelf resetMessageInfo:res];
    }];
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
//        [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:2]]
//                                  withRowAnimation:UITableViewRowAnimationNone];
        [weakSelf.tableView reloadData];
    } fail:^{
        NSLog(@"离开请求习惯数据");
        dispatch_group_leave(group);
    }];
}

//获取方案信息
- (void)getSchemeInfo
{
    dispatch_group_enter(group);
    WS(weakSelf)
    [[[HIIProxy shareProxy]schemeProxy]loadSchemeInfo:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            LoadSchemeInfoAck *res = (LoadSchemeInfoAck *)ack;
            weakSelf.schemeData = [res.data firstObject];
            [weakSelf.tableView reloadData];
//            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]]withRowAnimation:UITableViewRowAnimationNone];
        }
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
//            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:HFMainCellOrder_AdvanceScheme]]withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf.tableView reloadData];
        }
        else
        {
            DDLogDebug(@"数据少于一个!,请知悉");
        }
        
        //如果第一次进入的话进入导航页
        if (![kUserDefaults boolForKey:@"FirstLunchAdvance"]) {
            [kUserDefaults setBool:YES forKey:@"FirstLunchAdvance"];
            if (!weakSelf.bgGuideView) {
                [weakSelf loadGuideView];
            }
        }

        dispatch_group_leave(group);
    }];
    
}



//获取广告数据
- (void)getActivitiesData
{
    dispatch_group_enter(group);
    WS(weakSelf)
    [[[HIIProxy shareProxy]activityProxy]requestBannerActivitiesPosition:1 complete:^(NSArray *data, BOOL success) {
        if (success) {
            _imageUrls = [weakSelf getImagesFromActivityData:data];
            [weakSelf refreashAdActivity:data];
        }
        dispatch_group_leave(group);
    }];
}

- (void)getTimeLineData:(BOOL)brushFire
{
    dispatch_group_enter(group);
    NSLog(@"开始请求时间条数据");
    WS(weakSelf);
    [[[HIIProxy shareProxy]homeProxy]getTimeLineData:0 direction:0 complete:^(NSArray<Data> *data, BOOL success) {
        if (success) {
            
                [weakSelf.dataSource removeAllObjects];
                [weakSelf.dataSource addObjectsFromArray:data];
                [self calculateCellHeight:data byAdd:NO];
                //NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
//                [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                [weakSelf.tableView reloadData];
            
            Data *da = [data lastObject];
            weakSelf.currentId = (int)da.id;
//            if (brushFire && HUD) {
//                [HUD hide:YES];
//                HUD = nil;
//            }
        }

        NSLog(@"离开请求时间条数据");
        dispatch_group_leave(group);
    }];
}

- (void)resetMessageInfo:(HFMessageBoxData *)res
{
    BOOL bHasMsg = NO;
    if (res.unReadMessage > 0)
    {
        bHasMsg = YES;
        
    }
    [self updateIcon:bHasMsg];
    
    //将其他存入到缓存中
    [mMessageArray removeAllObjects];
    [mMessageArray addObject:@(res.unReadComentCount)];
    [mMessageArray addObject:@(res.unReadPraiseCount)];
    [mMessageArray addObject:@(res.unReadFollowCount)];
    [mMessageArray addObject:@(res.unReadSystemCount)];
}

#pragma mark - QuadCurveMenuDelegate
- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
{
    DDLogDebug(@"on item select idx = %ld" ,(long)idx);
    self.bgLabel.hidden = YES;
    if (idx == 0){
        [MobClick endEvent:Home_Find];
        FindViewController *vc = [[FindViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        

    }
    else if (idx == 1){
        [MobClick endEvent:Home_HabitBox];
        HFBoxViewController *boxVC = [[HFBoxViewController alloc]init];
        [self.navigationController pushViewController:boxVC animated:YES];
    }
    else if (idx == 2)
    {
        NSString * bandId = [GlobInfo shareInstance].usr.bandDeviceId;
        
        BOOL  bBind = YES;
        if (bandId == nil || [bandId isEqualToString:@""])
        {
            bBind = NO;
        }
        
        if (![GlobInfo shareInstance].bDisplayBandView && !bBind)
        {
            HFBandViewController *vc = [[HFBandViewController alloc]initWithNibName:@"HFBandViewController" bundle:nil];
            vc.delegate = self;
            
            [self presentViewController:vc animated:YES completion:^{
                
            }];
            [[GlobInfo shareInstance]setBDisplayBandView:YES];
        }else {
            HFDevInfoViewController *vc = [[HFDevInfoViewController alloc]initWithNibName:@"HFDevInfoViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (idx == 3){
        
        // 发表心情贴
        SentPostViewController *sc = [[SentPostViewController alloc]init];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:FromPersonal forKey:kParamFrom];
        sc.param = dic;
        [self.navigationController pushViewController:sc animated:YES];
        
    }
    else if (idx == 4){
//            // 我的个人中心
//        [MobClick endEvent:Home_MyInfo];
//        UserInfoViewController *vc = [[UserInfoViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (void)goSignThreeViewController
{
    SignThreeViewController *vc = [[SignThreeViewController alloc]initWithNibName:@"SignThreeViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

//初始化菜单按钮
- (void)initMenus
{
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"icon_prison"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"icon_prison"];
    
    // Camera MenuItem.
    QuadCurveMenuItem *cameraMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[UIImage imageNamed:@"icon_find"]
                                                        highlightedContentImage:nil];
    // People MenuItem.
    QuadCurveMenuItem *peopleMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[UIImage imageNamed:@"icon_hi"]
                                                         highlightedContentImage:nil];
    // Place MenuItem.
    QuadCurveMenuItem *placeMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[UIImage imageNamed:@"icon_prison"]
                                                        highlightedContentImage:nil];
    
    // publish MenuItem.
    QuadCurveMenuItem *publishMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[UIImage imageNamed:@"add_note"]
                                                        highlightedContentImage:nil];
    
    // band MenuItem.
    QuadCurveMenuItem *bandMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                 highlightedImage:storyMenuItemImagePressed
                                                                     ContentImage:[UIImage imageNamed:@"foot"]
                                                          highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:cameraMenuItem, peopleMenuItem,bandMenuItem, publishMenuItem,placeMenuItem, nil];
    QuadCurveMenu *menu = [[QuadCurveMenu alloc]initWithFrame:kScreenBounds menus:menus];
    menu.delegate = self;
    [self.view addSubview:menu];
    
    refreshController = [[HFRefreshController alloc]initWithScrollView:self.tableView viewDelegate:self];
}

- (void)goUserCenter:(NSInteger)userId
{
    if (userId<=0) {
        return;
    }
    UserCenterViewController *vc = [[UserCenterViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:userId] forKey:kParamUserId];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

//进入消息盒子
- (void)messageAction:(UIButton *)sender
{
    [MobClick event:Home_Message_Icon_Click];
    HFMessageViewController * messageViewController = [[HFMessageViewController alloc] init];
    messageViewController.mSourceMessageCountArr = mMessageArray;
    messageViewController.delegate = self;
    [self.navigationController pushViewController:messageViewController animated:YES];
}

//查看用户个人中心
- (void)userAction:(UIButton *)sender
{
    [MobClick event:Home_Head_Click];
    [self goUserCenter:(int)self.user.id];
}

/**
 *  进入到页面跳转流程
 */
- (void)goSchemeInfo
{
    if (self.schemeData.isSubscribe)
    {
        if (self.schemeData.isOver)
        {
            
                //仅完成结束页
                HFUnlockViewController * unlockController = [[HFUnlockViewController alloc] initWithType:HFReStart];
                unlockController.schemeData = self.schemeData;
                [self.navigationController pushViewController:unlockController animated:YES];
        }
        else
        {
            if (self.schemeData.isJumpOverPage)
            {
                //仅完成结束页
                HFUnlockViewController * unlockController = [[HFUnlockViewController alloc] initWithType:HFOver];
                unlockController.schemeData = self.schemeData;
                [self.navigationController pushViewController:unlockController animated:YES];
            }
            else
            {
                if (!self.schemeData.isDeblocking)
                {
                    NSInteger type = 0;
                    if (self.schemeData.currStage == 1) {
                        type = 2;//强化阶段
                    }
                    if (self.schemeData.currStage == 2) {
                        type = 3;//维稳阶段
                    }
                    HFUnlockViewController * unlockController = [[HFUnlockViewController alloc] initWithType:type];
                    unlockController.schemeData = self.schemeData;
                    [self.navigationController pushViewController:unlockController animated:YES];
                }
                else
                {
                    [MobClick event:Scheme_MainPageScheme_Click];
                    HFHealthViewController * healthViewController = [[HFHealthViewController alloc] init];
                    healthViewController.mSchemeDay = self.schemeData.currDay;
                    [self.navigationController pushViewController:healthViewController animated:YES];
                }
            }
                
            
            
        }
        
    }
    else
    {
        [self goIntroduceVC];
    }

}

- (void)goIntroduceVC
{
    HFIntroduceViewController * introduceVC = [[HFIntroduceViewController alloc] init];
    introduceVC.schemeInfo = self.schemeData;
    introduceVC.needShowGuideView = YES;
    [self.navigationController pushViewController:introduceVC animated:YES];
}

#pragma mark -
#pragma mark NSNoticationProcesser

- (void)receviceNotication:(NSNotification *)notication
{
    WaitRefreshState state =  [[notication object] integerValue];
    
    if (state == Wait_Refresh_ALL)
    {
        waitState = Wait_Refresh_ALL;
    }
    else
    {
        waitState |= state;
    }
}

//删除时间抽的分享消息
- (void)deleteMessage:(NSInteger)messageId atIndex:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    [[[HIIProxy shareProxy]homeProxy]deleteMessage:messageId success:^(BOOL finished) {
        if (finished) {
            [weakSelf.dataSource removeObjectAtIndex:indexPath.row];
            [weakSelf.heights removeObjectAtIndex:indexPath.row];
            [weakSelf.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section != HFMainCellOrder_Post)
    {
        return 1;
    }
    else
    {
        return self.dataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == HFMainCellOrder_Banner) {
//        HFBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HFBannerCell"];
//        if (!cell) {
//            cell = [[HFBannerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HFBannerCell"];
//            cell.delegate = self;
//        }
//        if (self.imageUrls.count>0) {
//            [cell setBannerToCell:self.imageUrls];
//        }
//        return cell;
//    }
//    else if (indexPath.section == HFMainCellOrder_Habit) {
//        
//        HFHabitHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HFHabitHeaderCell"];
//        if (!cell)
//        {
//            cell = [[HFHabitHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HFHabitHeaderCell"];
//            cell.delegate = self;
//        }
//        [cell headerTitle:@"我的习惯"];
//        cell.itemType = HFItemTypeHabit;
//        //cell.separatorLine.hidden = YES;
//        [cell setHabitsToCell:self.habits];
//        return cell;
//    }
////    else if (indexPath.section == HFMainCellOrder_PrimaryScheme)
////    {
////        NSInteger index = 2;
////        NSString *indentifier = @"HFSchemeStartCell";
////        if (self.schemeData) {
////            if (self.schemeData.isSubscribe) {
////                if (self.schemeData.isOver) {
////                    index = 1;
////                    indentifier = @"HFSchemeEndCell";
////                }else {
////                    index = 0;
////                    indentifier = @"HFSchemeIngCell";
////                }
////            }
////        }
////        HFSchemeCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
////        if (!cell) {
////            cell= [[HFSchemeCell alloc]initWithIndex:index];
////        }
////        if ( index == 2) {
////            [cell.useBtn addTarget:self action:@selector(goIntroduceVC) forControlEvents:UIControlEventTouchUpInside];
////        }else {
////            [cell.infoBtn addTarget:self action:@selector(goIntroduceVC) forControlEvents:UIControlEventTouchUpInside];
////        }
////        [cell setContent:self.schemeData];
////        return cell;
////    }
//    else if (indexPath.section == HFMainCellOrder_AdvanceScheme)
//    {
//        NSString *indentifier;
//        
//        
//        
//        AdvanceSchemeType type = [HFAdvanceSchemeCell cellTypeForData:self.adSchemeData];
//        NSInteger index;
//        if (type == AdvanceScheme_None)
//        {
//            indentifier = @"adScheme_none";
//            index = 1;
//        }
//        else if (type == AdvanceScheme_One)
//        {
//            indentifier = @"adScheme_one";
//            index = 0;
//        }
//        else if (type == AdvanceScheme_Begin)
//        {
//            indentifier = @"adScheme_begin";
//            index = 3;
//        }
//        else
//        {
//            indentifier = @"adScheme_more";
//            index = 2;
//        }
//        if (self.adSchemeData)
//        {
//            HFAdvanceSchemeCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
//            if (!cell)
//            {
//                cell= [[HFAdvanceSchemeCell alloc]initWithIndex:index];
//                cell.delegate = self;
//            }
//            [cell setContentData:self.adSchemeData];
//            return cell;
//        }
//        else
//        {
//            return [[UITableViewCell alloc]init];
//        }
//        
//        
//    }
//    else
//    {
//        Data *data = [self.dataSource objectAtIndex:indexPath.row];
//        if (data.source == GZTimeLineTypeFriendPost) {
//            PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
//            if (cell == nil) {
//                cell = [[PostCell alloc]initWithIndex:1];
//                cell.delegate = self;
//            }
//            PostDetailData *post = [[PostDetailData alloc]init];
//            [post copyFromData:data];
//            [cell setContentToCell:post];
//            return cell;
//        }else if (data.source == GZTimeLineTypeShareModulariry) {
//            MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareModuleCell"];
//            if (!cell) {
//                cell = [[MainTableViewCell alloc]initWithIndex:0];
//                cell.delegate = self;
//            }
//            [cell setContentToCell:data];
//            return cell;
//        }
//    }
    return [[UITableViewCell alloc]init];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != HFMainCellOrder_Post)
    {
        return NO;
    }
    Data *data = [self.dataSource objectAtIndex:indexPath.row];
    if (data.source == GZTimeLineTypeShareModulariry)
    {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Data *data = [self.dataSource objectAtIndex:indexPath.row];
    
    [self deleteMessage:data.id atIndex:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[HFBannerCell class]]) {
        return;
    }else if ([cell isKindOfClass:[HFSchemeCell class]]) {
        [self goSchemeInfo];
    }else if ([cell isKindOfClass:[HFHabitHeaderCell class]]) {
        return;
    }else if ([cell isKindOfClass:[PostCell class]]) {
        Data *data = [self.dataSource objectAtIndex:indexPath.row];
        self.currentIndex = (int)indexPath.row;
        PostDetailData *post = [[PostDetailData alloc]init];
        [post copyFromData:data];
        [self pushToCommentDetail:post];
    }
    else if ([cell isKindOfClass:[MainTableViewCell class]]){
        Data *data = [self.dataSource objectAtIndex:indexPath.row];
        self.currentIndex = (int)indexPath.row;
        [self deleteMessage:data.id atIndex:indexPath];
        [[UIKitTool getAppdelegate]goModuleDetail:data.modelId];
    }else if ([cell isKindOfClass:[HFAdvanceSchemeCell class]]) {
        
        if (self.adSchemeData.isSubscribe)
        {
            [self detailSchemeClick:self.adSchemeData.id];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section != HFMainCellOrder_Post)
    {
        
        if (indexPath.section == HFMainCellOrder_Banner)
        {
            return kScreenWidth/kBannerScale;
        }
        else if (indexPath.section == HFMainCellOrder_Habit)
        {
            return 133.0f;
            
        }
        else if (indexPath.section == HFMainCellOrder_AdvanceScheme)
        {
            return [HFAdvanceSchemeCell cellHeightForData:self.adSchemeData atIndex:indexPath.row];
        }
        else
        {
            return 127.0f;
        }
        
    }
    else
    {
        if (indexPath.row < [self.heights count])
        {
            return [[self.heights objectAtIndex:indexPath.row] floatValue];
        }
        else
        {
            return 0;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section != HFMainCellOrder_Banner && section != HFMainCellOrder_Post)
    {
        return 10.0f;
    }
    else {
        return 0.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section != HFMainCellOrder_Post)
    {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
        view.backgroundColor = [UIColor HFColorStyle_6];
        return view;
    }
    else
    {
        return nil;
    }
    
}

//点击未完成
- (void)finishedAction:(UIButton*)bt
{
    //NSLog(@"%ld",(long)bt.tag);
    if (bt.selected) {
        return;
    }
    bt.selected = YES;
    Data *data = [self.dataSource objectAtIndex:bt.tag];
    
    data.finished = 1;
    
    [self.dataSource replaceObjectAtIndex:bt.tag withObject:data];
    
    SentPostViewController *vc = [[SentPostViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:data.habitId] forKey:kParamHabitId];
    [dic setObject:FromHabit forKey:kParamFrom];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)endRefresh
{
    [self initData];
}

- (void)endLoadMore
{
    if (!HUD)
    {
        HUD = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    }
    WS(weakSelf);
    [[[HIIProxy shareProxy]homeProxy]getTimeLineData:_currentId direction:1 complete:^(NSArray<Data> *data, BOOL success) {
        if (success) {
            if (data.count>0) {
                [weakSelf.dataSource addObjectsFromArray:data];
                [self calculateCellHeight:data byAdd:YES];
                [weakSelf.tableView reloadData];
            }
            Data *d = [weakSelf.dataSource lastObject];
            weakSelf.currentId = (int)d.id ;
        }
        [HUD hide:YES];
        HUD = nil;
    }];
}

#pragma mark - refresh delegate

- (void)beginPullDownRefreshing
{
    //[self performSelector:@selector(endRefresh) withObject:nil afterDelay:1];
    [self endRefresh];
}

- (void)beginPullUpLoading
{
    [self endLoadMore];
}

- (CLLRefreshViewLayerType)refreshViewLayerType
{
    return CLLRefreshViewLayerTypeOnSuperView;
}

- (BOOL)hasRefreshFooterView
{
    return YES;
}

- (void)quadCurveMenuTouchesBeganExpanding:(BOOL)expanding
{
    self.bgLabel.hidden = !expanding;
}

#pragma mark -
#pragma mark private


- (NSMutableArray *)activities
{
    if (!_activities) {
        _activities = [[NSMutableArray alloc]init];
    }
    return _activities;
}

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

- (void)publishSuccessPost
{
    [self performSelector:@selector(refreshTimeLineDataOnPublishSuccess) withObject:nil afterDelay:3.0];
}

- (void)calculateCellHeight:(NSArray *)datas byAdd:(BOOL)bAdd
{
    
    if (!bAdd)
    {
        [self.heights removeAllObjects];
    }
    
    NSInteger index;
    if (bAdd)
    {
        index = [self.heights count];
    }
    else
    {
        index = 0;
    }
    
    for (NSInteger i = index; i < [datas count] + index; i++)
    {
        CGFloat height;
        Data *data = [self.dataSource objectAtIndex:i];
        if (data.source == GZTimeLineTypeFriendPost)
        {
            PostDetailData *post = [[PostDetailData alloc]init];
            [post copyFromData:data];
            HFCaculateHeightModel * model = [UIKitTool heightForEmojiText:post isMainView:YES];
            //此处加上判断，是否大于最大的行数
            data.expandFlag = model.state;
            height = model.cellHeight;
        }
        else
        {
            height = 70;
        }
        [self.heights addObject:@(height)];
    }
}

- (void)refreashAdActivity:(NSArray *)data
{
    if (self.activities) {
        [self.activities removeAllObjects];
    }
    [self.activities addObjectsFromArray:data];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}


- (void)pushToCommentDetail:(PostDetailData *)post
{
    HFCommentViewController * commentController = [[HFCommentViewController alloc] init];
    commentController.mWbType = post.type;
    commentController.delegate = self;
    commentController.mWbID = post.weiboId;
    commentController.mDetailData = post;
    [self.navigationController pushViewController:commentController animated:YES];
}

- (void)updateIcon:(BOOL)bHasMessage
{
    if (bHasMessage)
    {
        [_mMsgButton setBackgroundImage:[UIImage imageNamed:@"message_tip"] forState:UIControlStateNormal];
    }
    else
    {
        [_mMsgButton setBackgroundImage:[UIImage imageNamed:@"message_no_tip"] forState:UIControlStateNormal];
    }
}
- (void)dismissGuideView
{
    self.bgGuideView.hidden = YES;
    [self.bgGuideView removeFromSuperview];
}
- (void)loadGuideView
{
    self.bgGuideView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (IS_SCREEN_35_INCH) {
        self.bgGuideView.frame = CGRectMake(- 55, -187, 375, 667);
    }
    if (IS_SCREEN_4_INCH) {
        self.bgGuideView.frame = CGRectMake(- 55, -99, 375, 667);
    }
    self.bgGuideView.userInteractionEnabled = YES;
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.bgGuideView];
    self.bgGuideView.image = IMG(@"advanceGuide");
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissGuideView)];
    [self.bgGuideView addGestureRecognizer:tapGesture];

}
#pragma mark postCell delegate

- (void)commentEventWithType:(COMMENT_OPERATE_TYPE)type withCell:(PostCell *)cell
{
    NSInteger index = [self.tableView indexPathForCell:cell].row;
   
    Data * data = [self.dataSource objectAtIndex:index];
    PostDetailData *post = [[PostDetailData alloc]init];
    [post copyFromData:data];
    if (type == MSG_COMMENT_TYPE)
    {
        [self pushToCommentDetail:post];
    }
    else
    {
        WS(weakSelf)
        HFSubmitPraiseReq *req = [[HFSubmitPraiseReq alloc]init];
        req.weiboType = post.type;
        req.weiboId = post.weiboId;
        
        [[[HIIProxy shareProxy]weiboProxy]submitPraiseType:req complete:^(ResponseData * responseData) {
            if ([responseData success]) {
                data.praiseNum = data.isPraise == 1 ? data.praiseNum - 1 : data.praiseNum + 1;
                data.isPraise = data.isPraise == 1 ? 0 : 1;
                [post copyFromData:data];
                [cell updateCellWithData:post];
                
                [weakSelf.dataSource replaceObjectAtIndex:index withObject:data];
            }else {
                [MBProgressHUD showError:responseData.msg toView:self.view];
            }
        }];
    }
}

- (void)updateCellExpand:(BOOL)bExpand withCell:(PostCell *)cell
{
    NSIndexPath * indexpath = [self.tableView indexPathForCell:cell];
    
    Data *data = [self.dataSource objectAtIndex:indexpath.row];
    if (data.source == GZTimeLineTypeFriendPost)
    {
        if (bExpand)
        {
            data.expandFlag = PostExpandExpand;
        }
        else
        {
            data.expandFlag = PostExpandUnExpand;
        }
        
        PostDetailData *post = [[PostDetailData alloc]init];
        [post copyFromData:data];
        HFCaculateHeightModel * model = [UIKitTool heightForEmojiText:post isMainView:YES];
        [self.heights replaceObjectAtIndex:indexpath.row withObject:@(model.cellHeight)];
        
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

#pragma mark -
#pragma mark HFCommentViewControllerDelegate
- (void)updatePostData:(PostDetailData *)data
{
    Data *d = [self.dataSource objectAtIndex:self.currentIndex];
    d.isPraise = data.praised;
    d.praiseNum = data.praiseNum;
    d.commentNum = data.commentNum;
    [self.dataSource replaceObjectAtIndex:self.currentIndex withObject:d];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark HFmessageInofViewControllerDelegate
- (void)updateMessageBoxIcon:(BOOL)bHasMessage
{
    [self updateIcon:bHasMessage];
}

#pragma mark -
#pragma mark ActivityCellDelegate
- (void)moreActivityList
{
    HFActivityListViewController * activityList = [[HFActivityListViewController alloc] init];
    
    //TestSchemeViewController * activityList = [[TestSchemeViewController alloc] init];

    [self.navigationController pushViewController:activityList animated:YES];
}

#pragma mark - post cell delegate

- (void)goUserCenterView:(NSInteger)userId
{
    [self goUserCenter:userId
     ];
}

#pragma mark habitHeaderDelegate
//跳到添加习惯页面（H5）
- (void)addActionWithCell:(HFHabitHeaderCell *)cell
{
    WebViewController *vc = [[WebViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:kURLHabitList forKey:kParamURL];
    [dic setObject:KEY_ADD_HABIT forKey:kParamFrom];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}
//查看自己的所有的习惯列表
- (void)moreActionWithCell:(HFHabitHeaderCell *)cell
{
    HFHabitViewController *vc = [[HFHabitViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
//跳到模块或详情页面
- (void)goDetailAction:(CommonItem *)item withCell:(HFHabitHeaderCell *)cell
{
    HFHabitRecordViewController *vc = [[HFHabitRecordViewController alloc]initWithNibName:@"HFHabitRecordViewController" bundle:nil];
    HFHabitListData *habit = (HFHabitListData*)item.data;
    vc.habitId = habit.habitId;
    vc.habitName = habit.habitName;
    vc.habitIconUrl = habit.habitIconUrl;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrolViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    _navBackImage.alpha = MIN(scrollView.contentOffset.y/(kScreenWidth/kBannerScale), 1)*0.7f;
    if (scrollView.contentOffset.y>0) {
        [_navBackImage setHighlighted:NO];
        _navBackImage.alpha = 0.5f;
    }else {
        [_navBackImage setHighlighted:YES];
        _navBackImage.alpha = 0;
    }
}

#pragma mark - HFBannerCellDelegate

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
#pragma mark HFAdvanceSchemeCellDelegate
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
//    WS(weakSelf)
//    [[[HIIProxy shareProxy] schemeProxy] modifyScheme:schemeID schemeStatus:HFModifySchemeTypeStart withBlock:^(HF_BaseAck *ack) {
//        
//        if ([ack sucess])
//        {
            HFAdvanceSchemeContainerViewController * advCtrl = [[HFAdvanceSchemeContainerViewController alloc] init];
            advCtrl.adSchemeID = schemeID;
            advCtrl.bBeginUse = YES;
            [self.navigationController pushViewController:advCtrl animated:YES];
//        }
//        
//    }];
}

#pragma mark - HFRefreshControllerDelegate

- (void)startRefreshing
{
    [self initData];
}

- (BOOL)hasMoreData
{
    return YES;
}

- (void)loadMoreData
{
    [self endLoadMore];
}

#pragma mark - HFDismiss

- (void)dismissBandView:(UIViewController *)vc
{
    WS(weakSelf)
    [vc dismissViewControllerAnimated:NO completion:^{
        HFBindingViewController *vc = [[HFBindingViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

@end
