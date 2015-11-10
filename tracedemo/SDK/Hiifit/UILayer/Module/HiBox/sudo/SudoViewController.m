//
//  SudoViewController.m
//  GuanHealth
//
//  Created by hermit on 15/5/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "SudoViewController.h"
#import "MyPostListRes.h"
#import "PostCell.h"
#import "RankViewController.h"
#import "GameViewController.h"
#import "WebViewController.h"
#import "HFCommentViewController.h"
#import "HFPostDetailView.h"
#import "HFThirdPartyCenter.h"
@interface SudoViewController ()<PostCellDelegate,BasePostDetailViewDelegate>
{
    HFPostDetailView * mDetailView;
    
    NSMutableArray * dataSource;
}
@property (nonatomic, assign) NSInteger   pageOffSet;
@property (nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation SudoViewController
@synthesize dataSource;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationTitle:@"数独"];
    //[self addRightBarItemWithImageName:@"icon_share"];
    
    mDetailView = [[HFPostDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) withTableViewStyle:UITableViewStylePlain];
    mDetailView.delegate = self;
    mDetailView.bSupportPullUpLoad = YES;
    [self.view addSubview:mDetailView];
    
    UIImage *sudoimage = [UIImage imageNamed:@"sudoHeader"];
    UIImageView *sudoImageView = [[UIImageView alloc]initWithImage:sudoimage];
    sudoImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/sudoimage.size.width*sudoimage.size.height);
    
    UIImage *rankImage = [UIImage imageNamed:@"rank"];
    UIButton *rankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rankBtn setBackgroundImage:rankImage forState:UIControlStateNormal];
    [rankBtn addTarget:self action:@selector(goRankView:) forControlEvents:UIControlEventTouchUpInside];
    rankBtn.frame  = CGRectMake(kScreenWidth/2 - 50.0/rankImage.size.height*rankImage.size.width - 20, sudoImageView.frame.size.height+16, 50.0/rankImage.size.height*rankImage.size.width, 50);
    
    UIImage *startImage = [UIImage imageNamed:@"start_game"];
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn addTarget:self action:@selector(goPlayGame:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setBackgroundImage:startImage forState:UIControlStateNormal];
    startBtn.frame = CGRectMake(kScreenWidth/2+20, rankBtn.frame.origin.y, rankBtn.frame.size.width, rankBtn.frame.size.height);
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 82 + sudoImageView.frame.size.height)];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:sudoImageView];
    [headerView addSubview:rankBtn];
    [headerView addSubview:startBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height - 1, kScreenWidth, 1)];
    line.backgroundColor = [UIColor HFColorStyle_6];
    [headerView addSubview:line];
    
    [mDetailView.mTableView setTableHeaderView:headerView];
    [mDetailView startRequest];
    self.dataSource = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)rightBarItemAction:(id)sender
{
    //需要替换为第三方的分享
    [MobClick event:Sudo_Home_Share_Click];
    [[HFThirdPartyCenter shareInstance] shareSDKShare:self HiifitType:HIModuleTypeGame dataDic:nil];
}
*/
- (void)goRankView:(id)sender
{
    [MobClick event:Sudo_Game_Begin_Click];
    WebViewController *vc = [[WebViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:kURLRank forKey:kParamURL];
    [dic setObject:KEY_ADD_FRIEND forKey:kParamFrom];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goPlayGame:(id)sender
{
    [MobClick event:Sudo_Home_Rank_Click];
    GameViewController *vc = [[GameViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma download data

- (void)endRefresh
{
    WS(weakSelf);

    HFSudoPostsReq *req = [[HFSudoPostsReq alloc]init];
    req.pageOffset = 0;
    req.weiboType = HIWeiboTypeModule;
    req.modelId = HIModuleTypeGame;
    req.habitId = 0;
    req.pageSize = kPageSize;
    [[[HIIProxy shareProxy]weiboProxy]getSudoPosts:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
        if (success) {
            [weakSelf.dataSource removeAllObjects];
            weakSelf.pageOffSet = postList.count;
            [weakSelf.dataSource addObjectsFromArray:postList];
            [mDetailView reloadData:weakSelf.dataSource];
        }
        [mDetailView endRefreash];
    }];
}

- (void)endLoadMore
{
    WS(weakSelf);
    
    HFSudoPostsReq *req = [[HFSudoPostsReq alloc]init];
    req.pageOffset = _pageOffSet;
    req.weiboType = HIWeiboTypeModule;
    req.modelId = HIModuleTypeGame;
    req.habitId = 0;
    req.pageSize = kPageSize;
    [[[HIIProxy shareProxy]weiboProxy]getSudoPosts:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
        if (success) {
            weakSelf.pageOffSet += postList.count;
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
#pragma mark BasePostDetailViewController
- (void)loadPullDownRefreashData
{
    [self endRefresh];
}

- (void)loadPullUpMoreData
{
    [self endLoadMore];
}

@end
