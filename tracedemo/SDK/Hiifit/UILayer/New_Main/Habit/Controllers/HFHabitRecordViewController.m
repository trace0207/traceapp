//
//  HFHabitRecordViewController.m
//  GuanHealth
//
//  Created by hermit on 15/6/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHabitRecordViewController.h"
#import "HFPostDetailView.h"
#import "MyPostListRes.h"
#import "SentPostViewController.h"
#import "HFHabitTimesListViewController.h"
#import "HFHabitTimeDetailViewController.h"
#import "GlobNotifyDefine.h"

@interface HFHabitRecordViewController ()<BasePostDetailViewDelegate,HFAddHabitDelegate>
{
    NSInteger allDays;
    NSInteger continuousDays;
    HFPostDetailView * mDetailView;
    NSInteger pageOffSet;
    BOOL mNeedReload;
    
    BOOL bState;
}

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HFHabitRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [kNotificationCenter addObserver:self selector:@selector(publishSuccessPost) name:PublishSuccessNotification object:nil];
    mDetailView = [[HFPostDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44)withTableViewStyle:UITableViewStyleGrouped];
    mDetailView.delegate = self;
   // mDetailView.backgroundColor = [UIColor clearColor];
    mDetailView.mTableView.backgroundColor = [UIColor clearColor];
    mDetailView.bSupportPullUpLoad = YES;
    [self.view addSubview:mDetailView];
    [self addRightBarItemWithTitle:@"设置"];
    if (self.habitName) {
        [self addNavigationTitle:self.habitName];
    }
    
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, 170.0f);
    self.headerView.backgroundColor = [UIColor HFColorStyle_5];
    self.addHeaderView.frame = CGRectMake(0, 0, kScreenWidth,150);
    self.addHeaderView.backgroundColor = [UIColor HFColorStyle_6];
    if (_habitId==0) {
        self.habitNameLabel.text = self.habitName;
        self.peopleNumLabel.text = @"0名参与者";
        [self.mIconView sd_setImageWithURL:[NSURL URLWithString:self.habitIconUrl] placeholderImage:IMG(@"default_habit")];
        [mDetailView.mTableView setTableHeaderView:self.addHeaderView];
        [self addNullViewToTableView:NO];
    }
}
- (void)dealloc
{
    [kNotificationCenter removeObserver:self name:PublishSuccessNotification object:nil];
}
- (void)leftBarItemAction:(id)sender
{
//    if (self.popViewController) {
//        [self.navigationController popToViewController:self.popViewController animated:YES];
//    }else{
        [super leftBarItemAction:sender];
//    }
}

- (void)rightBarItemAction:(id)sender
{
    HFHabitTimesListViewController * timeListViewController = [[HFHabitTimesListViewController alloc] init];
    timeListViewController.mHabitHeadUrl = _habitIconUrl;
    timeListViewController.mHabitId = _habitId;
    timeListViewController.mHabitName = _habitName;
    timeListViewController.mSubcribeNum = self.infoData.subscribeNum;
    [self.navigationController pushViewController:timeListViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_habitId>0) {
        [self getHabitInfo];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (bState)
    {
        [self addRightBarItemWithTitle:nil];
    }
    else
    {
        [self addRightBarItemWithTitle:nil];
        [self addRightBarItemWithTitle:@"设置"];
    }
}

- (void)getHabitInfo
{
    WS(weakSelf)
    [[[HIIProxy shareProxy] habitProxy] requestHabitInfoWithHabitId:self.habitId Success:^(HFHabitSignInfoRes *res) {
        if (res) {
            weakSelf.infoData = res.data;
            weakSelf.habitIconUrl = res.data.habitIconUrl;
            allDays = res.data.totalDay;
            continuousDays = res.data.continueDay;
            [weakSelf setHeaderViewWithHabitInfo:res.data];
        }
    } fail:^{
        
    }];
}

- (void)setHeaderViewWithHabitInfo:(HFHabitSignInfoData *)info
{
    if (info.subscribeStatus == 1) {
        bState = NO;
        [mDetailView.mTableView setTableHeaderView:self.headerView];
        [self setInfoToHeader:info.signStatus];
        [self.recordBtn setBackgroundImage:IMG(@"red_pen") forState:UIControlStateNormal];
        [self.recordBtn setBackgroundImage:IMG(@"blue_pen") forState:UIControlStateSelected];
        self.subPeopleLabel.text = [NSString stringWithFormat:@"%ld人已参与",info.subscribeNum];
        
    }else{
        bState = YES;
        [mDetailView.mTableView setTableHeaderView:self.addHeaderView];
        self.habitNameLabel.text = self.habitName;
        self.peopleNumLabel.text = [NSString stringWithFormat:@"%li名参与者",(long)info.subscribeNum];
        [self.mIconView sd_setImageWithURL:[NSURL URLWithString:self.habitIconUrl] placeholderImage:IMG(@"default_habit")];
        self.habitNoteLabel.text = self.habitNote;
    }
    if (self.dataSource.count == 0) {
        [self addNullViewToTableView:info.subscribeStatus];
    }
    if (!mNeedReload) {
        [mDetailView startRequest];
        mNeedReload = !mNeedReload;
    }
}

- (void)setInfoToHeader:(BOOL)status
{
    NSMutableAttributedString *totalText = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%li天",(long)allDays]];
    
    [totalText addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, totalText.length-1)];
    [totalText addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(totalText.length-1, 1)];
    
    
    NSMutableAttributedString *continousText = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%li天",(long)continuousDays] attributes:nil];
    [continousText addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, continousText.length-1)];
    [continousText addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(continousText.length-1, 1)];
    
    self.allLabel.attributedText = totalText;
    self.continuousLabel.attributedText = continousText;
    self.recordBtn.selected = status;
    
}

