//
//  HFQuestionTestViewController.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/9/25.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFQuestionTestViewController.h"
#import "HFTopImageView.h"
#import "HFConclusionView.h"
#import "GetQuizConclusionArg.h"
#import "HFTestView.h"
#import "GetOrUpdateSchemeArg.h"
#import "GlobConfig.h"
#import "HFAlertView.h"
#import "BaseHFHttpClient.h"

#define cellIdentifier @"collectionViewIdentifier"
@interface HFQuestionTestViewController ()<HFConclusionViewDelegate, HFTestViewDelegate>
{
    BOOL bIsFromMainAdvancePage;
}

@property (nonatomic, strong) HFConclusionView * conclusionView;
@property (nonatomic, assign) NSInteger conclusionId;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableArray * buttonStateArray;
@property (nonatomic, strong) HFTestView * testView;
@property (nonatomic, strong) GetQuizConclusionData * conclusionData;

@end

@implementation HFQuestionTestViewController

- (id)initFromMainAdvancePage:(BOOL)bFrom
{
    self = [super init];
    if (self) {
        bIsFromMainAdvancePage = bFrom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    if (!bIsFromMainAdvancePage) {
        [self loadMyConclusionData];
        return;
    }
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - privateFunction
- (void)loadUI
{
    if (bIsFromMainAdvancePage) {
        [self.view addSubview:self.testView];
    }else{
        self.conclusionView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
}
- (void)loadMyConclusionData
{
    WS(weakSelf);
    GetQuizConclusionArg * arg = [[GetQuizConclusionArg alloc] init];
    arg.schemeId = self.schemeId;
    arg.flag = 1;
    [[[HIIProxy shareProxy] schemeProxy] getQuizConclusion:arg withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            GetQuizConclusionAck * conclusionData = (GetQuizConclusionAck *)ack;
            weakSelf.conclusionView.data = conclusionData;
            [weakSelf.conclusionView changeState];
        }
    }];
}
- (void)loadConclusionData
{
    WS(weakSelf);
    GetQuizConclusionArg * arg = [[GetQuizConclusionArg alloc] init];
    arg.schemeId = self.schemeId;
    arg.flag = 0;
    [[[HIIProxy shareProxy] schemeProxy] getQuizConclusion:arg withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            GetQuizConclusionAck * conclusionData = (GetQuizConclusionAck *)ack;
            weakSelf.conclusionView.data = conclusionData;
            weakSelf.conclusionData = conclusionData.data;
            if ([[conclusionData data] hasAchieved] == 1) {
                [self.conclusionView.getSchemeButton setTitle:@"更新方案" forState:UIControlStateNormal];
            }
        }
    }];
}
- (void)loadData
{
    if (![[BaseHFHttpClient shareInstance]bNetReachable]) {
        HFAlertView * alertView = [HFAlertView initWithTitle:@"提示" withMessage:@"网络异常" commpleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [self dismiss];
            }
            if (buttonIndex == 1) {
                [self loadData];
            }
        } cancelTitle:@"取消" determineTitle:@"重连"];
        [alertView show];
        return;
    }

    WS(weakSelf)
    GetQuizSubjectAgainArg * arg = [[GetQuizSubjectAgainArg alloc] init];
    arg.schemeId = self.schemeId;
    arg.isLast = 0;
    [[[HIIProxy shareProxy] schemeProxy] getQuizSubjectAgain:arg withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            GetQuizSubjectAgainAck *ret = (GetQuizSubjectAgainAck *)ack;
            [weakSelf.dataArray addObject:ack];
            weakSelf.testView.againData = ret;
            [weakSelf.testView changeButtonState];
        }
    }];
    return;
}
#pragma mark - lazyLoading
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)buttonStateArray
{
    if (!_buttonStateArray) {
        _buttonStateArray = [NSMutableArray array];
    }
    return _buttonStateArray;
}
- (HFConclusionView *)conclusionView
{
    if (!_conclusionView) {
        _conclusionView = [[HFConclusionView alloc] init];
        _conclusionView.backgroundColor = [UIColor HFColorStyle_5];
        _conclusionView.delegate = self;
        [self.view addSubview:_conclusionView];
    }
    return _conclusionView;
}
- (HFTestView *)testView
{
    if (!_testView) {
        _testView = [[HFTestView alloc] init];
        _testView.delegate = self;
    }
    return _testView;
}
#pragma mark - HFConclusionViewDelegate
- (void)restartTest
{
    [MobClick event:AdvanceScheme_TestAgain];
    [self.conclusionView removeFromSuperview];
    self.conclusionView = nil;
    [self.dataArray removeAllObjects];
    [self.view addSubview:self.testView];
    [self loadData];
}
- (void)getScheme
{
    WS(weakSelf)
    if (![[BaseHFHttpClient shareInstance]bNetReachable]) {
        HFAlertView * alertView = [HFAlertView initWithTitle:@"提示" withMessage:@"网络异常" commpleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [weakSelf dismiss];
            }
            if (buttonIndex == 1) {
                [weakSelf getScheme];
            }
        } cancelTitle:@"取消" determineTitle:@"重连"];
        [alertView show];
        return;
    }
    GetOrUpdateSchemeArg * arg = [[GetOrUpdateSchemeArg alloc] init];
    arg.schemeId = self.schemeId;
    if (self.conclusionData.hasAchieved == 1) {
        arg.operateType = 5;
    }
    if (self.conclusionData.hasAchieved == 0) {
        arg.operateType = 4;
    }
    if (self.conclusionData.hasAchieved == 1) {
        HFAlertView * alertView = [HFAlertView initWithTitle:@"确定要更新调理方案？" withMessage:@"更新方案后，之前的调理记录将被清空" commpleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                return;
            }else{
                [self getSchemeData:arg];
            }
        } cancelTitle:@"取消" determineTitle:@"更新方案"];
        [alertView show];
    }else{
        [self getSchemeData:arg];
    }
}

