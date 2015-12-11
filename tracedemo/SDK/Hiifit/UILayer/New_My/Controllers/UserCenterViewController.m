//
//  UserCenterViewController.m
//  GuanHealth
//
//  Created by hermit on 15/3/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "UserCenterViewController.h"
#import "PostCell.h"
#import "MyPostListRes.h"
#import "HomePageRes.h"
#import "HFCommentViewController.h"
#import "FriendsViewController.h"
#import "UserViewController.h"
#import "HFPostDetailView.h"
#import "HFEditInfoViewController.h"
#import "TKUserCenter.h"

@interface UserCenterViewController ()<PostCellDelegate,BasePostDetailViewDelegate>
{
    UIView *navBarView;
    UILabel *navTitleLabel;
    CGFloat headViewHeight;
}
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger pageOfset;
//@property (nonatomic, strong) HomeData *UserInfo;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) HFPostDetailView * mPostView;
@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor HFColorStyle_6];
    headViewHeight = 288;
    navBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    navBarView.backgroundColor = [UIColor HFColorStyle_5];
    navBarView.alpha = 0;
    navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    navTitleLabel.textColor = [UIColor blackColor];
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.font = [UIFont systemFontOfSize:20];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:navBarView];
    [navBarView addSubview:navTitleLabel];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 44)];
    [backBtn setImage:IMG(@"icon_back") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(leftBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:backBtn];
    
    
    _userId = ((NSNumber *)[self.param objectForKey:kParamUserId]).integerValue;
    
    
    if([TKStrFromNumber(_userId) isEqualToString:TKUserId])
    {
        [self loadMyUserPage];
    }
    
    
    
    
    
//    if (_userId > 0) {
        [self endRefresh];
//    }
}


-(void)loadMyUserPage
{

    TKUser * tkUser = [[TKUserCenter instance] getUser];
    HomeData *UserInfo = [[HomeData alloc]init];
    UserInfo.nickName = tkUser.nickName;
    UserInfo.sex = (int)tkUser.sex;
    UserInfo.signature = tkUser.signature;
    UserInfo.fansCount = 100;
    UserInfo.followCount = 200;
    UserInfo.status = 1;
    
    [self setHomeInfo:UserInfo];
    self.mPostView.hidden = NO;

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    UserRes *user = [GlobInfo shareInstance].usr;
    
    
//    if ([_userId isEqualToString:tkUser.userId]) {
//        [self.headImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:tkUser.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
//        self.sexImage.highlighted = tkUser.sex == 1;
//        self.signameLabel.text = tkUser.signature;
//        self.nameLabel.text = [tkUser nickName];
//        navTitleLabel.text = [tkUser nickName];
//    }
}

