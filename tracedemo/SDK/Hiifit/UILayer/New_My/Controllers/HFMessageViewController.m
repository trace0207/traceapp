//
//  HFMessageViewController.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/20.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFMessageViewController.h"
#import "MessageBoxProxy.h"
#import "HFMessageDetailView.h"
#import "HFCommentViewController.h"
#import "UserCenterViewController.h"
#import "HFSystemMSGViewController.h"
#import "UIViewController+TKNavigationBarSetting.h"
#define kBaseMessageTableViewTag   100

@interface HFMessageViewController ()<HFMessageDetailViewDelegate>
{
    NSMutableArray * mViewsArray;
    
    NSMutableArray * mSourceArray;
    NSMutableArray * mflagArray;
    NSInteger  mCurrentIndex;
}
@end

@implementation HFMessageViewController
@synthesize mSourceMessageCountArr;
@synthesize delegate;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        mCurrentIndex = 0;
        mflagArray = [[NSMutableArray alloc]initWithObjects:@(1),@(0),@(0),@(0),nil];
        mViewsArray = [[NSMutableArray alloc] init];
        mSourceArray = [[NSMutableArray alloc] init];
        self.titleArray = [NSArray arrayWithObjects:_T(@"HF_Common_Comment"),_T(@"HF_Common_Prise"),_T(@"HF_Common_New_Funs"),_T(@"HF_Common_System_Notes"), nil];
        for (int i=0; i<self.titleArray.count; i++)
        {
            HFMessageDetailView * detailView = [[HFMessageDetailView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 108) withTableViewStyle:UITableViewStylePlain];
            detailView.delegate = self;
            detailView.backgroundColor = [UIColor HFColorStyle_6];
            [mViewsArray addObject:detailView];
            
            NSMutableArray * array = [[NSMutableArray alloc] init];
            [mSourceArray addObject:array];
        }
        self.scrollView.backgroundColor = [UIColor HFColorStyle_6];
        self.hasSeperatorLine = YES;
        self.selectTextColor = [UIColor HFColorStyle_5];
        self.unselectTextColor = [UIColor HFColorStyle_3];
        self.headerColor = [UIColor whiteColor];
        self.ContentArray = mViewsArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addDefaultLeftBarItem];
    [self addNavigationTitle:_T(@"HF_Common_Messages")];    
    self.BTScrolldelegate = self;
    
    //为了防止推送的延迟性
    [self requestMessageCount];
    
    // Do any additional setup after loading the view.
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKremoveNavigationTitle];
    [self TKremoveLeftBarButtonItem];
    [self TKremoveRightBarButtonItem];
    [self TKaddNavigationTitle:@"消息"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//- (void)leftBarItemAction:(id)sender
//{
//    if (delegate && [delegate respondsToSelector:@selector(updateMessageBoxIcon:)]) {
//        NSInteger unRead = 0;
//        for (NSInteger i = 1; i < [mSourceMessageCountArr count]; i++)
//        {
//             unRead += [[mSourceMessageCountArr objectAtIndex:i] integerValue];
//        }
//        [mSourceMessageCountArr replaceObjectAtIndex:0 withObject:@(0)];
//        [delegate updateMessageBoxIcon:unRead];
//    }
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (delegate && [delegate respondsToSelector:@selector(updateMessageBoxIcon:)]) {
        NSInteger unRead = 0;
        for (NSInteger i = 1; i < [mSourceMessageCountArr count]; i++)
        {
            unRead += [[mSourceMessageCountArr objectAtIndex:i] integerValue];
        }
        
        NSInteger num = [[mSourceMessageCountArr objectAtIndex:mCurrentIndex]integerValue];
        if (num>0) {
            [self resetMessageReadedForType:mCurrentIndex];
        }
        [mSourceMessageCountArr replaceObjectAtIndex:0 withObject:@(0)];
        [delegate updateMessageBoxIcon:unRead];
    }
}

#pragma mark -
#pragma mark private

- (void)requestMessageCount
{
    WS(weakSelf)
    [[[HIIProxy shareProxy] messageBoxProxy] hasUnReadMessageWithCompletion:^(HFMessageBoxData * res) {
        [weakSelf resetMessageInfo:res];
        
        [weakSelf startTypeRequest];
    }];
}

- (void)startTypeRequest
{
    HFMessageDetailView * view = [mViewsArray objectAtIndex:0];
    [view startRequest];
}

- (void)resetMessageInfo:(HFMessageBoxData *)res
{
    [mSourceMessageCountArr removeAllObjects];
    [mSourceMessageCountArr addObject:@(res.unReadComentCount)];
    [mSourceMessageCountArr addObject:@(res.unReadPraiseCount)];
    [mSourceMessageCountArr addObject:@(res.unReadFollowCount)];
    [mSourceMessageCountArr addObject:@(res.unReadSystemCount)];
    
    //重置消息红点
    for (NSInteger i = 0; i < [mSourceMessageCountArr count]; i++) {
        NSInteger unRead = [[mSourceMessageCountArr objectAtIndex:i] integerValue];
        if (unRead > 0) {
            [self switchMessageTipState:YES atIndex:i];
        }
    }
}

