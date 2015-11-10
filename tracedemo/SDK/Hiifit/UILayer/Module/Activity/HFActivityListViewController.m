//
//  HFActivityListViewController.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFActivityListViewController.h"
#import "BaseTableView.h"
#import "HFActivityListCell.h"
#import "WebViewController.h"
@interface HFActivityListViewController ()<UITableViewDataSource,UITableViewDelegate,BaseTableViewDelegate>
{
    BaseTableView * mTableView;
    
    NSInteger   mIndex;
}
@end

@implementation HFActivityListViewController
@synthesize sources;

- (id)init
{
    self = [super init];
    if (self)
    {
        mIndex = 0;
        sources = [[NSMutableArray alloc] init];
        if (IOS7_OR_LATER) {
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.modalPresentationCapturesStatusBarAppearance = NO;
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor HFColorStyle_6];
    
    [self addNavigationTitle:_T(@"嗨活动")];
    
    mTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.baseDelegate = self;
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mTableView];
    
    [mTableView registerNib:[UINib nibWithNibName:@"HFActivityListCell" bundle:nil] forCellReuseIdentifier:@"activityListCell"];

    mTableView.bPullDownRefreash = YES;
    mTableView.bPullUpRefreash = YES;
    [mTableView startRequest];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)startRequest
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    WS(weakSelf)
    [[[HIIProxy shareProxy] activityProxy] requestActivityListAtPageIndex:0 Success:^(NSArray<HFActivityListData> *data, NSInteger total) {
        [hud hide:YES];
        [weakSelf.sources removeAllObjects];
        [weakSelf.sources addObjectsFromArray:data];
        mIndex = [weakSelf.sources count] / 10;
        [weakSelf reloadUI:total];
        [mTableView endRefreash];
    } Fail:^(BOOL finish) {
        [hud hide:YES];
        [mTableView endRefreash];
    }];
}

- (void)startLoadMore
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    WS(weakSelf)
    [[[HIIProxy shareProxy] activityProxy] requestActivityListAtPageIndex:mIndex Success:^(NSArray<HFActivityListData> *data , NSInteger total) {
        [hud hide:YES];
        [weakSelf.sources addObjectsFromArray:data];
        mIndex = [weakSelf.sources count] / 10;
        [weakSelf reloadUI:total];
        [mTableView endLoadMore];
    } Fail:^(BOOL finish) {
        [hud hide:YES];
        [mTableView endLoadMore];
    }];
}

#pragma mark -
#pragma mark UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sources count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 224.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFActivityListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"activityListCell"];
    if (indexPath.section < [sources count])
    {
        HFActivityListData * data = [sources objectAtIndex:indexPath.section];
        [cell setContentCell:data];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HFActivityListData * data = [sources objectAtIndex:indexPath.section];
    
    [MobClick event:Check_Activity_Info];
    WebViewController *vc = [[WebViewController alloc]init];
    vc.moduleType = HIModuleTypeActivity;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSString * url;
    if (data.type == 1)
    {
        url = [NSString stringWithFormat:@"%@%ld",kURLNewActivity,(long)data.id];
    }
    else
    {
        url = data.url;
    }
    
    [dic setValue:url forKey:kParamURL];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -
#pragma mark private
- (void)reloadUI:(NSInteger)total
{
    [mTableView reloadData];
    
    if ([self.sources count] == total)
    {
        [mTableView resetFooterRefreash:NO];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)pullDownAction
{
    [self startRequest];
}

- (void)pullUpAction
{
    [self startLoadMore];
}

@end
