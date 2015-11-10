//
//  HFHealthViewController.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/7/30.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHealthViewController.h"
#import "HFHealthHelper.h"
#import "HFHealthHelper+Stomach.h"
#import "HFHealthCell.h"
#import "HFEditDiaryViewController.h"
#import "HFFoodListViewController.h"
#import "HFGoodIdeaViewController.h"
#import "HFPostBarController.h"
#import "HFVideoViewController.h"
#import "HFGiveUpView.h"
#import "StepCounterManager.h"
#import "LoadSchemeDataAck.h"
#import "HFDayPickerModel.h"
#import "GetDiaryDataByDayAck.h"
#import "GetFoodsByDayAck.h"
#import "GetSportDataByDayAck.h"
#import "WebViewController.h"
#import "GetRunningDataAck.h"
#import "GetSchemeDayInfoAck.h"
#import "GetSportPageDataAck.h"
#import "HFStepCounterErrorViewController.h"
#import "UIViewController+Customize.h"

#define kShowGuideHealth @"showGuideHealth"
typedef void (^prizeBlock) (BOOL);

@interface HFHealthViewController ()<UITableViewDataSource,UITableViewDelegate,HFHealthCellDelegate, HFGiveUpViewDelegate,StepCounterManagerDelegate,HFEditDiaryViewControllerDelegate,HFVideoViewControllerDelegate,HFFoodListViewControllerDelegate>
{

    
    NSInteger mCurrentDay;
    
    NSInteger  offsetDay;
    
    SchemeReqType mReqType;
    
    BOOL    bHistory;
    
    BOOL    bStrongStage;
    
    NSInteger  mStageId;
    
    BOOL    bReqSportData;
}
@property(nonatomic,strong)NSArray * mReuseIDs;
@property(nonatomic,strong)HFHealthHelper * mHelper;
@property(nonatomic,strong)HFGiveUpView * giveUpView;
@property(nonatomic,strong)HFDayPickerModel * dayPickerModel;
@property(nonatomic,strong)GetDiaryDataByDayAck * mDiaryData;
@property(nonatomic,strong)GetFoodsByDayAck * mFoodData;
@property(nonatomic,strong)GetSportDataByDayAck * mSportData;
@property(nonatomic,strong)GetRunningDataAck * mWalkData;
@property(nonatomic,strong)GetSchemeDayInfoAck * mDayInfoData;
@property(nonatomic,strong)UIView * bgGuideView;
@end

@implementation HFHealthViewController

- (void)awakeFromNib
{
    self.mHelper = [[HFHealthHelper alloc] initWithType:TodayType];
}

#pragma mark -
#pragma mark lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    bReqSportData = YES;    //是否需要请求
    
    self.mReuseIDs = [[NSArray alloc] initWithObjects:@"dayCell",@"eatCell",@"walkCell",@"contextCell",@"sportCell",@"moreCell", nil];
    
    [self addRightBarItemWithTitle:@"放弃调理"];
    [self addNavigationTitle:@"颈椎调理"];
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.mMainTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.mMainTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    mCurrentDay = self.mSchemeDay;
    bHistory = NO;
    mReqType = SchemeReq_Unknow;

    [self getDayInfo];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (mReqType ==  SchemeReq_Unknow)
    {
        return;
    }
    
    if (mReqType == SchemeReq_Eat)
    {
        [self getFoodInfo];
    }
    else if (mReqType == SchemeReq_Diary)
    {
        [self getDiaryData];
    }
    else
    {
        [self getSportsData];
    }
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //获取步数
    [[StepCounterManager sharedManager] setDelegate:self];
    [[StepCounterManager sharedManager] start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)leftBarItemAction:(id)sender
{
    
    HFHealthCell * cell = (HFHealthCell *)[self.mMainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.day_coverView = nil;
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark private
/**
 *  请求某一日的所有方案数据
 */

- (void)reqSchemeInfo
{
    [self getFoodInfo];
    [self getSportStep];
    [self getSportsData];
    [self getDiaryData];
}

- (void)requsetPrizeScoreSubSchemeid:(NSInteger)subid completion:(prizeBlock)block
{
    
    AddSchemeScoreArg * arg = [[AddSchemeScoreArg alloc] init];
    arg.schemeId = 1;
    arg.subSchemeId = subid;
    arg.day = mCurrentDay;
    [[HIIProxy shareProxy].schemeProxy addSchemeScore:arg withBlock:^(HF_BaseAck *ack) {
        BOOL success = NO;
        if ([ack sucess])
        {
            success = YES;
            //去更新User的数据
            [[[HIIProxy shareProxy]userProxy]getUserInfo:^(BOOL finished) {
                
            }];
        }
        block(success);
    }];
}


/**
 *  获取cell上面的数据源
 *
 *  @param indexPath
 *
 *  @return 各个section对应的数据源
 */
- (id)retDataAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return self.mDayInfoData;
    }
    else if (indexPath.section == 1)
    {
        return self.mFoodData;
    }
    else if (indexPath.section == 2)
    {
        return self.mWalkData;
    }
    else if (indexPath.section == 3)
    {
        return self.mDiaryData;
    }
    else if (indexPath.section == 4)
    {
        return self.mSportData;
    }
    else if (indexPath.section == 5)
    {
        return  self.mDayInfoData;
    }
    else
    {
        return nil;
    }
}

