//
//  HFPostBarController.m
//  NavigationMenu
//
//  Created by 朱伟特 on 15/8/4.
//  Copyright (c) 2015年 Ivan Sapozhnik. All rights reserved.
//

#import "HFPostBarController.h"
#import "SINavigationMenuView.h"
#import "CLLRefreshHeadController.h"
#import "PostDetailData.h"
#import "HFCommentViewController.h"
#import "UserCenterViewController.h"
//#import "HFSentPostBarViewController.h"
#import "SentPostViewController.h"
#import "HFCaculateHeightModel.h"
#import "GlobNotifyDefine.h"
typedef NS_ENUM(int, HFPostBarType) {
    HFAll        = 1, //全部帖子
    HFPersonal   = 2, //个人帖子
};

@interface HFPostBarController ()<UITableViewDataSource, UITableViewDelegate, SINavigationMenuDelegate, CLLRefreshHeadControllerDelegate, HFCommentViewControllerDelegate, PostCellDelegate>
{
    BOOL  bShowDeleteButton; //是否要显示删除按钮
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) CLLRefreshHeadController * refreshController;
@property (nonatomic, assign) NSInteger pageOfset;
@property (nonatomic, strong) HomeData *UserInfo;
@property (nonatomic, strong)          NSMutableArray            *dataSource;
@property (nonatomic, strong) SINavigationMenuView * menu;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) HFPostBarType postBarType;

@end

@implementation HFPostBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [kNotificationCenter addObserver:self selector:@selector(publishSuccessPost) name:PublishSuccessNotification object:nil];
    [self loadUI];
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)dealloc
{
    [kNotificationCenter removeObserver:self name:PublishSuccessNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark PrivateFunction
- (void)loadUI
{
    bShowDeleteButton = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect frame = CGRectMake(0.0, 0.0, 200.0, self.navigationController.navigationBar.bounds.size.height);
    self.menu = [[SINavigationMenuView alloc] initWithFrame:frame title:@"全部帖子"];
    [self.menu displayMenuInView:self.navigationController.view];
    self.menu.items = @[@"全部帖子", @"我的帖子"];
    self.menu.delegate = self;
    self.navigationItem.titleView = self.menu;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    _tableView.backgroundColor = [UIColor HFColorStyle_6];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.refreshController = [[CLLRefreshHeadController alloc]initWithScrollView:_tableView viewDelegate:self];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    [self.view addSubview:_tableView];
    [self addRightBarItemWithTitle:@"发帖"];
}

- (void)initData
{
    self.userId = [[[GlobInfo shareInstance] usr] id];
    if (_schemeId<=0) {
        return;
    }
    self.dataSource = [[NSMutableArray alloc]init];
    [self startRequest];
}

- (void)startRequest
{
    [self.refreshController startPullDownRefreshing];
}
- (void)endLoadMore
{
    WS(weakSelf);
    HFPostBarReq * req = [[HFPostBarReq alloc] init];
    req.pageOffset = _pageOfset;
    req.weiboType = HIWeiboTypePostBar;
    req.pageSize = kPageSize;
    req.schemeId = self.schemeId;
    [[[HIIProxy shareProxy] weiboProxy] getPostBar:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
        if (success) {
            if (postList.count > 0) {
                weakSelf.pageOfset  = weakSelf.pageOfset + postList.count;
                for (int i = 0; i < postList.count; i++) {
                    PostDetailData * post = [postList objectAtIndex:i];
                    [weakSelf.dataSource addObject:post];
                    if (i == postList.count - 1) {
                        [weakSelf.tableView reloadData];
                    }
                }
            }
        }
        [weakSelf.refreshController endPullUpLoading];
    }];
}
- (void)endRefresh
{
    WS(weakSelf);
    HFPostBarReq * req = [[HFPostBarReq alloc] init];
    req.pageOffset = 0;
    req.weiboType = HIWeiboTypePostBar;
    req.pageSize = kPageSize;
    req.schemeId = self.schemeId;
    
    [[[HIIProxy shareProxy] weiboProxy] getPostBar:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
        if (success) {
            [weakSelf.dataSource removeAllObjects];
            weakSelf.pageOfset = postList.count;
            [weakSelf.dataSource addObjectsFromArray:postList];
            [weakSelf.tableView reloadData];
        }
        [self.refreshController endPullDownRefreshing];
    }];
}

