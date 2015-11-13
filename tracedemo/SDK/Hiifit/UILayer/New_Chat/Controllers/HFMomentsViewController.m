//
//  HFMomentsViewController.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/10/21.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import "HFMomentsViewController.h"
#import "WebViewController.h"
#import "CLLRefreshHeadController.h"
#import "MyPostListRes.h"
#import "HFCommentViewController.h"
#import "HFPostDetailView.h"
#import "HFTitleView.h"
#import "SentPostViewController.h"
#import "SDCycleScrollView.h"
#import "HFMainActivityRes.h"
#import "UIViewController+TKNavigationBarSetting.h"
CGFloat const bannerScale = (750.0f/200.0f);


@interface HFMomentsViewController ()<HFTitleViewDelegate,BasePostDetailViewDelegate,SDCycleScrollViewDelegate>
{
    NSInteger mCurrentIndex;
    NSMutableArray *mSourceArray;
    NSMutableArray *mViewArray;
    NSMutableArray *mOffsetArray;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HFTitleView *titleView;
@property (nonatomic, strong) NSMutableArray *activities;
@property (nonatomic, strong) SDCycleScrollView *bannerView;

@end

@implementation HFMomentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    mOffsetArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",nil];
    mSourceArray = [[NSMutableArray alloc] init];
    mViewArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        NSMutableArray * array = [[NSMutableArray alloc] init];
        [mSourceArray addObject:array];
    }
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.pagingEnabled = YES;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.backgroundColor = [UIColor HFColorStyle_6];
    [_scrollView setContentSize:CGSizeMake(kScreenWidth*3, CGRectGetHeight(_scrollView.frame))];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    for (NSInteger i = 0; i < 3; i++) {
        HFPostDetailView *_tableView = [[HFPostDetailView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight-64-49) withTableViewStyle:UITableViewStylePlain];
        _tableView.bSupportPullUpLoad = YES;
        _tableView.delegate = self;
        [_scrollView addSubview:_tableView];
        [mViewArray addObject:_tableView];
    }
    
    [self requesetSource];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationTitleView:self.titleView];
    
    [self TKremoveRightBarButtonItem];
    [self TKremoveLeftBarButtonItem];
    [self TKsetLeftBarItemImage:[UIImage imageNamed:@"Hi_addFriends"]
                      addTarget:self
                         action:@selector(leftBarItemAction:)
               forControlEvents:UIControlEventTouchUpInside];
    [self TKsetRightBarItemImage:[UIImage imageNamed:@"edit" ]
                      addTarget:self
                         action:@selector(rightBarItemAction:)
               forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarItemAction:(id)sender
{
    [MobClick event:Find_Add_New_Fri];
    WebViewController *vc = [[WebViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:kURLHotFriends forKey:kParamURL];
    [dic setObject:KEY_ADD_FRIEND forKey:kParamFrom];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightBarItemAction:(id)sender
{
    // 发表心情贴
    SentPostViewController *sc = [[SentPostViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:FromPersonal forKey:kParamFrom];
    sc.param = dic;
    [self.navigationController pushViewController:sc animated:YES];
}
//获取广告数据
- (void)getActivitiesData
{
    WS(weakSelf)
    [[[HIIProxy shareProxy]activityProxy]requestBannerActivitiesPosition:2 complete:^(NSArray *data, BOOL success) {
        if (success) {
            [weakSelf.activities removeAllObjects];
            [weakSelf.activities addObjectsFromArray:data];
            [weakSelf setbannerData];
        }
    }];
}

- (void)setbannerData
{
    HFPostDetailView * view = (HFPostDetailView *)[mViewArray objectAtIndex:0];
    NSArray *bannerData = [self getImgUrls];
    if (bannerData.count<=1) {
        [self.bannerView setPageControlStyle:SDCycleScrollViewPageContolStyleNone];
    }
    [self.bannerView setImageURLStringsGroup:bannerData];
    [view.mTableView setTableHeaderView:self.bannerView];
}

- (NSArray *)getImgUrls
{
    NSMutableArray *imgUrls = [[NSMutableArray alloc]initWithCapacity:self.activities.count];
    for (HFMainActivityData *data in self.activities) {
        [imgUrls addObject:data.picUrl];
    }
    if (imgUrls.count>6) {
        return [imgUrls subarrayWithRange:NSMakeRange(0, 6)];
    }
    return imgUrls;
}

- (void)requesetSource
{
    HFPostDetailView * view = (HFPostDetailView *)[mViewArray objectAtIndex:mCurrentIndex];
    [view startRequest];
}

- (NSMutableArray *)activities
{
    if (!_activities) {
        _activities = [[NSMutableArray alloc]init];
    }
    return _activities;
}

- (SDCycleScrollView *)bannerView
{
    if (_bannerView == nil) {
        _bannerView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/bannerScale)];
        [_bannerView setPlaceholderImage:IMG(@"moments_banner")];
        _bannerView.autoScrollTimeInterval = 3.0f;
        _bannerView.delegate = self;
        [_bannerView setPageControlStyle:SDCycleScrollViewPageContolStyleClassic];
    }
    return _bannerView;
}

- (HFTitleView *)titleView
{
    if (!_titleView) {
        NSArray *titles = [NSArray arrayWithObjects:_T(@"HF_Common_Hot"),
                           _T(@"HF_Common_Interest"),
                           _T(@"HF_Common_Friends"),
                           nil];
        _titleView = [[HFTitleView alloc]initWithTitles:titles withScrollView:self.scrollView defaultColor:nil activeColor:nil];
        _titleView.delegate = self;
    }
    return _titleView;
}

#pragma mark - banner selected delegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
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

#pragma mark - title view delegate

- (void)titleViewDidSelectedAtIndex:(NSInteger)index clickMenuTap:(BOOL)clicked
{
    if (index == 0) {
        [MobClick event:Find_Hot];
    }else if (index == 1){
        [MobClick event:Find_Interest];
    }else{
        [MobClick event:Find_Friend];
    }
    
    NSInteger pagOffset = [[mOffsetArray objectAtIndex:index] integerValue];
    if (pagOffset != 0) {
        if (clicked && mCurrentIndex == index) {
            HFPostDetailView * view = (HFPostDetailView *)[mViewArray objectAtIndex:mCurrentIndex];
            [view.mTableView setContentOffset:CGPointZero animated:YES];
        }
        mCurrentIndex = index;
        return;
    }
    mCurrentIndex = index;
    [self requesetSource];
}

#pragma BasePostDetailViewDelegate

- (void)loadPullDownRefreashData
{
    if (mCurrentIndex == 0) {
        [self getActivitiesData];
    }
    HIFindType type = (HIFindType)(mCurrentIndex + 1);
    HFGetPostListReq *req = [[HFGetPostListReq alloc]init];
    req.type = type;
    req.pageSize = kPageSize;
    req.pageOffset = 0;
    [[[HIIProxy shareProxy]weiboProxy]getPostList:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
        HFPostDetailView * view = [mViewArray objectAtIndex:mCurrentIndex];
        if (success) {
            NSMutableArray * array = [mSourceArray objectAtIndex:mCurrentIndex];
            [array removeAllObjects];
            [array addObjectsFromArray:postList];
            //edit by shidongdong 20151015
            [mOffsetArray replaceObjectAtIndex:mCurrentIndex withObject:[NSNumber numberWithInteger:[postList count]]];
            [view reloadData:array];
        }
        [view endRefreash];
    }];
}

- (void)loadPullUpMoreData
{
    NSInteger pagOffset = [[mOffsetArray objectAtIndex:mCurrentIndex] integerValue];
    
    HIFindType type = (HIFindType)(mCurrentIndex + 1);
    HFGetPostListReq *req = [[HFGetPostListReq alloc]init];
    req.type = type;
    req.pageSize = kPageSize;
    req.pageOffset = pagOffset;
    
    [[[HIIProxy shareProxy]weiboProxy]getPostList:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
        HFPostDetailView * view = [mViewArray objectAtIndex:mCurrentIndex];
        if (success) {
            NSInteger offset = pagOffset + postList.count;
            [mOffsetArray replaceObjectAtIndex:mCurrentIndex withObject:[NSNumber numberWithInteger:offset]];
            NSMutableArray * array = [mSourceArray objectAtIndex:mCurrentIndex];
            
            for (int i = 0; i < postList.count; i++) {
                PostDetailData *post = [postList objectAtIndex:i];
                [array addObject:post];
                if (i == postList.count - 1) {
                    [view reloadData:array];
                }
            }
        }
        [view endLoad];
    }];
}

@end