- (IBAction)recordAction:(UIButton*)sender
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    WS(weakSelf)
    [[[HIIProxy shareProxy] habitProxy] habitSignOperator:!sender.selected withHabitID:self.habitId completion:^(BOOL finish) {
        if (finish) {
//            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(PunchCard:withStatus:)]) {
//                [weakSelf.delegate PunchCard:weakSelf.habitId withStatus:sender.selected?0:1];
//            }
            if (!sender.selected) {
                allDays += 1;
                continuousDays += 1;
                [self goSentViewAction:nil];
            }else{
                allDays -= 1;
                continuousDays -= 1;
            }
            [weakSelf setInfoToHeader:!sender.selected];
        }
        [hud hide:YES];
    }];
}

- (IBAction)goSentViewAction:(UIButton*)sender
{
    SentPostViewController *vc = [[SentPostViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:self.habitId] forKey:kParamHabitId];
    [dic setObject:FromHabit forKey:kParamFrom];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)addHabitAction:(id)sender
{
    HFHabitTimeDetailViewController * alarmDetailViewController = [[HFHabitTimeDetailViewController alloc] init];
    alarmDetailViewController.mHabitId = self.habitId;
    alarmDetailViewController.data = nil;
    alarmDetailViewController.mType = AddHabit_Type;
    alarmDetailViewController.delegate = self;
    [self.navigationController pushViewController:alarmDetailViewController animated:YES];
}

- (void)addNullViewToTableView:(BOOL)isMyHabit
{
    UIView *view = [mDetailView viewWithTag:404];
    if (view) {
        [view removeFromSuperview];
    }
    UIView *nullView = [[UIView alloc]initWithFrame:CGRectMake(0, mDetailView.mTableView.tableHeaderView.frame.size.height, kScreenWidth, kScreenHeight-64-mDetailView.mTableView.tableHeaderView.frame.size.height)];
    nullView.tag = 404;
    //nullView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    nullView.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 78)];
    [imageView setImage:IMG(@"no_mood")];
    imageView.center = CGPointMake(nullView.frame.size.width/2, nullView.frame.size.height/2-60);
    [nullView addSubview:imageView];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height, nullView.frame.size.width, 60)];
    lable.numberOfLines = 0;
    lable.textAlignment = NSTextAlignmentCenter;
    if (isMyHabit) {
        lable.text = @"Come on!\n快来发表心情吧!";
    }else{
        lable.text = @"Come on!\n快添加习惯记录心情吧!";
    }
    lable.font = [UIFont systemFontOfSize:16.0f];
    lable.textColor = [UIColor hexChangeFloat:@"bbbbbb" withAlpha:1.0f];
    [nullView addSubview:lable];
    
    [mDetailView.mTableView addSubview:nullView];
}

- (void)removeNullView
{
    UIView *view = [mDetailView viewWithTag:404];
    if (view) {
        [view removeFromSuperview];
    }
}

#pragma download data

- (void)endRefresh
{
    if (self.habitId==0) {
        [mDetailView endRefreash];
        return;
    }
    WS(weakSelf);
    HFSudoPostsReq *req = [[HFSudoPostsReq alloc]init];
    req.pageOffset = 0;
    req.weiboType = HIWeiboTypeHabit;
    req.modelId = HIModuleTypeHabit;
    req.habitId = _habitId;
    req.pageSize = kPageSize;
    [[[HIIProxy shareProxy]weiboProxy]getSudoPosts:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
        if (success) {
            if (postList.count == 0) {
                [weakSelf addNullViewToTableView:weakSelf.infoData.subscribeStatus];
            }else{
                [weakSelf removeNullView];
                if (!weakSelf.dataSource) {
                    weakSelf.dataSource = [[NSMutableArray alloc]init];
                }
                [weakSelf.dataSource removeAllObjects];
                
                pageOffSet = postList.count;
                [weakSelf.dataSource addObjectsFromArray:postList];
                [mDetailView reloadData:weakSelf.dataSource];
            }
        }
        [mDetailView endRefreash];
    }];
}

- (void)endLoadMore
{
    if (self.habitId==0) {
        return;
    }
    WS(weakSelf);
   
    
    HFSudoPostsReq *req = [[HFSudoPostsReq alloc]init];
    req.pageOffset = pageOffSet;
    req.weiboType = HIWeiboTypeHabit;
    req.modelId = HIModuleTypeHabit;
    req.habitId = _habitId;
    req.pageSize = kPageSize;
    [[[HIIProxy shareProxy]weiboProxy]getSudoPosts:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
        if (success) {
            pageOffSet += postList.count;
            for (int i = 0; i < postList.count; i++) {
                PostDetailData *post = [postList objectAtIndex:i];
                [weakSelf.dataSource addObject:post];
                if (i == postList.count - 1) {
                    [mDetailView reloadData:weakSelf.dataSource];
                }
            }
        }
        [mDetailView endRefreash];
    }];
}

#pragma mark -
#pragma mark Notication
- (void)publishSuccessPost
{
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:1.0];
}

#pragma mark -
#pragma mark BasePostDetailViewDelegate
- (void)loadPullDownRefreashData
{
    [self endRefresh];
}

- (void)loadPullUpMoreData
{
    [self endLoadMore];
}

#pragma mark add habit delegate

- (void)addHabitSuccess:(NSInteger)habitId
{
    self.habitId = habitId;
    [self getHabitInfo];
}

@end
