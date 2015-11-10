//
//  HFFoodListViewController.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFFoodListViewController.h"
#import "HFFoodListCell.h"
#import "HFTitleBar.h"
#import "HFFoodListButtonCell.h"
#import "GetUserDietaryByDayAck.h"
#import "HFSentPostViewModule.h"
#import "WebViewController.h"

#define kShowGuideEat @"showGuideEat"
@interface HFFoodListViewController ()<UITableViewDataSource,UITableViewDelegate,HFTitleBarDelegate,HFFoodListButtonCellDelegate,HFFoodListCellDelegate>
{
    dayFoodType mType;
    
    BOOL bPreviewBtn;
    
    NSInteger  cellIndex;
    
    NSInteger  mOperateType;
    
    MBProgressHUD * HUD;
    
}
@property(nonatomic,strong)GetUserDietaryByDayAck * mDietaryData;
@property(nonatomic,strong)HFSentPostViewModule * mPostModule;
@property (nonatomic, strong) UIView * bgGuideView;
@end

@implementation HFFoodListViewController

/**
 *  初始化函数
 *
 *  @param bHasPreView 是否有明天的食谱查看按钮
 *  @param bHasFinish  是否有完成按钮
 *
 *  @return self
 */

- (instancetype)initWithAtToady:(dayFoodType)type preViewNextBtn:(BOOL)bHas;
{
    self = [super init];
    if (self)
    {
        mType = type;
        
        bPreviewBtn = bHas;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (mType == Yesterday_Food_Type)
    {
        [self addNavigationTitle:@"历史饮食"];
    }
    else if (mType == Today_Food_Type)
    {
        [self addNavigationTitle:@"今日健康食谱"];
    }
    else
    {
        [self addNavigationTitle:@"明日健康食谱"];
    }
    
    NSArray * titles = [[NSArray alloc] initWithObjects:@"早餐",@"午餐",@"晚餐",@"热饮", nil];
    self.mTitleBar.delegate = self;
    self.mTitleBar.backgroundColor = [UIColor whiteColor];
    [self.mTitleBar setBarTitles:titles selectColor:[UIColor HFColorStyle_1] disColor:[UIColor HFColorStyle_3]];
    
    [self.mTableView registerClass:[HFFoodListCell class] forCellReuseIdentifier:@"foodCell"];
    [self.mTableView registerNib:[UINib nibWithNibName:@"HFFoodListButtonCell" bundle:nil] forCellReuseIdentifier:@"foodButtonCell"];
    
    [self.mTableView setTableFooterView:[[UIView alloc] init]];
    
    [self startDietaryInfo];

    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark private
- (void)leftBarItemAction:(id)sender
{
    
    self.mTableView.delegate = nil;
    self.mTableView.dataSource = nil;
    self.mTableView = nil;
    
    [MobClick event:Scheme_DietBack_Click];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewToShow
{
    [self.mTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.mMealType - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.mTitleBar updateItemSelected:self.mMealType - 1];
    
}

- (void)showDelayTips
{
    NSDate * date = [NSDate date];
    
    GetUserDietaryMealByDayData * mealData = [self.mDietaryData.data.mealList objectAtIndex:cellIndex];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmm"];
    NSString * nowStr = [formatter stringFromDate:date];
    
    NSInteger now = [nowStr integerValue];
    NSMutableString * start = [[NSMutableString alloc] initWithString:mealData.startTime];
    NSMutableString * end = [[NSMutableString alloc] initWithString:mealData.endTime];
    
    [start deleteCharactersInRange:NSMakeRange(start.length - 3, 1)];
    [end deleteCharactersInRange:NSMakeRange(end.length - 3, 1)];
    
    if (now < [start integerValue] || now > [end integerValue])
    {
        [[HFHUDView shareInstance] ShowTips:@"如果能准时吃饭就更好了" delayTime:3.0 atView:nil];
    }
}

- (void)startDietaryInfo
{
    [[[HIIProxy shareProxy] schemeProxy] getUserDietaryByDay:_mCurrentDay withBlock:^(HF_BaseAck *ack) {
        
        if (HUD)
        {
            [HUD hide:YES];
        }
        
        GetUserDietaryByDayAck * data = (GetUserDietaryByDayAck *)ack;
        self.mDietaryData = data;
        
        for (int i = 0; i < [data.data.mealList count]; i++)
        {
            GetUserDietaryMealByDayData * mealData = [data.data.mealList objectAtIndex:i];
            
            if (mealData.isOK)
            {
                [self.mTitleBar updateBarItemFinish:i];
            }
        }
        [self.mTableView reloadData];
//        if (self.needShowGuideView) {
//            if (![kUserDefaults boolForKey:@"FirstLunchFood"]){
//                [kUserDefaults setBool:YES forKey:@"FirstLunchFood"];
//                if (!self.bgGuideView) {
//                    [self loadGuideView];
//                }
//            }
//        }
//        WS(weakSelf)
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf scrollViewToShow:self.mMealType - 1];
//        });
        [self performSelector:@selector(scrollViewToShow) withObject:nil afterDelay:0.5];
    }];
}

- (void)dismissGuideView
{
    [self.bgGuideView removeFromSuperview];
    self.bgGuideView = nil;
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.bgGuideView];
    HFGuideView * finishGuideView = [[HFGuideView alloc] initWithFrame:CGRectMake(30, 250, 128, 70)];
    finishGuideView.textLabel.text = @"吃了推荐食谱\n点这里拍照打卡";
    [self.bgGuideView addSubview:finishGuideView];
    HFGuideView * eatOtherView = [[HFGuideView alloc] initWithFrame:CGRectMake(kScreenWidth - 30 - 128, 250, 128, 70)];
    eatOtherView.textLabel.text = @"吃了别的\n点这里拍照打卡";
    [self.bgGuideView addSubview:finishGuideView];
    [self.bgGuideView addSubview:eatOtherView];
    UITapGestureRecognizer * tapGusture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissGuideView)];
    [self.bgGuideView addGestureRecognizer:tapGusture];

}
//- (void)loadGuideView
//{
//    self.bgGuideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.bgGuideView];
//    HFGuideView * finishGuideView = [[HFGuideView alloc] initWithFrame:CGRectMake(30, 250, 128, 70)];
//    finishGuideView.textLabel.text = @"吃了推荐食谱\n点这里拍照打卡";
//    [self.bgGuideView addSubview:finishGuideView];
//    HFGuideView * eatOtherView = [[HFGuideView alloc] initWithFrame:CGRectMake(kScreenWidth - 30 - 128, 250, 128, 70)];
//    eatOtherView.textLabel.text = @"吃了别的\n点这里拍照打卡";
//    [self.bgGuideView addSubview:finishGuideView];
//    [self.bgGuideView addSubview:eatOtherView];
//    UITapGestureRecognizer * tapGusture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissGuideView)];
//    [self.bgGuideView addGestureRecognizer:tapGusture];
//
//}
#pragma mark -
#pragma mark UITableViewDelegate  && UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 1;
    }
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (bPreviewBtn)
    {
        return 2;
    }
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
    
    if (indexPath.section == 0)
    {
        HFFoodListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"foodCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        
        if (indexPath.row < [self.mDietaryData.data.mealList count])
        {
            GetUserDietaryMealByDayData * data = [self.mDietaryData.data.mealList objectAtIndex:indexPath.row];
            
            BOOL BToday = mType == Yesterday_Food_Type ? NO : YES;
            
            if (data.isOK)
            {
                
                [cell setcontentData:data withFoodstate:FinishState atTodoy:BToday];
            }
            else
            {
                if (mType == Today_Food_Type)
                {
                    [cell setcontentData:data withFoodstate:PreviewState atTodoy:BToday];
                }
                else if (mType == Tommorrow_Food_Type)
                {
                    [cell setcontentData:data withFoodstate:PreviewNOBtnState atTodoy:BToday];
                }
                else
                {
                    [cell setcontentData:data withFoodstate:UnFinishState atTodoy:BToday];
                }
                
            }
        }
        return cell;
    }
    else
    {
        HFFoodListButtonCell * cell = [tableView dequeueReusableCellWithIdentifier:@"foodButtonCell"];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1)
    {
        return 70.0;
    }
    
    
    if (!self.mDietaryData)
    {
        return 0.0;
    }
    
    if (indexPath.row >= [self.mDietaryData.data.mealList count])
    {
        return 0.0;
    }
    
    GetUserDietaryMealByDayData * data = [self.mDietaryData.data.mealList objectAtIndex:indexPath.row];
    
    if (data.isOK)
    {
        return 250.0;
    }
    else
    {
        if (mType == Today_Food_Type)
        {
            return 275.0;
        }
        else if (mType == Tommorrow_Food_Type)
        {
            return 225.0;
        }
        else
        {
            return 150.0;
        }
    }

}

