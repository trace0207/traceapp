//
//  FindViewController.m
//  GuanHealth
//
//  Created by hermit on 15/4/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "FindViewController.h"
#import "WebViewController.h"
#import "CLLRefreshHeadController.h"
#import "MyPostListRes.h"
#import "HFCommentViewController.h"
#import "HFPostDetailView.h"

#define  kBaseTableViewTag  10

@interface FindViewController ()<CLLRefreshHeadControllerDelegate,PostCellDelegate,BasePostDetailViewDelegate>
{
    NSInteger  mCurrentindex;
    
    NSMutableArray   * mSourceArray;
    
    NSMutableArray   * mViewArray;
    
    NSMutableArray   * mOffsetArray;
}

@end
@implementation FindViewController
- (id)init
{
    self = [super init];
    if (self)
    {
        mSourceArray = [[NSMutableArray alloc] init];
        mViewArray = [[NSMutableArray alloc] init];
        
        mOffsetArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",nil];
        // Custom initialization
        //加载视图放在这里，tableView 的个数要与headerView的按钮个数相同；
        self.titleArray = [NSArray arrayWithObjects:_T(@"HF_Common_Hot"),_T(@"HF_Common_Interest"),_T(@"HF_Common_Friends"), nil];
        for (int i=0; i<self.titleArray.count; i++) {
            HFPostDetailView *_tableView = [[HFPostDetailView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 108) withTableViewStyle:UITableViewStylePlain];
            _tableView.bSupportPullUpLoad = YES;
            _tableView.tag = i + 10;
            _tableView.delegate = self;
            [mViewArray addObject:_tableView];
        }
        self.ContentArray = mViewArray;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.BTScrolldelegate = self;
    [self addNavigationTitle:_T(@"HF_Common_Find")];
    [self addRightBarItemWithTitle:_T(@"HF_Common_Add_Friends")];
    
    for (int i = 0; i < 3; i++) {
        NSMutableArray * array = [[NSMutableArray alloc] init];
        [mSourceArray addObject:array];
    }
    [self requesetSource];
}


- (void)requesetSource
{
    HFPostDetailView * view = (HFPostDetailView *)[mViewArray objectAtIndex:mCurrentindex];
    [view startRequest];
}

- (void)dealloc
{
    self.BTScrolldelegate = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)leftBarItemAction:(id)sender
{
    [MobClick event:Find_Back];
    [super leftBarItemAction:sender];
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

#pragma scroll delegate

- (void)ScrollAtIndex:(NSInteger)index
{
    mCurrentindex = index;
    if (index == 0) {
        [MobClick event:Find_Hot];
    }else if (index == 1){
        [MobClick event:Find_Interest];
    }else{
        [MobClick event:Find_Friend];
    }
    NSMutableArray * array = [mSourceArray objectAtIndex:mCurrentindex];
    
    if ([array count] == 0)
    {
        [self requesetSource];
    }
}

- (void)endRefresh
{
    HIFindType type = (HIFindType)(mCurrentindex + 1);
    HFGetPostListReq *req = [[HFGetPostListReq alloc]init];
    req.type = type;
    req.pageSize = kPageSize;
    req.pageOffset = 0;
    [[[HIIProxy shareProxy]weiboProxy]getPostList:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
        HFPostDetailView * view = [mViewArray objectAtIndex:mCurrentindex];
        if (success) {
            NSMutableArray * array = [mSourceArray objectAtIndex:mCurrentindex];
            [array removeAllObjects];
            [array addObjectsFromArray:postList];
            //edit by shidongdong 20151015
            [mOffsetArray replaceObjectAtIndex:mCurrentindex withObject:[NSNumber numberWithInteger:[postList count]]];
            [view reloadData:array];
        }
        [view endRefreash];
    }];
}

- (void)endLoad
{
    NSInteger pagOffset = [[mOffsetArray objectAtIndex:mCurrentindex] integerValue];
    
    HIFindType type = (HIFindType)(mCurrentindex + 1);
    HFGetPostListReq *req = [[HFGetPostListReq alloc]init];
    req.type = type;
    req.pageSize = kPageSize;
    req.pageOffset = pagOffset;
    
    [[[HIIProxy shareProxy]weiboProxy]getPostList:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
        HFPostDetailView * view = [mViewArray objectAtIndex:mCurrentindex];
        if (success) {
            NSInteger offset = pagOffset + (int)postList.count;
            [mOffsetArray replaceObjectAtIndex:mCurrentindex withObject:[NSNumber numberWithInteger:offset]];
            NSMutableArray * array = [mSourceArray objectAtIndex:mCurrentindex];
            
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

#pragma download data

- (void)loadPullDownRefreashData
{
    [self endRefresh];
}

- (void)loadPullUpMoreData
{
    [self endLoad];
}




@end
