//
//  HFGoodIdeaVC.m
//  SDCycleScrollView
//
//  Created by 朱伟特 on 15/8/3.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "HFGoodIdeaViewController.h"
#import "HFGoodIdeaCell.h"
#import "HIIProxy.h"
#import "GetSuggestAck.h"
#import "WebViewController.h"
#import "NSString+HFStrUtil.h"
#import "HFVideoViewController.h"

@interface HFGoodIdeaViewController()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation HFGoodIdeaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNavigationTitle:@"锦囊妙计"];
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PrivateFunction
- (void)leftBarItemAction:(id)sender
{
    [MobClick event:Scheme_GoodIdeaBack_Click];
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

#pragma mark - load data

- (void)initData
{
    HIIProxy * proxy = [[HIIProxy alloc] init];
    WS(weakSelf)
    [proxy.schemeProxy getSuggestBySchemeId:self.schemeData.schemeId withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            GetSuggestAck * suggestAck = (GetSuggestAck *)ack;
            [weakSelf.dataArray addObjectsFromArray:suggestAck.data];
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    HFGoodIdeaCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HFGoodIdeaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    GetSuggestData * data = [self.dataArray objectAtIndex:indexPath.row];
    [cell setSuggestData:data];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [MobClick event:Scheme_GoodIdea_FirstItem];
    }
    if (indexPath.row == 1) {
        [MobClick event:Scheme_GoodIdea_SecondItem];
    }
    if (indexPath.row == 2) {
        [MobClick event:Scheme_GoodIdea_ThirdItem];
    }
    GetSuggestData *data = [self.dataArray objectAtIndex:indexPath.row];
    HFVideoViewController *vc = [[HFVideoViewController alloc]init];
    vc.fromGoodIdea = YES;
    vc.sportData = data;
    vc.schemeData = self.schemeData;
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 41;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [UILabel new];
    [label setFont:[UIFont systemFontOfSize:18]];
    [label setTextColor:[UIColor hexChangeFloat:@"999999" withAlpha:1]];
    label.text = @"   若感觉不适，推荐使用以下方法";
    return label;
}

@end