#pragma mark -
#pragma mark HFTitleBarDelegate

- (void)selectBarItem:(NSInteger)index
{
    [self.mTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark -
#pragma mark HFFoodListCellDelegate
- (void)cellPhotoAction:(cellPhotoState)state atCell:(HFFoodListCell *)cell
{
    
    cellIndex = [self.mTableView indexPathForCell:cell].row;
    
    if (state == eat_Finish_State)
    {
        [MobClick event:Scheme_DietFinish_Click];
        mOperateType = 1;
    }
    else
    {
        [MobClick event:Scheme_EatOthers_Click];
        mOperateType = 2;
    }
    
    [self doSelectPic:@"添加食物" clipping:NO maxSelect:1];
}


- (void)pushCalorieDetailViewAction:(NSInteger)calorieID
{
    WebViewController * web = [[WebViewController alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:KURLFoodCalorie((long)calorieID) forKey:kParamURL];
    web.param = dic;
    [self.navigationController pushViewController:web animated:YES];
}


#pragma mark -
#pragma mark HFFoodListButtonCellDelegate
- (void)nextDayAction
{
    [MobClick event:Scheme_TomorrowDiet_Click];
    HFFoodListViewController * foodList = [[HFFoodListViewController alloc] initWithAtToady:Tommorrow_Food_Type preViewNextBtn:NO];
    foodList.mCurrentDay = _mCurrentDay + 1;
    foodList.needShowGuideView = self.needShowGuideView;
    [self.navigationController pushViewController:foodList animated:YES];
}

#pragma mark -
#pragma mark fartherMothed
-(void)onOneImageBack:(UIImage *)image
{
    //先去上传图片得到URL，然后打包URL进行信息保存
    
    NSArray * pics = [[NSArray alloc] initWithObjects:image, nil];
    
    WS(weakSelf)
    
    HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    
    [self.mPostModule uploadImages:pics imageType:HIUploadImageTypeDie compeltion:^(NSArray *urls,BOOL success) {
        
        if (!success)
        {
            if (HUD)
            {
                [HUD hide:YES];
            }
            return;
        }
        
        SaveDietaryInfoArg * arg = [[SaveDietaryInfoArg alloc] init];
        arg.schemeId = 1;
        arg.day = _mCurrentDay;
        arg.picAddr = [urls objectAtIndex:0];
        arg.mealType = cellIndex + 1;
        arg.operateType = mOperateType;
        
        weakSelf.mMealType = cellIndex + 1;
        
        [[HIIProxy shareProxy].schemeProxy save:arg withBlock:^(HF_BaseAck *ack) {
            if ([ack sucess])
            {
                [weakSelf.mTitleBar updateBarItemFinish:cellIndex];
                
                [weakSelf showDelayTips];
            
                [weakSelf startDietaryInfo];
                
                if (_delegate && [_delegate respondsToSelector:@selector(uploadFoodInfo)])
                {
                    [_delegate uploadFoodInfo];
                }
                
            }
        }];
    }];
}

#pragma mark -
#pragma mark getter
- (HFSentPostViewModule *)mPostModule
{
    if (!_mPostModule)
    {
        _mPostModule = [[HFSentPostViewModule alloc] init];
    }
    return _mPostModule;
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
