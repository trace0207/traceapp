//
//  HFUnlockViewController.m
//  SDCycleScrollView
//
//  Created by 朱伟特 on 15/8/3.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "HFUnlockViewController.h"
#import "HFAnimationView.h"
#import "HFGIFView.h"
#import "HFUnlockCell.h"
#import "HFHealthViewController.h"
#import "HIIProxy.h"
#import "GetSchemeStepResultAck.h"

@interface HFUnlockViewController ()<UITableViewDataSource , UITableViewDelegate, HFUnlockCellDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) HFGifView * gifView;
@property (nonatomic, strong) GetSchemeStepResultData * data;


@end

@implementation HFUnlockViewController
- (id)initWithType:(HFUnlockType)unlockType
{
    self = [super init];
    if (self) {
        self.unlockType = unlockType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.unlockType == HFAdapt) {
        [self addNavigationTitle:@"熬过适应阶段咯！"];
    }
    if (self.unlockType == HFSteady) {
        [self addNavigationTitle:@"熬过强化阶段咯！"];
    }
    if (self.unlockType == HFOver) {
        [self addNavigationTitle:@"完成咯！"];
    }
    if (self.unlockType == HFReStart) {
        [self addNavigationTitle:@"完成咯！"];
    }
    [self loadUI];
    [self initData];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark PrivateFunction
- (void)loadUI
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = YES;
    [self.view addSubview:self.tableView];
    
    NSURL * fileURL = nil;
    fileURL = [[NSBundle mainBundle] URLForResource:@"unlockGif" withExtension:@"gif"];
    if (self.unlockType == HFOver || self.unlockType == HFReStart) {
        fileURL = [[NSBundle mainBundle] URLForResource:@"cupGif" withExtension:@"gif"];
    }
    HFGifView * gifView = [[HFGifView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 0.468) fileURL:fileURL];
    self.tableView.tableHeaderView = gifView;
    [gifView startGif];
}
- (void)initData
{
    if (self.schemeData.currStage == 0) {
        self.schemeData.currStage = 3;
    }
    WS(weakSelf);
    [[[HIIProxy shareProxy] schemeProxy] getSchemeStepResult:self.schemeData.currStage withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            GetSchemeStepResultAck * resultAck = (GetSchemeStepResultAck *)ack;
            weakSelf.data = resultAck.data;
            [self.tableView reloadData];
        }
    }];
}
#pragma mark -
#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"identifier";
    HFUnlockCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        if (indexPath.row == 2 && self.unlockType == HFOver) {
            cell = [[HFUnlockCell alloc] initWithIndex:indexPath.row + 1];
        }
        else if (indexPath.row == 2 && self.unlockType == HFReStart){
            cell = [[HFUnlockCell alloc] initWithIndex:indexPath.row + 2];
        }
        else{
            cell = [[HFUnlockCell alloc] initWithIndex:indexPath.row];
        }
    }
    cell.delegate = self;
    cell.schemeData = self.data;
    cell.unlockType = self.unlockType;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0f]};
    CGFloat height = [UIKitTool caculateHeight:self.data.stageSuggest sizeOfWidth:kScreenWidth - 36 - 15 withAttributes:attributes];
    if (indexPath.row == 0) {
        return 104;
    }
    if (indexPath.row == 1) {
        if (self.unlockType != HFAdapt) {
            return 149;
        }
        return 125;
    }
    if (indexPath.row == 2) {
        return 120 + height;
    }
    return 0;
}
#pragma mark -
#pragma mark HFUnlockCellDelegate
- (void)nextButtonClick
{
    [[[HIIProxy shareProxy] schemeProxy] openSchemeByStep:self.schemeData.currStage withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess])
        {
            HFHealthViewController * healthVC = [[HFHealthViewController alloc] init];
            healthVC.mSchemeDay = self.data.startDay;
            [self.navigationController pushViewController:healthVC animated:YES];
        }
    }];

}
- (void)endButtonClick
{
    WS(weakSelf);
    [[[HIIProxy shareProxy]schemeProxy]modifyScheme:self.schemeData.id schemeStatus:HFModifySchemeTypeFinished withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            weakSelf.schemeData.isOver = 1;
            [weakSelf leftBarItemAction:nil];
        }
    }];
}
- (void)startAgainButtonClick
{
    WS(weakSelf);
    [[[HIIProxy shareProxy]schemeProxy]modifyScheme:self.schemeData.id schemeStatus:HFModifySchemeTypeStart withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            weakSelf.schemeData.isOver = 0;
            [weakSelf leftBarItemAction:nil];
        }
    }];

}
- (void)restartButtonClick
{
    WS(weakSelf);
    [[[HIIProxy shareProxy]schemeProxy]modifyScheme:self.schemeData.id schemeStatus:HFModifySchemeTypeStart withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            weakSelf.schemeData.isOver = 0;
            [weakSelf leftBarItemAction:nil];
        }
    }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
