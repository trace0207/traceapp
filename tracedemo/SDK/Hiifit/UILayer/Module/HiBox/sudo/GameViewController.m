//
//  GameViewController.m
//  GuanHealth
//
//  Created by hermit on 15/5/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "GameViewController.h"
#import "SentPostViewController.h"
#import "CellCreator.h"
#import "GetSudoKuRes.h"
#import "GameOverView.h"
#import "UploadGameRes.h"

@interface GameViewController ()<CellCreatorDelegate>
{
    int errorCount;
}

@property (nonatomic, strong) CellCreator *creator;
@property (nonatomic, strong) GetSudoKuData *sudoInfo;
@property (nonatomic, strong) GameOverView *gameOverView;
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hexChangeFloat:@"c4f3ff" withAlpha:1.0f];
    [self addNavigationTitle:_T(@"HF_Common_Sudo")];
    [self addRightBarItemWithTitle:_T(@"HF_Common_Restart")];
    
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBarItemAction:(id)sender
{
    [MobClick event:Sudo_Game_Restart_Click];
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (_creator.timer) {
        [_creator.timer invalidate];
        _creator.timer = nil;
    }
    [self initData];
    
   // [self gameOver:10086];
}

- (void)leftBarItemAction:(id)sender
{
    WS(weakSelf)
    HFAlertView *alter = [HFAlertView initWithTitle:@"提示" withMessage:@"您的游戏还未结束，要继续退出吗？" commpleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [MobClick event:Sudo_Game_Back_Click];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } cancelTitle:@"取消" determineTitle:@"确定"];
    [alter show];
}

- (void)initData
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenWidth, kScreenWidth, kScreenHeight-kScreenWidth)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    WS(weakSelf)
    
    [[[HIIProxy shareProxy]activityProxy]getSudoData:^(GetSudoKuData *data, BOOL success) {
        if (success) {
            weakSelf.sudoInfo = data;
            [weakSelf initGame:data];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)dealloc
{
    [_creator.timer invalidate];
    _creator.timer = nil;
    _creator.delegate = nil;
    _creator = nil;
}

- (void)initGame:(GetSudoKuData*)sudo
{
    NSString *content = sudo.content;
    NSMutableArray *contentArr = [[NSMutableArray alloc]initWithCapacity:81];
    for (int i = 0; i < content.length; i++) {
        NSString *c = [content substringWithRange:NSMakeRange(i, 1)];
        [contentArr addObject:c];
    }
    
    NSString *solution = sudo.solution;
    NSMutableArray *solutionArr = [[NSMutableArray alloc]initWithCapacity:81];
    for (int j = 0; j < solution.length; j++) {
        NSString *c = [solution substringWithRange:NSMakeRange(j, 1)];
        [solutionArr addObject:c];
    }
    
    NSMutableDictionary *cellsDic = [NSMutableDictionary dictionary];
    [cellsDic setObject:solutionArr forKey:kValueKey];
    [cellsDic setObject:contentArr forKey:kBlankKey];
    
    _creator = [[CellCreator alloc]init];
    _creator.delegate = self;
    [_creator initializeGameCells:cellsDic inView:self.view];
}

#pragma game over

- (void)gameOver:(int)seconds isSuccess:(BOOL)success
{
    if (!success) {
        WS(weakSelf)
        HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Game_Faild") withMessage:_T(@"HF_Common_Faild_Tips") commpleteBlock:^(NSInteger buttonIndex) {
            [weakSelf rightBarItemAction:nil];
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [alter show];
        return;
    }
    WS(weakSelf)
    HFUploadResultReq *req = [[HFUploadResultReq alloc]init];
    req.gameId = _sudoInfo.id;
    req.degree = _sudoInfo.degree;
    req.flag = 1;
    req.spendTime = seconds;
    
    [[[HIIProxy shareProxy]activityProxy]uploadResult:req completion:^(UploadGameRes *result) {
        if ([result success]) {
            result.spendTime = seconds;
            [weakSelf addGameOverView:result];
        }
    }];
}

- (void)addGameOverView:(UploadGameRes *)res
{
    if (_gameOverView == nil) {
        _gameOverView = [[GameOverView alloc]initWithXibName:@"GameOverView"];
    }
    
    [_gameOverView.shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    _gameOverView.frame = kScreenBounds;
    [_gameOverView setContent:res];
    
    [[UIKitTool getAppdelegate].window addSubview:_gameOverView];
}

- (void)shareAction:(UIButton *)sender
{
    
    UIImage *shotImage = [[UIKitTool getAppdelegate].window imageByRenderingView];
    [_gameOverView removeFromSuperview];
    
    NSArray *views = self.navigationController.viewControllers;
    UIViewController *popVC = [views objectAtIndex:views.count - 2];
    SentPostViewController *vc = [[SentPostViewController alloc]init];
    vc.popViewController = popVC;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (shotImage) {
        [dic setObject:shotImage forKey:kParamImg];
    }
    [dic setObject:FromSudo forKey:kParamFrom];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
