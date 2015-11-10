//
//  HFCommentViewController.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFCommentViewController.h"
#import "HFCommentView.h"
#import "HFCommentLikeListRes.h"
#import "HFCommentUsersRes.h"
#import "UserCenterViewController.h"
#import "NSString+HFStrUtil.h"
#import "HFReportView.h"
#import "ZBMessageTextView.h"
#import "ZBMessageManagerFaceView.h"
#import "HFKeyBoard.h"
#import "HFInputView.h"
#import "HFCaculateHeightModel.h"
#import "CLLRefreshHeadController.h"
#import "HFPraiseUsersViewController.h"
@interface HFCommentViewController ()<UITextFieldDelegate,UIScrollViewDelegate,PostCellDelegate,HFCommentViewDelegate,CLLRefreshHeadControllerDelegate,HFKeyBoardDelegate>
{
    
    UIScrollView * mBgScrollView;
    
    HFCommentView * mCommentView;
    
    PostCell * mMsgDetailView;
    
    NSInteger   mAuthorID;
    
    BOOL   bParised;
    
    CGFloat mOrignHeight;
    
    CLLRefreshHeadController * mRefreshController;
    
    MBProgressHUD * mHud;
    
    NSDictionary * _faceMap;
    
    HFKeyBoard * keyboard;
}

@property (nonatomic,assign) CGFloat previousTextViewContentHeight;

@property (nonatomic, strong) UIView * bgView;

@property (nonatomic, copy) NSString * commentContent;
@property (nonatomic, assign) NSInteger commentId;
@property (nonatomic, assign) NSInteger followedId;
@end

@implementation HFCommentViewController
@synthesize mWbID,mWbType;
@synthesize mDetailData;
@synthesize delegate;
#pragma mark -
#pragma mark SystemMothed
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.mWbType == HIWeiboTypePostBar) {
        [self addNavigationTitle:@"帖子详情"];
    }
    if (self.mWbType == HIWeiboTypeModule || self.mWbType == HIWeiboTypeHabit) {
        [self addNavigationTitle:_T(@"HF_Common_Mood")];
    }
    [self loadDataSource];
    [self loadUI];
    [mRefreshController startPullDownRefreshing];
    // Do any additional setup after loading the view.
}

- (void)leftBarItemAction:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(updatePostData:)])
    {
        [delegate updatePostData:mDetailData];
    }
    [self back];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark private
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)endLoadingState
{
    if (mHud)
    {
        [mHud hide:YES];
        mHud = nil;
    }
    
    if (mRefreshController.refreshState != CLLRefreshStateStopped)
    {
        [mRefreshController endPullDownRefreshing];
    }
    
    mBgScrollView.contentSize = CGSizeMake(mBgScrollView.frame.size.width, mBgScrollView.frame.size.height + 64);
}

- (void)requestNetDataSource
{
    if (!mHud) {
        mHud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    }
    
    if (!mDetailData)
    {
        WS(weakSelf);
        HFPostDetailReq *req = [[HFPostDetailReq alloc]init];
        req.weiboType = mWbType;
        req.weiboId = mWbID;
        [[[HIIProxy shareProxy]weiboProxy]getPostDetail:req completion:^(PostDetailData *post, BOOL success) {
            if (success) {
                [weakSelf setMessageInfo:post];
                [weakSelf getLikeList];
            }else {
                [weakSelf endLoadingState];
            }
        }];
    }
    else
    {
        [self setMessageInfo:mDetailData];
        
        [self getLikeList];
    }
}


- (void)getLikeList
{
    WS(weakSelf);
    HFLikeUsersReq *req = [[HFLikeUsersReq alloc]init];
    req.weiboType = mWbType;
    req.weiboId = mWbID;
    req.pageOffset = 0;
    req.pageSize = 9;
    [[[HIIProxy shareProxy]weiboProxy]getLikeUsers:req complete:^(NSArray<HFCommentLikeListData> *likeUsersData, BOOL success) {
        if (success) {
            [weakSelf setCommentLikeList:likeUsersData];
            [weakSelf getCommentList];
        }else {
            [weakSelf endLoadingState];
        }
    }];
}