- (void)leftBarItemAction:(id)sender
{
    [self.menu hidenMenu];
    [super leftBarItemAction:sender];
}

- (void)rightBarItemAction:(id)sender
{
    [self.menu hidenMenu];
    SentPostViewController * postVC = [[SentPostViewController alloc] init];
    postVC.sendPostType = HFSendDiscussion;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:FromPostBar forKey:kParamFrom];
    [dic setObject:[NSNumber numberWithInteger:_schemeId] forKey:kparamSchemeId];
    postVC.param = dic;
    [self.navigationController pushViewController:postVC animated:YES];
    
//    HFSentPostBarViewController * postVC = [[HFSentPostBarViewController alloc] init];
//    postVC.delegate = self;
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    [dic setObject:FromPostBar forKey:kParamFrom];
//    [dic setObject:[NSNumber numberWithInteger:_schemeId] forKey:kparamSchemeId];
//    postVC.param = dic;
//    [self.navigationController pushViewController:postVC animated:YES];

}
- (void)loadPersonalData
{
    WS(weakSelf);
    HFPostBarPersonalReq * req = [[HFPostBarPersonalReq alloc] init];
    req.pageOffset = 0;
    req.weiboType = HIWeiboTypePostBar;
    req.pageSize = kPageSize;
    req.userId = self.userId;
    req.schemeId = self.schemeId;
    [[[HIIProxy shareProxy] weiboProxy] getPostBarPersonal:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
        if (success) {
            [weakSelf.dataSource removeAllObjects];
            weakSelf.pageOfset = postList.count;
            [weakSelf.dataSource addObjectsFromArray:postList];
            [weakSelf.tableView reloadData];
        }
        [self.refreshController endPullDownRefreshing];
    }];

}
- (void)uploadPersonData
{
    WS(weakSelf);
    HFPostBarPersonalReq * req = [[HFPostBarPersonalReq alloc] init];
    req.pageOffset = _pageOfset;
    req.weiboType = HIWeiboTypePostBar;
    req.pageSize = kPageSize;
    req.userId = self.userId;
    req.schemeId = self.schemeId;
    [[[HIIProxy shareProxy] weiboProxy] getPostBarPersonal:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
        if (success) {
            if (postList.count > 0) {
                weakSelf.pageOfset  = weakSelf.pageOfset + postList.count;
                for (int i = 0; i < postList.count; i++) {
                    PostDetailData * post = [postList objectAtIndex:i];
                    [weakSelf.dataSource addObject:post];
                    if (i == postList.count - 1) {
                        [weakSelf.tableView reloadData];
                    }
                }
            }
        }
        [self.refreshController endPullUpLoading];

    }];
}
#pragma mark -
#pragma mark UITableViewDelegate && UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostDetailData *data = [self.dataSource objectAtIndex:indexPath.row];
    HFCaculateHeightModel * model = [UIKitTool heightForEmojiText:data isMainView:NO];
    data.expandFlag = model.state;
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    if (cell == nil) {
        cell = [[PostCell alloc] initWithIndex:2];
        cell.delegate = self;
    }
    if (bShowDeleteButton) {
        cell.delBtn.hidden = NO;
    }else{
        cell.delBtn.hidden = YES;
    }
    PostDetailData *data = [self.dataSource objectAtIndex:indexPath.row];
    if (self.userId == data.authorId) {
        cell.delBtn.hidden = NO;
    }
    [cell setContentToCell:data];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PostDetailData * data = [self.dataSource objectAtIndex:indexPath.row];
    [self pushToCommentDetail:data];
}
- (void)pushToCommentDetail:(PostDetailData *)post
{
    HFCommentViewController * commentController = [[HFCommentViewController alloc] init];
    commentController.mWbType = post.type;
    commentController.delegate = self;
    commentController.mWbID = post.weiboId;
    commentController.mDetailData = post;
    commentController.bIsPostBar = YES;
    [self.navigationController pushViewController:commentController animated:YES];
}

#pragma mark -
#pragma mark SINavigationMenuViewDelegate
- (void)didSelectItemAtIndex:(NSUInteger)index
{
    if (index == 0) {
        bShowDeleteButton = NO;
        self.menu.title = @"全部帖子";
        self.postBarType = HFAll;
        [self endRefresh];
    }
    if (index == 1) {
        bShowDeleteButton = YES;
        self.menu.title = @"我的帖子";
        self.postBarType = HFPersonal;
        [self loadPersonalData];
    }
}
#pragma mark -
#pragma mark CLL
- (BOOL)hasRefreshFooterView
{
    return YES;
}