- (BOOL)cellInVisiable:(NSInteger)index
{
    return YES;
    
    BOOL bVisiable = NO;
    
    NSArray * cells = [self.mMainTableView visibleCells];
    
    for (int i = 0; i < [cells count]; i++)
    {
        HFHealthCell * cell = [cells objectAtIndex:i];
        NSInteger section = [self.mMainTableView indexPathForCell:cell].section;
        
        if (section == index)
        {
            bVisiable = YES;
        }
    }
    
    return bVisiable;
    
}


//获取到数据的运动一下
- (void)getSportsData
{
    
    
    WS(weakSelf)
    [[HIIProxy shareProxy].schemeProxy  getSportDataByDay:mCurrentDay withBlock:^(HF_BaseAck *ack) {
        
        mReqType = SchemeReq_Unknow;
        GetSportDataByDayAck * data = (GetSportDataByDayAck *)ack;
        weakSelf.mSportData = data;
        
        bReqSportData = NO;
        
        if ([weakSelf cellInVisiable:4])
        {
//            HFHealthCell * cell = (HFHealthCell *)[weakSelf.mMainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
//            [cell setContentData:weakSelf.mSportData withType:SportCell_Type];
            
            [weakSelf.mMainTableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
        }
        
    }];
}


//获取健康日记
- (void)getDiaryData
{
    WS(weakSelf)
    [[HIIProxy shareProxy].schemeProxy getDiaryDataByDay:mCurrentDay withBlock:^(HF_BaseAck *ack) {
        
        mReqType = SchemeReq_Unknow;
        //这里需要刷新的是visiableCell
        GetDiaryDataByDayAck * data = (GetDiaryDataByDayAck *)ack;
        weakSelf.mDiaryData = data;
        
        if ([weakSelf cellInVisiable:3])
        {
//            HFHealthCell * cell = (HFHealthCell *)[weakSelf.mMainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
//            [cell setContentData:weakSelf.mDiaryData withType:ContextCell_Type];
            
            [weakSelf.mMainTableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
        }
        
    }];
    //所有获取完了再新手引导页
//    if (self.needShowGuideView) {
//        if (![kUserDefaults boolForKey:@"FirstLunchHealth"])
//        {
//            [kUserDefaults setBool:YES forKey:@"FirstLunchHealth"];
//            if (!self.bgGuideView) {
//                [self loadGuideView];
//            }
//        }
//        
//    }
}

//获取运动步数
- (void)getSportStep
{
//    if (!bHistory && !bReqSportData)
//    {
//        if ([self cellInVisiable:2])
//        {
//            [self.mMainTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
//        }
//        return;
//    }
    
    WS(weakSelf)
    [[HIIProxy shareProxy].schemeProxy getRunningDataByDay:mCurrentDay withBlock:^(HF_BaseAck *ack) {
        GetRunningDataAck * data = (GetRunningDataAck *)ack;
        weakSelf.mWalkData = data;
        
        if ([weakSelf cellInVisiable:2])
        {
            [weakSelf.mMainTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)getDayInfo
{
    WS(weakSelf)
    [[HIIProxy shareProxy].schemeProxy getSchemeInfoByDay:mCurrentDay withBlock:^(HF_BaseAck *ack) {
        
        
        
        GetSchemeDayInfoAck * data = (GetSchemeDayInfoAck *)ack;
        weakSelf.mDayInfoData = data;
        if ([weakSelf cellInVisiable:0])
        {
            HFHealthCell * cell = (HFHealthCell *)[weakSelf.mMainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            if (data.data.currDay == self.mSchemeDay)
            {
                offsetDay = data.data.offsetDay;
            }
            
            for (int i = 0; i < [data.data.list count]; i++) {
                GetSchemeDayInfoList * listData = [data.data.list objectAtIndex:i];
                
                if (listData.flag)
                {
                    mStageId = listData.schemeStageId;
                }
            }
            
            
            [cell setContentData:weakSelf.mDayInfoData withType:DayCell_Type isHistoryDay:bHistory withObject:@(offsetDay)];
            
//            if ([weakSelf.mDayInfoData.data.stageName isEqualToString:@"强化阶段"])
//            {
//                bStrongStage = YES;
//            }
//            else
//            {
//                bStrongStage = NO;
//            }
         //   [weakSelf.mMainTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
        [self reqSchemeInfo];
        
    }];
}

- (void)getFoodInfo
{
    WS(weakSelf)
    [[HIIProxy shareProxy].schemeProxy getFoodsByDay:mCurrentDay withBlock:^(HF_BaseAck *ack) {
        
        
        mReqType = SchemeReq_Unknow;
        
        GetFoodsByDayAck * data = (GetFoodsByDayAck *)ack;
        weakSelf.mFoodData = data;
        
        if ([weakSelf cellInVisiable:1])
        {
//            HFHealthCell * cell = (HFHealthCell *)[weakSelf.mMainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
//            [cell setContentData:weakSelf.mFoodData withType:EatCell_Type];
            
            [weakSelf.mMainTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}


- (void)rightBarItemAction:(id)sender
{
    [MobClick event:Scheme_GiveUp_Click];
    [self.giveUpView show];
}

- (void)dismissGuideView
{
    self.bgGuideView.hidden = YES;
    [self.bgGuideView removeFromSuperview];
}
//- (void)loadGuideView
//{
//    self.bgGuideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.bgGuideView];
//    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissGuideView)];
//    [self.bgGuideView addGestureRecognizer:tapGesture];
//    HFGuideView * scoreView = [[HFGuideView alloc] initWithFrame:CGRectMake(kScreenWidth - 30 - 130, 64 + 128, 150, 50)];
//    scoreView.smallImageView.frame = CGRectMake(scoreView.frame.size.width - 25, scoreView.smallImageView.frame.origin.y, 12, 6);
//    scoreView.textLabel.text = @"做任务赚积分";
//    [self.bgGuideView addSubview:scoreView];
//    
//    HFGuideView * dietView = [[HFGuideView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(scoreView.frame) - 10, 140, 50)];
//    dietView.textLabel.text = @"在这里 打卡吃饭";
//    [self.bgGuideView addSubview:dietView];
//    
//    HFGuideView * stepView = [[HFGuideView alloc] initWithFrame:CGRectMake(30, 490, 100, 50)];
//    stepView.textLabel.text = @"系统自动计步";
//    [self.bgGuideView addSubview:stepView];
//
//}
#pragma mark -
#pragma mark UITableViewDelegate && UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFHealthCell * cell = [tableView dequeueReusableCellWithIdentifier:[self.mReuseIDs objectAtIndex:indexPath.section]];
    
    if (!cell)
    {
        cell = [[HFHealthCell alloc] initWithIndex:indexPath.section];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cellType type = (cellType)indexPath.section;
    
    id data = [self retDataAtIndexPath:indexPath];
    
    
    if (type == SportCell_Type)
    {
        [cell setContentData:data withType:type isHistoryDay:bHistory withObject:@(mStageId)];
    }
    else if (type == DayCell_Type)
    {
        [cell setContentData:data withType:type isHistoryDay:bHistory withObject:@(offsetDay)];
    }
    else
    {
        [cell setContentData:data withType:type isHistoryDay:bHistory withObject:nil];
    }
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [HFHealthCell heightForHealthCell:[self retDataAtIndexPath:indexPath] atIndexPath:indexPath];
    
    return height;
}


#pragma mark -
#pragma mark StepCounterManagerDelegate
- (void)StepCounterManagerStepCountsChanged:(NSInteger)StepCounts
{
    //NSLog(@"~~~~~~~~~~记步步数:%ld",StepCounts);
    __block NSInteger currentSteps;
    WS(weakSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([StepCounterManager sharedManager].stepCounterIsAvaliable)
        {
            currentSteps = StepCounts;
            //判断是否是当前
        }
        else
        {
            //当前无法记步
            currentSteps = -1;
        }
        
        NSArray * arrats = [weakSelf.mMainTableView indexPathsForVisibleRows];
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        
        if ([arrats containsObject:indexPath])
        {
            
            if (bHistory)
            {
                return;
            }
            HFHealthCell * cell = (HFHealthCell *)[weakSelf.mMainTableView cellForRowAtIndexPath:indexPath];
            [cell resetWalkSteps:currentSteps withTargetSteps:weakSelf.mWalkData.data.targetStep];
            
            if (currentSteps >= weakSelf.mWalkData.data.targetStep)
            {
                if (!weakSelf.mWalkData.data.isOK)
                {
                    //NSLog(@"步数进行了上报 %ld",currentSteps);
                    [[StepCounterManager sharedManager] uploadStepCounts:currentSteps dayIndex:mCurrentDay withFinishBlock:^{
                        [self getSportStep];
                    }];
                }
            }
        }
    });
}

#pragma mark -
#pragma mark HFHealthCellDelegate
- (void)healthCellReponseEvent:(cellEventType)type withObject:(id)object
{
    
    if (type == more_tips_Event) {
        [MobClick event:Scheme_GoodIdea_Click];
        HFGoodIdeaViewController * goodIdeaVC = [[HFGoodIdeaViewController alloc] init];
        goodIdeaVC.schemeData = self.mDayInfoData.data;
        [self.navigationController pushViewController:goodIdeaVC animated:YES];
    }
    if (type == more_forum_Event) {
        [MobClick event:Scheme_PostBar_Click];
        HFPostBarController * postBarVC = [[HFPostBarController alloc] init];
        postBarVC.schemeId = self.mDayInfoData.data.schemeId;
        [self.navigationController pushViewController:postBarVC animated:YES];
    }
    if (type == eat_Event)
    {
        NSInteger mealType = [object integerValue];
        
        dayFoodType type;
        BOOL hasPreView;
        if (bHistory)
        {
            type = Yesterday_Food_Type;
            hasPreView = NO;
        }
        else
        {
            type = Today_Food_Type;
            hasPreView = YES;
            if (mCurrentDay == self.mDayInfoData.data.days)
            {
                hasPreView = NO;
            }
        }
        [MobClick event:Scheme_DietAdd_Click];
        HFFoodListViewController * foodListCtrl = [[HFFoodListViewController alloc] initWithAtToady:type preViewNextBtn:hasPreView];
        foodListCtrl.needShowGuideView = self.needShowGuideView;
        foodListCtrl.mCurrentDay = mCurrentDay;
        foodListCtrl.delegate = self;
        foodListCtrl.mMealType = mealType;
        [self.navigationController pushViewController:foodListCtrl animated:YES];
    }
    else if (type == context_Write_Event)
    {
        [MobClick event:Scheme_HealthDiary_Click];
        HFEditDiaryViewController *vc = [[HFEditDiaryViewController alloc]init];
        vc.schemeData = self.mDayInfoData.data;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (type == sport_Event)
    {
        if (!self.mSportData) {
            return;
        }
        if (self.mSportData.data.type == 1) {
            WS(weakSelf)
            [[[HIIProxy shareProxy]schemeProxy]getSportPageData:self.mSportData.data.sportId type:self.mSportData.data.type withBlock:^(HF_BaseAck *ack) {
                if (ack.recode == 1) {
                    GetSportPageDataAck *res = (GetSportPageDataAck *)ack;
                    [weakSelf goSportWithData:res.data];
                }
 
            }];
            
            
        }else {
            GetSuggestData *sportData = [[GetSuggestData alloc]init];
            sportData.sportId = self.mSportData.data.sportId;
            sportData.type = self.mSportData.data.type;
            [self goSportWithData:sportData];
        }
        
    }else if (type == more_news_Event) {
        [MobClick event:Scheme_HealthReport_Click];
        WebViewController *vc = [[WebViewController alloc]init];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:kURLHealthNews forKey:kParamURL];
        vc.moduleType = HIModuleTypeHealthNews;
        vc.param = dic;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (type == context_Prize_Event)
    {
        [MobClick event:Scheme_DiaryAchive_Click];
        [self requsetPrizeScoreSubSchemeid:self.mDiaryData.data.subSchemeId completion:^(BOOL success)
        {
            //设置参数状态，并且
            if (success)
            {
                self.mDiaryData.data.flag = 1;
                
                 HFHealthCell * cell = (HFHealthCell *)[self.mMainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
                [cell resetPrizeFinish:ContextCell_Type];
            }
        }];
    }
    else if (type == eat_Prize_Event)
    {
        [MobClick event:Scheme_DietAchive_Click];
        [self requsetPrizeScoreSubSchemeid:self.mFoodData.data.subSchemeId completion:^(BOOL success) {
            
            for (int i = 0; i < [self.mFoodData.data.mealList count]; i++)
            {
                GetFoodsByMealData * data = [self.mFoodData.data.mealList objectAtIndex:i];
                data.flag = 1;
            }
            
            //取出Cell进行状态重置
            
            HFHealthCell * cell = (HFHealthCell *)[self.mMainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            [cell resetPrizeFinish:EatCell_Type];
            
        }];
    }
    else if (type == sport_Prize_Event)
    {
        [MobClick event:Scheme_SportAchive_Click];
        [self requsetPrizeScoreSubSchemeid:self.mSportData.data.subSchemeId completion:^(BOOL success)
        {
            if (success)
            {
                self.mSportData.data.flag = 1;
                
                HFHealthCell * cell = (HFHealthCell *)[self.mMainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
                
                [cell resetPrizeFinish:SportCell_Type];
            }
        }];
    }
    else if (type == walk_Prize_Event)
    {
        [MobClick event:Scheme_StepAchive_Click];
        [self requsetPrizeScoreSubSchemeid:self.mWalkData.data.subSchemeId completion:^(BOOL success) {
            
            if (success)
            {
                self.mWalkData.data.flag = 1;
                
                HFHealthCell * cell = (HFHealthCell *)[self.mMainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
                
                [cell resetPrizeFinish:WalkCell_Type];
            }
            
            
        }];
    }
    
    if (type == walk_unable_Event)
    {
        HFStepCounterErrorViewController * stepError = [[HFStepCounterErrorViewController alloc] init];
        [self.navigationController pushViewController:stepError animated:YES];
    }
}

- (void)goSportWithData:(GetSuggestData *)sportData
{
    [MobClick event:Scheme_DoSport_Click];
    HFVideoViewController *vc = [[HFVideoViewController alloc]init];
    vc.sportData = sportData;
    if (self.mSportData.data.isOK == 0 && !bHistory) {
        vc.showFinishedBtn = YES;
    }
    vc.schemeData = self.mDayInfoData.data;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)daysCoverSelect:(NSInteger)day
{
    if (day == mCurrentDay)
    {
        return;
    }
    
    bHistory = day == self.mSchemeDay ? NO : YES;
    
    mCurrentDay = day;
    [self getDayInfo];
}

#pragma mark -
#pragma mark HFGiveUpViewDelegate
- (void)cancleButtonClick
{
    [self.giveUpView dismiss];
}
- (void)giveUpButtonClick
{
    WS(weakSelf)
    [[[HIIProxy shareProxy]schemeProxy]modifyScheme:1 schemeStatus:HFModifySchemeTypeGiveUp withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            //弹窗页面消失
            
            [weakSelf leftBarItemAction:nil];
        }
        [weakSelf.giveUpView dismiss];
    }];
}

#pragma mark -
#pragma mark HFEditDiaryViewControllerDelegate
- (void)retPushDiraySuccess
{
    mReqType = SchemeReq_Diary;
}

#pragma mark -
#pragma mark HFFoodListViewControllerDelegate
- (void)uploadFoodInfo
{
    mReqType = SchemeReq_Eat;
}

#pragma mark -
#pragma mark HFVideoViewControllerDelegate

- (void)retSportFinsih
{
    mReqType = SchemeReq_Sport;
}

#pragma mark -
#pragma mark getter
- (HFDayPickerModel *)dayPickerModel
{
    if (_dayPickerModel)
    {
        _dayPickerModel = [[HFDayPickerModel alloc] init];
    }
    return _dayPickerModel;
}

- (HFGiveUpView *)giveUpView
{
    if (!_giveUpView) {
        _giveUpView = [[HFGiveUpView alloc] init];
        _giveUpView.delegate = self;
    }
    return _giveUpView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
