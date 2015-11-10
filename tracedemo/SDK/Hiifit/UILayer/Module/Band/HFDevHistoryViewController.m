//
//  HFDevHistoryViewController.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/6.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFDevHistoryViewController.h"
#import "BandHistoryAck.h"
#import "HFNoInfoView.h"
#import "HFHistoryCell.h"

@interface HFDevHistoryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray * mSources;

@property (nonatomic, strong) UIView * mNoHistoryView;
@property (nonatomic, strong) UITableView *mTableView;

@end

@implementation HFDevHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"历史记录"];
    
    [self startReq];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)startReq
{
    //进行网络数据的请求
    
    WS(weakSelf)
    [[[HIIProxy shareProxy] bandProxy] queryBandHistory:7 withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            BandHistoryAck * data = (BandHistoryAck *)ack;
            if (data.data.count>0) {
                weakSelf.mSources = data.data;
                [weakSelf.mTableView reloadData];
            }else {
                [weakSelf setNotFoundView];
            }
        }
    }];
}

- (void)setNotFoundView
{
    [self.view addSubview:self.mNoHistoryView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HFHistoryCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HFHistoryCell" owner:self options:nil]firstObject];
    }
    
    if (indexPath.row < [self.mSources count])
    {
        BandHistoryData * data = [self.mSources objectAtIndex:indexPath.row];
        [cell setContent:data];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark -
#pragma mark getter
- (NSArray *)mSources
{
    if (!_mSources)
    {
        _mSources = [[NSArray alloc] init];
    }
    return _mSources;
}

- (UITableView *)mTableView
{
    if (!_mTableView) {
        _mTableView = [[UITableView alloc]init];
        _mTableView.backgroundColor = RGBA(234, 234, 234, 1);
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mTableView];
        [_mTableView setTableHeaderView:self.headerView];
        [_mTableView setTableFooterView:self.footerView];
        
        [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        if (self.mSources.count<7) {
            self.footerLabel.text = @"无更多历史记录";
        }else {
            self.footerLabel.text = @"无更多历史记录（至多显示7天）";
        }
    }
    return _mTableView;
}

- (UIView *)mNoHistoryView
{
    if (!_mNoHistoryView)
    {
        _mNoHistoryView = [[HFNoInfoView alloc]initWithFrame:self.view.bounds Image:IMG(@"not_found") Text:@"没有发现历史纪录！"];
        _mNoHistoryView.backgroundColor = RGBA(234, 234, 234, 1);
    }
    return _mNoHistoryView;
}

@end