- (void)beginPullDownRefreshing
{
    if (self.postBarType == HFPersonal) {
        [self loadPersonalData];
        return;
    }
    [self endRefresh];
}

- (void)beginPullUpLoading
{
    if (self.postBarType == HFPersonal) {
        [self uploadPersonData];
        return;
    }
    [self endLoadMore];
}
- (CLLRefreshViewLayerType)refreshViewLayerType
{
    return CLLRefreshViewLayerTypeOnScrollViews;
}

#pragma mark -
#pragma mark HFCommentViewControllerDelegate
- (void)updatePostData:(PostDetailData *)data
{
    [self updatePriseOrCommentForPostData:data];
    [self.tableView reloadData];
}
- (void)updatePriseOrCommentForPostData:(PostDetailData *)data
{
    for (int i = 0; i < [self.dataSource count]; i++) {
        PostDetailData * tmpData = [self.dataSource objectAtIndex:i];
        if (data.weiboId  == tmpData.weiboId)
        {
            tmpData.praised = data.praised;
            tmpData.praiseNum = data.praiseNum;
            tmpData.commentNum = data.commentNum;
        }
    }
}
#pragma mark -
#pragma mark PostCellDelegate

- (void)updateCellExpand:(BOOL)bExpand withCell:(PostCell *)cell
{
    NSIndexPath * indexpath = [self.tableView indexPathForCell:cell];
    PostDetailData *data = [self.dataSource objectAtIndex:indexpath.row];
    if (bExpand)
    {
        data.expandFlag = PostExpandExpand;
    }
    else
    {
        data.expandFlag = PostExpandUnExpand;
    }
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)commentEventWithType:(COMMENT_OPERATE_TYPE)type withCell:(PostCell *)cell
{
    NSInteger index = [self.tableView indexPathForCell:cell].row;
    PostDetailData * data = [self.dataSource objectAtIndex:index];
    if (type == MSG_COMMENT_TYPE)
    {
        [self pushToCommentDetail:data];
    }
    else
    {
        HFSubmitPraiseReq *req = [[HFSubmitPraiseReq alloc]init];
        req.weiboType = data.type;
        req.weiboId = data.weiboId;
        
        [[[HIIProxy shareProxy]weiboProxy]submitPraiseType:req complete:^(ResponseData * responseData) {
            if ([responseData success]) {
                data.praised = !data.praised;
                if (data.praised)
                {
                    data.praiseNum++;
                }
                else
                {
                    data.praiseNum--;
                }
                [cell updateCellWithData:data];
            }else {
                [MBProgressHUD showError:responseData.msg toView:self.view];
            }
        }];
    }
}

- (void)goUserCenterView:(NSInteger)userId
{
    if (userId<=0)
    {
        return;
    }
    UserCenterViewController *vc = [[UserCenterViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:userId] forKey:kParamUserId];
    vc.param = dic;
    BaseNavViewController * nav = (BaseNavViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    [nav pushViewController:vc animated:YES];
    
}

- (void)operatePostType:(HFOperatePostType)type withCell:(PostCell *)cell
{
    HFAlertView *alter = [HFAlertView initWithTitle:@"消息提示" withMessage:@"确定删除这条心情吗？" commpleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
            if (type == HFOperatePostTypeDelete) {
                [[[HIIProxy shareProxy]weiboProxy]deleteWeiboType:cell.mData.type andWeiboId:cell.mData.weiboId success:^(BOOL finished) {
                    if (finished) {
                        NSIndexPath *path = [self.tableView indexPathForCell:cell];
                        [self.dataSource removeObjectAtIndex:path.row];
                        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationFade];
                    }else{
                        
                    }
                    [HUD hide:YES];
                }];
            }
        }
    } cancelTitle:@"取消" determineTitle:@"确定"];
    
    [alter show];
}
#pragma mark -
#pragma mark shuaxin

- (void)publishSuccessPost
{
    if (self.postBarType == HFPersonal) {
        [self loadPersonalData];
        return;
    }
    [self endRefresh];
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