- (void)getSchemeData:(GetOrUpdateSchemeArg *)arg
{
    WS(weakSelf)
    [MobClick event:AdvanceScheme_GetScheme];
    [[[HIIProxy shareProxy] schemeProxy] getOrUpdateScheme:arg withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(schemeStart)]) {
                [weakSelf.delegate schemeStart];
            }
            [weakSelf dismissViewControllerAnimated:NO completion:^{
                [[[HIIProxy shareProxy]userProxy]getUserInfo:^(BOOL finished) {
                    
                }];
            }];
        }
    }];
}

- (void)giveUp
{
    [MobClick event:AdvanceScheme_TestResultGiveUp];
    WS(weakSelf);
    HFAlertView * alertView = [HFAlertView initWithTitle:@"提示" withMessage:@"确定要放弃结论吗？" commpleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    } cancelTitle:@"取消" determineTitle:@"确定"];
    [alertView show];
}
- (void)closeConclusion
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - HFTestViewDelegate
- (void)chooseAnswer:(BOOL)answer
{
    if (![[BaseHFHttpClient shareInstance]bNetReachable]) {
        HFAlertView * alertView = [HFAlertView initWithTitle:@"提示" withMessage:@"网络异常" commpleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [self dismiss];
            }
        } cancelTitle:@"取消" determineTitle:@"重连"];
        [alertView show];
        return;
    }

    WS(weakSelf);
    
    GetQuizSubjectAgainAck * firstAck = [self.dataArray firstObject];
    NSString * qids = [NSString stringWithFormat:@"%ld", (long)firstAck.data.questionId];
    for (int i = 1; i < [self.dataArray count] ; i++) {
        GetQuizSubjectAgainAck * ack = [self.dataArray objectAtIndex:i];
        qids = [qids stringByAppendingString:[NSString stringWithFormat:@"-%ld", (long)ack.data.questionId]];
    }
    GetQuizSubjectAgainArg * arg = [[GetQuizSubjectAgainArg alloc] init];
    arg.qids = qids;
    arg.schemeId = self.schemeId;
    arg.isLast = self.dataArray.count == 5 ? 1 : 0;
    arg.currentQueAns = answer;
    [[[HIIProxy shareProxy] schemeProxy] getQuizSubjectAgain:arg withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            GetQuizSubjectAgainAck * ret = (GetQuizSubjectAgainAck *)ack;
            [weakSelf.testView changeImageNext:weakSelf.dataArray.count - 1];
            if (arg.isLast == 0) {
                [weakSelf.dataArray addObject:ret];
            }
            weakSelf.testView.againData = ret;
            [weakSelf.testView changeButtonState];
            [weakSelf.buttonStateArray addObject:answer ? @"1" : @"0"];
            if (arg.isLast == 1) {
                [weakSelf.testView removeFromSuperview];
                weakSelf.testView = nil;
                weakSelf.conclusionView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
                [weakSelf loadConclusionData];
                //return;
            }

        }
    }];

}
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)giveUpTest
{
    [MobClick event:AdvanceScheme_TestBack];
//    WS(weakSelf);
//    HFAlertView * alertView = [HFAlertView initWithTitle:@"提示" withMessage:@"确定要放弃测试吗？" commpleteBlock:^(NSInteger buttonIndex) {
//        if (buttonIndex == 1) {
//        }
//    } cancelTitle:@"取消" determineTitle:@"确定"];
//    [alertView show];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}
- (void)backToLastTest
{
    [self.dataArray removeLastObject];
    self.testView.againData = self.dataArray.lastObject;
    [self.testView changeImageFormer:self.dataArray.count withButtonState:[self.buttonStateArray objectAtIndex:self.dataArray.count - 1]];
    [self.buttonStateArray removeLastObject];
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