- (void)getCommentList
{
    WS(weakSelf);
    
    [[[HIIProxy shareProxy]weiboProxy]getCommentUsersType:mWbType weiboId:mWbID complete:^(HFRetModel *ret) {
        if (ret.bSuccess) {
            HFCommentUsersRes * res = (HFCommentUsersRes *)ret.data;
            [weakSelf setCommentUsersList:res.data];
        }
        if (mHud)
        {
            [mHud hide:YES];
            mHud = nil;
        }
        
        if (mRefreshController.refreshState != CLLRefreshStateStopped)
        {
            [mRefreshController endPullDownRefreshing];
        }
        if (ret.code == POST_DELETE)
        {
            [weakSelf performSelector:@selector(back) withObject:nil afterDelay:0.5];
        }
    }];
}

//设置详情列表
- (void)setMessageInfo:(PostDetailData *)postData
{
    if (mMsgDetailView.hidden) {
        mMsgDetailView.hidden = NO;
    }
    //将列表记录下
    self.mDetailData = postData;
    self.mDetailData.expandFlag = PostExpandNone;
    [mMsgDetailView setContentToCell:mDetailData];
    mMsgDetailView.backgroundColor = [UIColor whiteColor];
    [mMsgDetailView.contentView setBackgroundColor:[UIColor whiteColor]];
    [mMsgDetailView.backgroundImageView setHidden:YES];
    //重新计算出高度
    CGFloat heghit;
    
    HFCaculateHeightModel * model = [UIKitTool heightForEmojiText:postData isMainView:NO];
    heghit = model.cellHeight;
    
    if (self.bIsPostBar) {
        CGFloat emojiHeight = [UIKitTool heightForCell:postData.content withFont:16 withWidth:kScreenWidth-30];
        mMsgDetailView.frame = CGRectMake(0, 0, self.view.frame.size.width, heghit + emojiHeight);
        //mOrignHeight = heghit + emojiHeight;
    }else {
        mMsgDetailView.frame = CGRectMake(0, 0, self.view.frame.size.width, heghit);
        //mOrignHeight = heghit;
    }
    mOrignHeight = CGRectGetMaxY(mMsgDetailView.frame);
}

//设置点赞列表
- (void)setCommentLikeList:(NSArray *)likes
{
//    if (likes == nil)
//    {
//        return;
//    }
    
    //重置喜欢按钮
    
    mCommentView.mLikeImages = likes;
    CGFloat height = [mCommentView updateLikeUI];
    mCommentView.frame = CGRectMake(0, mOrignHeight, self.view.frame.size.width, height);
    [self resetScrollViewMaxSize];
}

//设置评论列表
- (void)setCommentUsersList:(NSArray *)users
{
    if ([users count] == 0)
    {
        return;
    }
    //重置评论按钮
    mDetailData.commentNum = [users count];
    [mMsgDetailView updateCellWithData:mDetailData];
    
    mCommentView.mCommentInfos = users;
    CGFloat height = [mCommentView updateCommentUI];
    mCommentView.frame = CGRectMake(0, mOrignHeight, self.view.frame.size.width, height);
    [self resetScrollViewMaxSize];
}

- (void)resetScrollViewMaxSize
{
    //HJK-345
    CGFloat sizeHeight = mCommentView.frame.origin.y + mCommentView.frame.size.height + 16;
    CGFloat maxHeight = sizeHeight > mBgScrollView.frame.size.height ? sizeHeight : mBgScrollView.frame.size.height;
    mBgScrollView.contentSize = CGSizeMake(mBgScrollView.frame.size.width, maxHeight + 64);
}

