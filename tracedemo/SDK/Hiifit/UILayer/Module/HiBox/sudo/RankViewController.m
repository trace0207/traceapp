//
//  RankViewController.m
//  GuanHealth
//
//  Created by hermit on 15/5/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "RankViewController.h"
#import "RankViewCell.h"
#import "UploadGameRes.h"

@interface RankViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource1;
@property (nonatomic, strong) NSMutableArray *dataSource2;

@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;

@end

@implementation RankViewController
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        //加载视图放在这里，tableView 的个数要与headerView的按钮个数相同；
        self.titleArray = [NSArray arrayWithObjects:@"好友",@"世界", nil];
        NSMutableArray *views = [[NSMutableArray alloc]init];
        for (int i=0; i<self.titleArray.count; i++) {
            UITableView *_tableView = [[UITableView alloc]init];
            _tableView.tag = i + 10;
            _tableView.delegate = self;
            _tableView.dataSource = self;
            [views addObject:_tableView];
        }
        self.ContentArray = views;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"好友排行"];
    self.dataSource1 = [[NSMutableArray alloc]init];
    self.dataSource2 = [[NSMutableArray alloc]init];
    
    self.tableView1 = (UITableView *)[self.scrollView viewWithTag:10];
    self.tableView2 = (UITableView *)[self.scrollView viewWithTag:11];
    
    if ([_tableView1 respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView1 setSeparatorInset:UIEdgeInsetsZero];
        [_tableView2 setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([_tableView1 respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView1 setLayoutMargins:UIEdgeInsetsZero];
        [_tableView2 setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    WS(weakSelf)
    [[[HIIProxy shareProxy]commProxy]getFriendsRank:^(UploadGameRes *data, BOOL success) {
        if (success) {
            [weakSelf.dataSource1 addObjectsFromArray:data.data];
            UploadGameData *data = [[UploadGameData alloc]init];
            UserRes *user = [GlobInfo shareInstance].usr;
            data.userId = (int)user.id;
            data.nickName = user.nickName;
            data.headPortraitUrl = user.headPortraitUrl;
            data.rowNum = data.rowNum;
            data.spendTime = data.spendTime;
            [weakSelf.dataSource1 insertObject:data atIndex:0];
            [weakSelf.tableView1 reloadData];
        }
    }];
    
    [[[HIIProxy shareProxy]commProxy]getWorldRank:^(UploadGameRes *data, BOOL success) {
        if (success) {
            NSMutableArray *arr = [NSMutableArray arrayWithArray:data.data];
            weakSelf.dataSource2 = [weakSelf exchangeObject:arr];
            [weakSelf.tableView2 reloadData];
        }
    }];
}

- (NSMutableArray *)exchangeObject:(NSMutableArray *)arr
{
    return nil;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 90;
    }
    return 75;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 10) {
        return self.dataSource1.count;
    }else if (tableView.tag == 11){
        return self.dataSource2.count;
    }
    return 0;
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
    RankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankViewCell"];
    if (cell == nil) {
        if (indexPath.row == 0) {
            cell = [[RankViewCell alloc]initWithIndex:1];
        }else{
            cell = [[RankViewCell alloc]initWithIndex:0];
        }
    }
    UploadGameData *data = nil;
    if (tableView.tag == 10) {
        data = [self.dataSource1 objectAtIndex:indexPath.row];
    }else if (tableView.tag == 11){
        data = [self.dataSource2 objectAtIndex:indexPath.row];
    }
    [cell setContentToCell:data];
    return cell;
}

@end
