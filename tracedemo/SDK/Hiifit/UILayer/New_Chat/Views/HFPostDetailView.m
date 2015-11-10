//
//  BasePostDetailView.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/21.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFPostDetailView.h"
#import "HFCommentViewController.h"
#import "CLLRefreshHeadController.h"
#import "UserCenterViewController.h"
#import "HFCaculateHeightModel.h"
#import "GlobNotifyDefine.h"
@interface HFPostDetailView()<UITableViewDelegate,UITableViewDataSource,PostCellDelegate,CLLRefreshHeadControllerDelegate,HFCommentViewControllerDelegate>
{
    NSMutableArray * mSourceData;
    
    CLLRefreshHeadController * refreshController;
}
@property(nonatomic,strong)NSArray * mSourceData;
@end


@implementation HFPostDetailView
@synthesize mSourceData;
@synthesize delegate;
@synthesize bSupportPullUpLoad;
@synthesize mTableView;
@synthesize bNeedPushUserCenter;

- (instancetype)initWithFrame:(CGRect)frame withTableViewStyle:(UITableViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self)
    {
        bNeedPushUserCenter = YES;
        _pageSize = kPageSize;
        [self loadUI:style];
    }
    return self;
}

- (void)loadUI:(UITableViewStyle)style
{
    mTableView = [[UITableView alloc]initWithFrame:self.bounds style:style];
    mTableView.backgroundColor = [UIColor HFColorStyle_6];
    self.backgroundColor = [UIColor HFColorStyle_6];
    mTableView.delegate = self;
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mTableView.dataSource = self;
    mTableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:mTableView];
    refreshController = [[CLLRefreshHeadController alloc]initWithScrollView:mTableView viewDelegate:self];
    if ([mTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [mTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([mTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [mTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (void)startRequest
{
    [refreshController startPullDownRefreshing];
}

#pragma mark -
#pragma mark public
- (void)reloadData:(NSArray *)datas
{
    self.mSourceData = datas;
    [mTableView reloadData];
}

- (void)updatePriseOrCommentForPostData:(PostDetailData *)data
{
    for (int i = 0; i < [mSourceData count]; i++) {
        PostDetailData * tmpData = [mSourceData objectAtIndex:i];
        if (data.weiboId  == tmpData.weiboId)
        {
            tmpData.praised = data.praised;
            tmpData.praiseNum = data.praiseNum;
            tmpData.commentNum = data.commentNum;
        }
    }
}

- (void)endRefreash
{
    [refreshController endPullDownRefreshing];
}
//停止上拉加载
- (void)endLoad
{
    [refreshController endPullUpLoading];
}

#pragma mark -
#pragma mark private
- (void)pushToCommentDetail:(PostDetailData *)data
{
    HFCommentViewController * commentVC = [[HFCommentViewController alloc] init];
    //commentVC.postCellType = HFPostCellPostBar;
    commentVC.mWbID = data.weiboId;
    commentVC.delegate = self;
    commentVC.mWbType = data.type;
    commentVC.mDetailData = data;
    BaseNavViewController * nav = (BaseNavViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    [nav pushViewController:commentVC animated:YES];
}

#pragma mark -
#pragma mark TableViewDelegate && TableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mSourceData count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostDetailData *data = [mSourceData objectAtIndex:indexPath.row];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    if (cell == nil) {
        cell = [[PostCell alloc]initWithXibName:@"PostCell"];
        cell.delegate = self;
    }
    if (_showDeleteBtn) {
        cell.delBtn.hidden = NO;
    }
    PostDetailData *data = [mSourceData objectAtIndex:indexPath.row];
    cell.superview.backgroundColor = [UIColor HFColorStyle_6];
    [cell setContentToCell:data];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PostDetailData * data = [mSourceData objectAtIndex:indexPath.row];
    [self pushToCommentDetail:data];
}

#pragma mark -
#pragma mark CLL
- (BOOL)hasRefreshFooterView
{
    if (_pageSize == 0) {
        return NO;
    }
    if ([mSourceData count] == 0 || mSourceData.count % _pageSize != 0) {
        return NO;
    }
    return bSupportPullUpLoad;
}

- (void)beginPullDownRefreshing
{
    if (delegate && [delegate respondsToSelector:@selector(loadPullDownRefreashData)]) {
        [delegate loadPullDownRefreashData];
    }
}

- (void)beginPullUpLoading
{
    if (delegate && [delegate respondsToSelector:@selector(loadPullUpMoreData)]) {
        [delegate loadPullUpMoreData];
    }
}

- (CLLRefreshViewLayerType)refreshViewLayerType
{
    return CLLRefreshViewLayerTypeOnSuperView;
}

#pragma mark -
#pragma mark HFCommentViewControllerDelegate
- (void)updatePostData:(PostDetailData *)data
{
    [self updatePriseOrCommentForPostData:data];
    [mTableView reloadData];
}


#pragma mark -
#pragma mark PostCellDelegate

- (void)updateCellExpand:(BOOL)bExpand withCell:(PostCell *)cell
{
    NSIndexPath * indexpath = [self.mTableView indexPathForCell:cell];
    PostDetailData *data = [mSourceData objectAtIndex:indexpath.row];
    if (bExpand)
    {
        data.expandFlag = PostExpandExpand;
    }
    else
    {
        data.expandFlag = PostExpandUnExpand;
    }
    
    [self.mTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
  
}

- (void)commentEventWithType:(COMMENT_OPERATE_TYPE)type withCell:(PostCell *)cell
{
    NSInteger index = [mTableView indexPathForCell:cell].row;
    PostDetailData * data = [mSourceData objectAtIndex:index];
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
                [MBProgressHUD showError:responseData.msg toView:self];
            }
        }];
    }
}

- (void)goUserCenterView:(NSInteger)userId
{
    if (bNeedPushUserCenter)
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
}

- (void)operatePostType:(HFOperatePostType)type withCell:(PostCell *)cell
{
    HFAlertView *alter = [HFAlertView initWithTitle:@"消息提示" withMessage:@"确定删除这条心情吗？" commpleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
            if (type == HFOperatePostTypeDelete) {
                [[[HIIProxy shareProxy]weiboProxy]deleteWeiboType:cell.mData.type andWeiboId:cell.mData.weiboId success:^(BOOL finished) {
                    if (finished) {
                        
                        [kNotificationCenter postNotificationName:DeletePostNoticaition object:@(Wait_Refresh_TimeLine)];
                        NSIndexPath *path = [mTableView indexPathForCell:cell];
                        [mSourceData removeObjectAtIndex:path.row];
                        [mTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationFade];
                    }else{
                        
                    }
                    [HUD hide:YES];
                }];
            }
        }
    } cancelTitle:@"取消" determineTitle:@"确定"];
    
    [alter show];
}

@end