- (void)loadDataSource
{
    mAuthorID = -1;
}



- (void)loadUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    //创建基本的bgView
    mBgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 62 - 64)];
    mBgScrollView.delegate = self;
    [self.view addSubview:mBgScrollView];
    
    //创建MSG信息条
    if (self.bIsPostBar) {
        mMsgDetailView = [[PostCell alloc] initWithIndex:2];
        mMsgDetailView.bIsDetail = YES;
    }else{
        mMsgDetailView = [[PostCell alloc] initWithIndex:0];
    }
    [mMsgDetailView setReportActivity:YES];
    mMsgDetailView.delegate = self;
    mMsgDetailView.hidden = YES;
    [mBgScrollView addSubview:mMsgDetailView];
     
    //创建评论的view
    mCommentView = [[HFCommentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    mCommentView.delegate = self;
    [mBgScrollView addSubview:mCommentView];

    
    keyboard = [[HFKeyBoard alloc] initWithSuperView:self.view];
    keyboard.delegate = self;
    mRefreshController = [[CLLRefreshHeadController alloc] initWithScrollView:mBgScrollView viewDelegate:self];
    
}
- (void)resetDefultInput
{
    mAuthorID = -1;
}

#pragma mark -
#pragma mark KeyBoardDelegate
- (BOOL)checkText:(NSString *)text
{
    if (![UIKitTool checkSensitiveWords:text]) {
        HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"你发送的内容含有敏感词汇，请修改后发送。" commpleteBlock:^(NSInteger buttonIndex) {
            
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [alter show];
        [keyboard openBtnUserActivity];
        return NO;
    }
    
    if (text.length > 400) {
        HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"内容不能超过400个字符" commpleteBlock:^(NSInteger buttonIndex) {
            
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [alter show];
        [keyboard openBtnUserActivity];
        return NO;
    }

    return YES;
}
- (void)hf_keyBoardReportHeight:(CGFloat)keyboardHeight
{
    mBgScrollView.frame = CGRectMake(0, mBgScrollView.frame.origin.y, mBgScrollView.frame.size.width, self.view.frame.size.height - keyboardHeight);
}


- (void)hf_sendinPutText:(NSString *)text
{
    //发表评论
    NSString * content = [text URLEncodedForString];
    HFSubmitCommentReq *req = [[HFSubmitCommentReq alloc]init];
    req.weiboType = mWbType;
    req.weiboId = mWbID;
    req.authorId = mAuthorID<=0?@"":[NSString stringWithFormat:@"%li",(long)mAuthorID];
    req.content = content;
    WS(weakSelf)
    [[[HIIProxy shareProxy]weiboProxy]submitCommentType:req complete:^(BOOL finished) {
        [weakSelf resetDefultInput];
        if (finished) {
            mDetailData.commentNum++;
            //此处评论成功，重新刷新列表
            [keyboard giveupFirstResponerWithTextClear:YES];
            [weakSelf getCommentList];
            if (mBgScrollView.contentSize.height - 62 > kScreenHeight) {
                [mBgScrollView setContentOffset:CGPointMake(0, mBgScrollView.contentSize.height - kScreenHeight + 62 + 64) animated:YES];
            }
        }else{
            keyboard.zbMessageTextView.text = text;
            [keyboard openBtnUserActivity];
        }
    }];
}

#pragma mark -
#pragma mark PostCellDelegate
- (void)commentEventWithType:(COMMENT_OPERATE_TYPE)type withCell:(PostCell *)cell
{
    if (type == MSG_COMMENT_TYPE) {
        [keyboard textViewNeedBecomeFirstResponder];
    }else{
        HFSubmitPraiseReq *req = [[HFSubmitPraiseReq alloc]init];
        req.weiboType = mWbType;
        req.weiboId = mWbID;
        WS(weakSelf)
        [[[HIIProxy shareProxy]weiboProxy]submitPraiseType:req complete:^(ResponseData * responseData) {
            if ([responseData success]) {
                mDetailData.praised = !mDetailData.praised;
                mDetailData.praiseNum = mDetailData.praised?mDetailData.praiseNum+1:mDetailData.praiseNum-1;
                [mMsgDetailView updateCellWithData:mDetailData];
                [weakSelf getLikeList];
            }else {
                [MBProgressHUD showError:responseData.msg toView:self.view];
            }
        }];
    }
}

- (void)goUserCenterView:(NSInteger)userId
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

- (void)operatePostType:(HFOperatePostType)type withCell:(PostCell *)cell
{
    if (type == HFOperatePostTypeReport) {
        [keyboard giveupFirstResponerWithTextClear:NO];
        HFReportView *view = [[HFReportView alloc]init];
        view.frame = kScreenBounds;
        view.data = cell.mData;
        [[UIKitTool getAppdelegate].window addSubview:view];
    }
}

#pragma mark -
#pragma mark HFCommentViewDelegate
- (void)startComment:(NSInteger)authorID nickName:(NSString *)nickName
{
    NSInteger userId = [[[GlobInfo shareInstance] usr] id];
    if (userId != authorID)
    {
        mAuthorID = authorID;
        ZBMessageTextView * textView = [keyboard zbMessageTextView];
        HFInputView * inputView = (HFInputView *)textView.superview;
        
        if ([inputView respondsToSelector:@selector(initPlaceholder:)])
        {
            [inputView initPlaceholder:[NSString stringWithFormat:@"%@:%@", _T(@"HF_Common_Reply"), nickName]];
        }
        
        [textView becomeFirstResponder];
    }
}
- (void)headPageJumpAction:(NSInteger)userId
{
    if (userId<=0)
    {
        return;
    }
    UserCenterViewController *vc = [[UserCenterViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:userId] forKey:kParamUserId];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)jumpToLikeUsersList:(NSArray *)users
{
    HFLikeUsersReq *req = [[HFLikeUsersReq alloc]init];
    req.weiboType = mWbType;
    req.weiboId = mWbID;
    req.pageOffset = 0;
    req.pageSize = kPageSize;
    HFPraiseUsersViewController *vc = [[HFPraiseUsersViewController alloc]init];
    vc.req = req;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)commentViewHandle:(HFCommentUsersData *)data infoView:(HFCommentInfoView *)infoView
{
    [self.view becomeFirstResponder];
    self.commentId = data.commentId;
    self.commentContent = data.content;
    self.followedId = data.followerId;
    UIMenuController * menu = [UIMenuController sharedMenuController];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillHide:) name:UIMenuControllerWillHideMenuNotification object:nil];
    UIMenuItem * copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyComment)];
    UIMenuItem * deleteItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteComment)];
    menu.menuItems = @[copyItem, deleteItem];
    [menu setTargetRect:CGRectMake(infoView.frame.size.width / 2, 20, 50, 50) inView:infoView];
    [menu setMenuVisible:YES];

}
#pragma mark -
#pragma mark CLLDelegate
- (CLLRefreshViewLayerType)refreshViewLayerType
{
    return CLLRefreshViewLayerTypeOnScrollViews;
}

- (void)beginPullDownRefreshing
{
    [self requestNetDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - privateFunction

- (void)copyComment
{
    UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.commentContent;
}
- (void)deleteComment
{
    if (self.followedId == [[[GlobInfo shareInstance] usr] id]) {
        WS(weakSelf);
        [[[HIIProxy shareProxy] weiboProxy] deleteWeiboCommentType:mWbType andCommentId:self.commentId andWeiboId:mWbID success:^(BOOL finished) {
            if (finished) {
                [weakSelf getCommentList];
            }
        }];
    }
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (void)menuWillHide:(NSNotification *)notification
{
    [self getCommentList];//需改进,使用通知实现;
}
@end
