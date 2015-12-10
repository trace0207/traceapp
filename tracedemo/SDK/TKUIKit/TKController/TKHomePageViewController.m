//
//  TKHomePageViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 15/10/29.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKHomePageViewController.h"
#import "HFSegmentView.h"
#import "UIViewController+TKNavigationBarSetting.h"
#import "SDCycleScrollView.h"
#import "HFTitleView.h"
#import "HFPostDetailView.h"
#import "UIColor+TK_Color.h"
#import "TKColorDefine.h"
#import "TKProxy.h"
#import "TK_GetOrdersAck.h"
#import "HFMenuControl.h"
#import "TKPublishRewardVC.h"


@interface TKHomePageViewController ()<HFTitleViewDelegate,BasePostDetailViewDelegate,SDCycleScrollViewDelegate,HFMenuDelegate>{
    
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

@implementation TKHomePageViewController
static HFMenuControl * menu;
- (void)viewDidLoad {
    [super viewDidLoad];

    mSourceArray = [[NSMutableArray alloc] init];
    mViewArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
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
    [_scrollView setContentSize:CGSizeMake(TKScreenWidth*2, CGRectGetHeight(self.view.frame))];

    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    for (NSInteger i = 0; i < 2; i++) {
        HFPostDetailView *_tableView = [[HFPostDetailView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, CGRectGetHeight(self.view.frame)-49)
                                                           withTableViewStyle:UITableViewStylePlain];
        _tableView.bSupportPullUpLoad = YES;
        _tableView.delegate = self;
        [_scrollView addSubview:_tableView];
        [mViewArray addObject:_tableView];
    }
    
    
    
    
}


-(void)leftDrawerButtonPress{
    
    /**
     *  弹出侧滑菜单
     */
    if(_eventDelegate){
        [_eventDelegate leftBarIconDidClick];
    }
    
}


-(void)goToRewardPage:(NSObject *)data
{
    TKPublishRewardVC * vc = [[TKPublishRewardVC alloc] initWithNibName:@"TKPublishShowGoodsVC" bundle:nil];
    [[AppDelegate getMainNavigation]pushViewController:vc animated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [self TKremoveLeftBarButtonItem];
//    [self TKremoveRightBarButtonItem];
    [self TKremoveNavigationTitle];
    [self TKaddNavigationTitleView:[self titleView]];
    [self TKsetRightBarItemImage:[UIImage imageNamed:@"tk_icon_camera_b"]
                       addTarget:self action:@selector(goToRewardPage:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self resetRightBarItem];
    
}



/**
 *  Description  右侧的 menu菜单
 *
 *  @param sender <#sender description#>
 */
-(void)rightBarItemAction:(id)sender{

    if (!menu) {
        NSMutableArray * array =  [[TKUserCenter instance].userNormalVM shareCategorys];
        menu = [[HFMenuControl alloc]initWithCategorys:array];
        menu.delegate = self;
    }
    [menu showMenu];
}


- (HFTitleView *)titleView
{
    if (!_titleView) {
        NSArray *titles = [NSArray arrayWithObjects:@"晒 单",@"悬 赏",nil];
        _titleView = [[HFTitleView alloc]initWithTitles:titles
                                         withScrollView:self.scrollView
                                           defaultColor:[UIColor TKcolorWithHexString:TK_Color_nav_textDefault]
                                            activeColor:[UIColor TKcolorWithHexString:TK_Color_nav_textActive]];
        //        _titleView.activeColor = [UIColor TKcolorWithHexString:TK_Color_nav_textActive];
        //        _titleView.defaultColor = [UIColor TKcolorWithHexString:TK_Color_nav_textDefault];
        _titleView.delegate = self;
        mCurrentIndex = _titleView.currentIndex;
    }
    return _titleView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *  根据选中的index 加载 page数据
 */
-(void)loadDataForPage{
    
    if(mCurrentIndex == 0){
        
        // load 晒单
        
        DDLogInfo(@"loading shaidan ");
        [self loadPullDownRefreashData];
        
    }else if(mCurrentIndex == 1){
        
        // load 悬赏
        DDLogInfo(@"loading xuanshang ");
        [self loadPullDownRefreashData];
    }
    
    
}


#pragma mark ----------- delegate
- (void)titleViewDidSelectedAtIndex:(NSInteger)index clickMenuTap:(BOOL)clicked{
    
    mCurrentIndex = index;
    [self loadDataForPage];
    [self resetRightBarItem];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
    [self resetRightBarItem];
}


/**
 *  用于控制右侧的 过滤菜单 是否显示
 */
-(void)resetRightBarItem{
    
    if(mCurrentIndex == 0){
    
        [self TKsetLeftBarItemImage:IMG(@"new_add")
                           addTarget:self
                              action:@selector(rightBarItemAction:)
                    forControlEvents:UIControlEventTouchUpInside];
        
    }else{
    
        [self TKremoveLeftBarButtonItem];
    }
    
}



#pragma mark --- BasePostDetailViewDelegate


- (void)loadPullUpMoreData{
    
}

- (void)loadPullDownRefreashData
{
    
    NSInteger type = mCurrentIndex;
    
    [[TKProxy proxy].mainProxy getShowOrders:type withBlock:^(HF_BaseAck *ack){
        HFPostDetailView * view = [mViewArray objectAtIndex:mCurrentIndex];
        if(ack.sucess){
            
            
            DDLogInfo(@"loadPullDownRefreashData  do success");
        }else{
            
            DDLogInfo(@"loadPullDownRefreashData  do error %ld", (long)ack.recode);
        }
        
        
        // TODO_start
        
        NSArray * dataArray = [TKHomePageViewController imaginaryShowOrdersData];
        NSMutableArray * array = [mSourceArray objectAtIndex:mCurrentIndex];
        [array removeAllObjects];
        [array addObjectsFromArray:dataArray];
        //edit by shidongdong 20151015
        [mOffsetArray replaceObjectAtIndex:mCurrentIndex withObject:[NSNumber numberWithInteger:[dataArray count]]];
        [view reloadData:array];
        
        
        // TODO_end
        
        
        [view endRefreash];
    }];
    
    
    //    HIFindType type = (HIFindType)(mCurrentIndex + 1);
    //    HFGetPostListReq *req = [[HFGetPostListReq alloc]init];
    //    req.type = type;
    //    req.pageSize = kPageSize;
    //    req.pageOffset = 0;
    //    [[[HIIProxy shareProxy]weiboProxy]getPostList:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
    //        HFPostDetailView * view = [mViewArray objectAtIndex:mCurrentIndex];
    //        if (success) {
    //            NSMutableArray * array = [mSourceArray objectAtIndex:mCurrentIndex];
    //            [array removeAllObjects];
    //            [array addObjectsFromArray:postList];
    //            //edit by shidongdong 20151015
    //            [mOffsetArray replaceObjectAtIndex:mCurrentIndex withObject:[NSNumber numberWithInteger:[postList count]]];
    //            [view reloadData:array];
    //        }
    //        [view endRefreash];
    //    }];
}


+(NSArray *)imaginaryShowOrdersData{
    
    /*
     
     authorId = 11186;
     commentNum = 25;
     content = "%E4%BB%8A%E5%A4%A9%E8%A6%81%E5%AD%A6%E8%8C%83%E7%88%B7%E5%95%8A%F0%9F%98%82%F0%9F%98%82%E8%AE%BA%E5%A5%B3%E7%94%9F%E8%87%AA%E6%8B%8D%E5%92%8C%E4%BB%96%E4%BA%BA%E6%8B%8D%E7%9A%84%E5%8C%BA%E5%88%AB";
     habitOrModuleId = 404;
     headPortraitUrl = "http://183.131.13.113:80/share/data/spider/pic/user/11186/head/head_20150604164429_278_X.jpg";
     name = "\U5065\U8eab\U52a8\U4f5c\U6a21\U4eff\U79c0";
     nickName = "\U5c0f\U53ef\U5c0f\U732b";
     picAddr1 = "http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
     picAddr2 = "http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_084_X.jpg";
     picAddr3 = "http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_498_X.jpg";
     picAddr4 = "http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_950_X.jpg";
     picAddr5 = "<null>";
     picAddr6 = "<null>";
     picAddr7 = "<null>";
     picAddr8 = "<null>";
     picAddr9 = "<null>";
     praiseNum = 45;
     praised = 0;
     secondTime = 1447044213;
     status = "<null>";
     title = "<null>";
     type = 1;
     weiboId = 10275;
     
     */
    
    
    
    PostDetailData  * data = [[PostDetailData alloc]init];
    
    data.authorId = 11186;
    data.commentNum = 25;
    data.content = @"这里是测试数据,显示内容";
    data.headPortraitUrl = @"http://183.131.13.113:80/share/data/spider/pic/user/11186/head/head_20150604164429_278_X.jpg";
    data.name = @"测试name";
    data.nickName = @"测试nickName";
    data.picAddr1 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
    data.picAddr2 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_084_X.jpg";
    data.picAddr3 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_498_X.jpg";
    data.picAddr4 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_950_X.jpg";
    data.picAddr5 = nil;
    data.picAddr6 = nil;
    data.picAddr7 = nil;
    data.picAddr8 = nil;
    data.picAddr9 = nil;
    data.praised = 0;
    data.praiseNum = 45;
    data.type = 1;
    data.weiboId = 10275;
    
    
    PostDetailData  * data1 = [[PostDetailData alloc]init];
    
    data1.authorId = 11186;
    data1.commentNum = 25;
    data1.content = @"这里是测试数据,显示内容";
    data1.headPortraitUrl = @"http://183.131.13.113:80/share/data/spider/pic/user/11186/head/head_20150604164429_278_X.jpg";
    data1.name = @"测试name";
    data1.nickName = @"测试nickName";
    data1.picAddr1 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
    data1.picAddr2 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_084_X.jpg";
    data1.picAddr3 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_498_X.jpg";
    data1.picAddr4 = nil;
    data1.picAddr5 = nil;
    data1.picAddr6 = nil;
    data1.picAddr7 = nil;
    data1.picAddr8 = nil;
    data1.picAddr9 = nil;
    data1.praised = 0;
    data1.praiseNum = 45;
    data1.type = 1;
    data1.weiboId = 10275;
    
    PostDetailData  * data2 = [[PostDetailData alloc]init];
    
    data2.authorId = 11186;
    data2.commentNum = 25;
    data2.content = @"这里是测试数据,显示内容";
    data2.headPortraitUrl = @"http://183.131.13.113:80/share/data/spider/pic/user/11186/head/head_20150604164429_278_X.jpg";
    data2.name = @"测试name";
    data2.nickName = @"测试nickName";
    data2.picAddr1 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
    data2.picAddr2 = nil;
    data2.picAddr3 = nil;
    data2.picAddr4 = nil;
    data2.picAddr5 = nil;
    data2.picAddr6 = nil;
    data2.picAddr7 = nil;
    data2.picAddr8 = nil;
    data2.picAddr9 = nil;
    data2.praised = 0;
    data2.praiseNum = 45;
    data2.type = 1;
    data2.weiboId = 10275;
    
    
    PostDetailData  * data3 = [[PostDetailData alloc]init];
    
    data3.authorId = 11186;
    data3.commentNum = 25;
    data3.content = @"这里是测试数据,显示内容";
    data3.headPortraitUrl = @"http://183.131.13.113:80/share/data/spider/pic/user/11186/head/head_20150604164429_278_X.jpg";
    data3.name = @"测试name";
    data3.nickName = @"测试nickName";
    data3.picAddr1 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
    data3.picAddr2 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_084_X.jpg";
    data3.picAddr3 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_498_X.jpg";
    data3.picAddr4 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_950_X.jpg";
    data3.picAddr5 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
    data3.picAddr6 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
    data3.picAddr7 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
    data3.picAddr8 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
    data3.picAddr9 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
    data3.praised = 0;
    data3.praiseNum = 45;
    data3.type = 1;
    data3.weiboId = 10275;
    
    PostDetailData  * data4 = [[PostDetailData alloc]init];
    
    data4.authorId = 11186;
    data4.commentNum = 25;
    data4.content = @"这里是测试数据,显示内容";
    data4.headPortraitUrl = @"http://183.131.13.113:80/share/data/spider/pic/user/11186/head/head_20150604164429_278_X.jpg";
    data4.name = @"测试name";
    data4.nickName = @"测试nickName";
    data4.picAddr1 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
    data4.picAddr2 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_084_X.jpg";
    data4.picAddr3 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_498_X.jpg";
    data4.picAddr4 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_950_X.jpg";
    data4.picAddr5 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
    data4.picAddr6 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
    data4.picAddr7 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
    data4.picAddr8 = nil;
    data4.picAddr9 = nil;
    data4.praised = 0;
    data4.praiseNum = 45;
    data4.type = 1;
    data4.weiboId = 10275;
    
    
    NSArray * array = @[data,data1,data2,data3,data4,data];
    
    return array;
    
    
}


#pragma mark ---   HFMenuDelegate
- (void)MenuDidSelectIndex:(NSInteger)index{

    
}



@end
