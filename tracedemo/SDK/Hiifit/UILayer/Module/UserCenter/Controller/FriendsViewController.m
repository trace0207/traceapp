//
//  FriendsViewController.m
//  GuanHealth
//
//  Created by hermit on 15/4/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "FriendsViewController.h"
#import "CLLRefreshHeadController.h"
#import "UserCenterViewController.h"
#import "FriendsCell.h"
#import "FriendsRes.h"
#import "WebViewController.h"
#import "GlobConfig.h"
#import "UIViewController+Customize.h"
@interface FriendsViewController ()<CLLRefreshHeadControllerDelegate>
//@property (nonatomic, strong) CLLRefreshHeadController *refreshController;
@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    _pageIndex = 0;
    self.dataSource = [[NSMutableArray alloc]init];
    self.userId = [[self.param valueForKey:kParamUserId]integerValue];
    self.from = [self.param objectForKey:kParamFrom];
    [self addNavigationTitle:self.from];
    [self addRightBarItemWithTitle:@"添加好友"];
    self.refreshController = [[CLLRefreshHeadController alloc]initWithScrollView:self.tableView viewDelegate:self];
    [self.refreshController startPullDownRefreshing];
    //[self initData];
}

- (void)rightBarItemAction:(id)sender
{
    [MobClick event:Find_Add_New_Fri];
    WebViewController *vc = [[WebViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:kURLHotFriends forKey:kParamURL];
    [dic setObject:KEY_ADD_FRIEND forKey:kParamFrom];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)follow:(UIButton*)bt
{
    FriendsData *data = [self.dataSource objectAtIndex:bt.tag];
    
    WS(weakSelf);
    
    [[[HIIProxy shareProxy]weiboProxy]followAction:data.userId isFollow:bt.selected completion:^(BOOL finished) {
        if (finished) {
            data.status = data.status == 1 ? 0 : 1;
            [weakSelf.dataSource replaceObjectAtIndex:bt.tag withObject:data];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FriendsData *data = [self.dataSource objectAtIndex:indexPath.row];
    UserCenterViewController *vc = [[UserCenterViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:data.userId] forKey:kParamUserId];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FriendsCell" owner:self options:nil]firstObject];
    }
    FriendsData *data = [self.dataSource objectAtIndex:indexPath.row];
   // cell.userBtn.tag = data.userId;
    cell.followBtn.tag = indexPath.row;
    [cell setValueToCell:data];
//    [cell.userBtn addTarget:self action:@selector(goUserCenter:) forControlEvents:UIControlEventTouchUpInside];
    [cell.followBtn addTarget:self action:@selector(follow:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)endLoadMore
{
    WS(weakSelf);
    if ([self.from isEqualToString:KEY_FOLLOWS]) {
        HFGetFollowsReq *req = [[HFGetFollowsReq alloc]init];
        req.pageIndex = _pageIndex;
        req.pageSize = kPageSize;
        req.userId = self.userId;
        [[[HIIProxy shareProxy]homeProxy]getFollows:req completion:^(NSArray<FriendsData> *friends, BOOL success) {
            if (success) {
                weakSelf.pageIndex = weakSelf.pageIndex + 1;
                [weakSelf.dataSource addObjectsFromArray:friends];
                [weakSelf.tableView reloadData];
            }
            [weakSelf.refreshController endPullUpLoading];
        }];
    }else if ([self.from isEqualToString:KEY_FANS]){
        HFGetFunsReq *req = [[HFGetFunsReq alloc]init];
        req.pageIndex = _pageIndex;
        req.pageSize = kPageSize;
        req.userId = self.userId;
        [[[HIIProxy shareProxy]homeProxy]getFuns:req completion:^(NSArray<FriendsData> *funs, BOOL success) {
            if (success) {
                weakSelf.pageIndex = weakSelf.pageIndex + 1;
                for (int i = 0; i < funs.count; i++) {
                    FriendsData *d = [funs objectAtIndex:i];
                    [weakSelf.dataSource addObject:d];
                    if (i == funs.count - 1) {
                        [weakSelf.tableView reloadData];
                    }
                }
            }
            [weakSelf.refreshController endPullUpLoading];
        }];
    }
}

- (void)endRefresh
{
    WS(weakSelf);
    if ([self.from isEqualToString:KEY_FOLLOWS]) {
        HFGetFollowsReq *req = [[HFGetFollowsReq alloc]init];
        req.pageIndex = 0;
        req.pageSize = kPageSize;
        req.userId = self.userId;
        [[[HIIProxy shareProxy]homeProxy]getFollows:req completion:^(NSArray<FriendsData> *friends, BOOL success) {
            if (success) {
                [weakSelf.dataSource removeAllObjects];
                weakSelf.pageIndex = 1;
                [weakSelf.dataSource addObjectsFromArray:friends];
                [weakSelf.tableView reloadData];
            }
            [weakSelf.refreshController endPullDownRefreshing];
        }];
    }else if ([self.from isEqualToString:KEY_FANS]){
        
        HFGetFunsReq *req = [[HFGetFunsReq alloc]init];
        req.pageIndex = 0;
        req.pageSize = kPageSize;
        req.userId = self.userId;
        [[[HIIProxy shareProxy]homeProxy]getFuns:req completion:^(NSArray<FriendsData> *funs, BOOL success) {
            if (success) {
                [weakSelf.dataSource removeAllObjects];
                weakSelf.pageIndex = 1;
                [weakSelf.dataSource addObjectsFromArray:funs];
                [weakSelf.tableView reloadData];
            }
            [weakSelf.refreshController endPullDownRefreshing];
        }];
    }
}

#pragma mark - refresh delegate

- (void)beginPullDownRefreshing
{
    //[self performSelector:@selector(endRefresh) withObject:nil afterDelay:1];
    [self endRefresh];
}

///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////--上拉加载更多相关方法--///////////////////////////////////////////

/**
 * 2、上拉加载更多
 **/
- (void)beginPullUpLoading
{
    [self endLoadMore];
}

/**
 *  1、标识下拉刷新是UIScrollView的子view，还是UIScrollView父view的子view
 *
 *  @return 如果没有实现该delegate方法，默认是scrollView的子View，为CLLRefreshViewLayerTypeOnScrollViews
 **/
- (CLLRefreshViewLayerType)refreshViewLayerType
{
    return CLLRefreshViewLayerTypeOnSuperView;
}

/**
 *  2、UIScrollView的控制器是否保留iOS7新的特性，意思是：tablView的内容是否可以显示导航条后面
 *
 *  @return 如果不实现该delegate方法，默认是不支持的
 **/
//- (BOOL)keepiOS7NewApiCharacter
//{
////    if (IOS7_OR_LATER) {
////        return YES;
////    }
//    return NO;
//}

/**
 * 3、是否显示 上拉更多视图
 * @return 如果不实现该delegate方法，默认是没有更多
 **/
- (BOOL)hasRefreshFooterView
{
    if (self.dataSource.count == 0 || self.dataSource.count % kPageSize != 0) {
        return NO;
    }
    return YES;
}

@end
