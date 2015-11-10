//
//  HFPraiseUsersViewController.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/10/28.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import "HFPraiseUsersViewController.h"
#import "UserCenterViewController.h"
#import "HFCommentLikeListData.h"
#import "HFDefaultCell.h"
#import "CLLRefreshHeadController.h"

@interface HFPraiseUsersViewController ()<UITableViewDataSource,UITableViewDelegate,CLLRefreshHeadControllerDelegate>
{
    CLLRefreshHeadController * refreshController;;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HFPraiseUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"赞过的人"];
    refreshController = [[CLLRefreshHeadController alloc]initWithScrollView:self.tableView viewDelegate:self];
    //[self.tableView reloadData];
    // Do any additional setup after loading the view.
    WS(weakSelf)
    [[[HIIProxy shareProxy]weiboProxy]getLikeUsers:self.req complete:^(NSArray<HFCommentLikeListData> *likeUsersData, BOOL success) {
        if (success) {
            [weakSelf.dataSource addObjectsFromArray:likeUsersData];
            self.req.pageOffset += likeUsersData.count;
            [weakSelf.tableView reloadData];
        }
        [refreshController endPullDownRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HFDefaultCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    HFDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//    }
    HFCommentLikeListData *data = [self.dataSource objectAtIndex:indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:data.headPortraitUrl]] placeholderImage:IMG(@"head_default")];
    cell.textLabel.text = data.nickName;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFCommentLikeListData *data = [self.dataSource objectAtIndex:indexPath.row];
    UserCenterViewController *vc = [[UserCenterViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:data.userId] forKey:kParamUserId];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - refresh delegate

- (void)beginPullDownRefreshing
{
    self.req.pageOffset = 0;
    WS(weakSelf)
    [[[HIIProxy shareProxy]weiboProxy]getLikeUsers:self.req complete:^(NSArray<HFCommentLikeListData> *likeUsersData, BOOL success) {
        if (success) {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.dataSource addObjectsFromArray:likeUsersData];
            self.req.pageOffset += likeUsersData.count;
            [weakSelf.tableView reloadData];
        }
        [refreshController endPullDownRefreshing];
    }];
}
- (void)beginPullUpLoading
{
    WS(weakSelf)
    [[[HIIProxy shareProxy]weiboProxy]getLikeUsers:self.req complete:^(NSArray<HFCommentLikeListData> *likeUsersData, BOOL success) {
        if (success) {
            [weakSelf.dataSource addObjectsFromArray:likeUsersData];
            self.req.pageOffset += likeUsersData.count;
            [weakSelf.tableView reloadData];
        }
        [refreshController endPullUpLoading];
    }];
}
- (CLLRefreshViewLayerType)refreshViewLayerType
{
    return CLLRefreshViewLayerTypeOnSuperView;
}
- (BOOL)hasRefreshFooterView
{
    return (self.dataSource.count>0 && self.dataSource.count%kPageSize == 0);
}

@end