- (void)dealloc
{
    if (_mPostView) {
        [_mPostView.mTableView removeObserver:self forKeyPath:@"contentOffset"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (HFPostDetailView *)mPostView
{
    if (!_mPostView) {
        
        _mPostView = [[HFPostDetailView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) withTableViewStyle:UITableViewStylePlain];
        _mPostView.bSupportPullUpLoad = YES;
        _mPostView.pageSize = kPageSize;
        _mPostView.bNeedPushUserCenter = NO;
        _mPostView.delegate = self;
        _mPostView.mTableView.backgroundColor = [UIColor clearColor];
        _mPostView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_mPostView];
        [_mPostView sendToBack];
        self.headView.backgroundColor = [UIColor HFColorStyle_5];
        self.headView.frame = CGRectMake(0, 0, kScreenWidth, headViewHeight);
     
            if ([TKStrFromNumber(_userId) isEqualToString:TKUserId]) {
                [self.editBtn setTitle:@"编辑资料" forState:UIControlStateNormal];
                self.mPostView.showDeleteBtn = YES;
            }else{
                [self.editBtn setTitle:@"＋关注" forState:UIControlStateNormal];
                [self.editBtn setTitle:@"取消关注" forState:UIControlStateSelected];
            }
        
        [self.headImage.layer setBorderWidth:1];
        [self.headImage.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_mPostView.mTableView setTableHeaderView:self.headView];
        
        [_mPostView.mTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, headViewHeight)];
        view.backgroundColor = [UIColor HFColorStyle_5];
        [self.view addSubview:view];
        [view sendToBack];
    }
    return _mPostView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (void)setHomeInfo:(HomeData*)info
{
    
    self.funsLable.text = [NSString stringWithFormat:@"%i",info.fansCount];
    self.focusLable.text = [NSString stringWithFormat:@"%i",info.followCount];
    if (info.status == 1) {
        self.editBtn.selected = YES;
    }else{
        self.editBtn.selected = NO;
    }
    
    
    if (info.headPortraitUrl.length>0) {
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:info.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
    }else {
        [self.headImage setImage:IMG(@"head_default")];
    }
    self.signameLabel.text = info.signature;
    self.sexImage.highlighted = [info isGirl];
    self.nameLabel.text = info.nickName;
    navTitleLabel.text = info.nickName;
}


- (IBAction)seeFriendsAction:(UIButton*)sender
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (sender.tag == 1) {
        [MobClick event:User_Follower_Click];
        [dic setObject:KEY_FOLLOWS forKey:kParamFrom];
    }else{
        [dic setObject:KEY_FANS forKey:kParamFrom];
    }
    [dic setValue:TKStrFromNumber(_userId) forKey:kParamUserId];
    
    FriendsViewController *vc = [[FriendsViewController alloc]init];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)seeBigImage:(UIButton *)sender
{
    [MobClick event:User_Head_Click];
//    
//    NSString *urlStr = [UIKitTool getRawImage:_UserInfo.headPortraitUrl];
//    HFBigImageView *view = [[HFBigImageView alloc]initWithImage:_headImage.image withImageUrl:urlStr];
//    [view show];
}

- (IBAction)editUserInfo:(UIButton *)sender {
    
//    if (!self.UserInfo) {
//        return;
//    }
    if ([TKStrFromNumber(_userId) isEqualToString:TKUserId]){
        HFEditInfoViewController * editVC = [[HFEditInfoViewController alloc] init];
        [self.navigationController pushViewController:editVC animated:YES];
    }else{
//        WS(weakSelf);
//        [[[HIIProxy shareProxy]weiboProxy]followAction:_userId isFollow:!sender.selected completion:^(BOOL finished) {
//            if (finished) {
//                weakSelf.UserInfo.fansCount = sender.selected ? weakSelf.UserInfo.fansCount - 1:weakSelf.UserInfo.fansCount + 1;
//                weakSelf.UserInfo.status = sender.selected ? 0 : 1;
//                [weakSelf setHomeInfo:weakSelf.UserInfo];
//            }
//        }];
    }
}

- (void)endLoadMore
{
    WS(weakSelf);
    HFGetPostsReq *req = [[HFGetPostsReq alloc]init];
    req.pageOffset = _pageOfset;
//    req.userId = _userId;
    req.pageSize = kPageSize;
    
    [[[HIIProxy shareProxy]weiboProxy]getUserCenterPost:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
        if (success) {
            if (postList.count>0) {
                weakSelf.pageOfset = weakSelf.pageOfset + postList.count;
                for (int i = 0; i < postList.count; i++) {
                    PostDetailData *post = [postList objectAtIndex:i];
                    [weakSelf.dataSource addObject:post];
                    if (i == postList.count - 1) {
                        [weakSelf.mPostView reloadData:weakSelf.dataSource];
                    }
                }
                
            }
        }
        [weakSelf.mPostView endLoad];
    }];
}

- (void)endRefresh
{
    WS(weakSelf)
//    [[[HIIProxy shareProxy]userProxy]getUserHomePage:_userId completion:^(HomeData *userInfo, BOOL success) {
//        if (success) {
//            weakSelf.mPostView.hidden = NO;
//            weakSelf.UserInfo = userInfo;
//            [weakSelf setHomeInfo:userInfo];
//        }
//        
//    }];
    
    HFGetPostsReq *req = [[HFGetPostsReq alloc]init];
    req.pageOffset = 0;
//    req.userId = _userId;
    req.pageSize = kPageSize;
    
    [[[HIIProxy shareProxy]weiboProxy]getUserCenterPost:req completion:^(NSArray<PostDetailData> *postList, BOOL success) {
        if (success) {
            if (postList.count>0) {
                weakSelf.mPostView.hidden = NO;
                [weakSelf.dataSource removeAllObjects];
                weakSelf.pageOfset = postList.count;
                [weakSelf.dataSource addObjectsFromArray:postList];
                [weakSelf.mPostView reloadData:weakSelf.dataSource];
            }
        }
        if (_mPostView) {
            [weakSelf.mPostView endRefreash];
        }
    }];
}

#pragma mark 
#pragma mark PostDetailViewDelegate
- (void)loadPullDownRefreashData
{
    [self endRefresh];
}

- (void)loadPullUpMoreData
{
    [self endLoadMore];
}

#pragma mark - contentoffsize

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat contentOffsetY = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue].y;
        if (contentOffsetY>=0 && contentOffsetY<=headViewHeight) {
            navBarView.alpha = contentOffsetY/headViewHeight;
        }
    }
}

@end