- (void)reqMessageSourceAtPage:(NSInteger)page
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    [[[HIIProxy shareProxy]messageBoxProxy]reqMessageInfoWithType:mCurrentIndex atPage:page success:^(NSArray *datas) {
        [hud hide:YES];
        HFMessageDetailView * view = [mViewsArray objectAtIndex:mCurrentIndex];
        [view endRefreash];
        
        MessageType type = (MessageType)mCurrentIndex;
        NSMutableArray * arr = [mSourceArray objectAtIndex:mCurrentIndex];
        if (page == 0) {
            [arr removeAllObjects];
        }
        [arr addObjectsFromArray:datas];
        [view reloadData:arr withType:type];
    } fail:^{
        [hud hide:YES];
        HFMessageDetailView * view = [mViewsArray objectAtIndex:mCurrentIndex];
        [view endRefreash];
    }];
    
}

- (void)resetMessageReadedForType:(NSInteger)type
{
    [[[HIIProxy shareProxy] messageBoxProxy] resetMessageInfoStateWithType:type withCompletion:^{
        
        [mSourceMessageCountArr replaceObjectAtIndex:type withObject:[NSNumber numberWithInteger:0]];
        //重置数据源
        
        
        
        [self switchMessageTipState:NO atIndex:type];
    }];
}

- (void)jumpToUserInfo:(NSInteger)userID
{
    //跳转到个人主页
    UserCenterViewController * userViewController = [[UserCenterViewController alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:userID] forKey:kParamUserId];
    userViewController.param = dic;
    [self.navigationController pushViewController:userViewController animated:YES];
}

#pragma mark -
#pragma mark MessageDetailDelegate
- (void)loadPullDownRefreashData
{
    HFMessageDetailView * view = [mViewsArray objectAtIndex:mCurrentIndex];
    view.currentPage = 0;
    [self reqMessageSourceAtPage:view.currentPage];
}

- (void)loadPullUpRefreshData
{
    HFMessageDetailView * view = [mViewsArray objectAtIndex:mCurrentIndex];
    view.currentPage = 1 + view.currentPage;
    [self reqMessageSourceAtPage:view.currentPage];
}

- (void)headPageJump:(NSInteger)userId
{
    [self jumpToUserInfo:userId];
}

- (void)detailMessageActionAtIndex:(NSInteger)index withType:(MessageType)type
{
    NSMutableArray * array = [mSourceArray objectAtIndex:type];
    HFMessageTypeInfoData * data = [array objectAtIndex:index];
    if (data.flag !=1) {
        data.flag = 1;
        HFMessageDetailView * view = [mViewsArray objectAtIndex:mCurrentIndex];
        NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
        [view.mTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    if (type == MSGBOX_COMMENT_TYPE || type == MSGBOX_PRISE_TYPE)
    {
        if (type == MSGBOX_COMMENT_TYPE)
        {
            [MobClick event:Message_CommentList_Click];
        }
        else
        {
            [MobClick event:Message_PariseList_Click];
        }
        HFCommentViewController * commentController = [[HFCommentViewController alloc] init];
        commentController.mWbID = data.goalId;
        commentController.mWbType = data.source;
        if (data.source == HIWeiboTypePostBar) {
            commentController.bIsPostBar = YES;
        }
        [self.navigationController pushViewController:commentController animated:YES];
    }
    else if (type == MSGBOX_FOLLOW_TYPE)
    {
        [MobClick event:Message_FollowerList_Click];
        [self jumpToUserInfo:data.operatorId];
    }
    else
    {
        //未知待定
        HFSystemMSGViewController *vc = [[HFSystemMSGViewController alloc]init];
        vc.content = data.content;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ScrollAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            [MobClick event:Message_Comment_Click];
            break;
        case 1:
            [MobClick event:Message_Parise_Click];
            break;
        case 2:
            [MobClick event:Message_Follower_Click];
            break;
        case 3:
            [MobClick event:Message_System_Click];
            break;
        default:
            break;
    }
    
    if ([mSourceMessageCountArr count] <= index)
    {
        return;
    }
    
    HFMessageDetailView * view = [mViewsArray objectAtIndex:index];
    
    NSInteger flag = [[mflagArray objectAtIndex:index]integerValue];
    if (flag != 0) {
        NSMutableArray * array = [mSourceArray objectAtIndex:index];
        for (HFMessageTypeInfoData * data in array) {
            data.flag = 1;
        }
        [view reloadData:array withType:index];
    }else {
        flag = 1;
        [mflagArray replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:flag]];
        [view startRequest];
    }
    mCurrentIndex = index;
    //如果是评论 需要切换在消失
//    if (mCurrentIndex == 0 && index != 0)
//    {
//        NSInteger unReadComment = [[mSourceMessageCountArr objectAtIndex:mCurrentIndex] integerValue];
//        if (unReadComment > 0)
//        {
//            [self resetMessageReadedForType:mCurrentIndex];
//        }
//    }
    //重置消息已读
    NSInteger unRead = [[mSourceMessageCountArr objectAtIndex:index] integerValue];
    if (unRead > 0)
    {
        [self resetMessageReadedForType:index];
    }
    
}

@end
