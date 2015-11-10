//
//  HFVideoViewController.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFVideoViewController.h"
#import "HFVideoPlayer.h"
#import "HFGifPlayer.h"
#import "HFSwitchView.h"
#import "LoadSchemeDataAck.h"
#import "HFSportViewCell.h"
#import "NSString+HFStrUtil.h"
#import "HFLoadFileManager.h"
#import "SchemeActionsAck.h"
#import "UIImage+Scale.h"
#import "UIViewController+Customize.h"
#import "GlobNotifyDefine.h"
#import "HFAlertView.h"
#import "UIKitTool.h"

#define kPlayerScale 1.83f

@interface HFVideoViewController ()<UIWebViewDelegate,HFVideoPlayerDelegate,UITableViewDataSource,UITableViewDelegate,HFSwitchViewDelegate>

@property (nonatomic, strong) HFVideoPlayer *playerView;
@property (nonatomic, strong) HFGifPlayer *gifPlayerView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSMutableArray  *titles;
@property (nonatomic, strong) SchemeActionsData *schemeAction;

@end

@implementation HFVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    if (self.fromGoodIdea) {
        [self addNavigationTitle:@"锦囊妙计"];
    }else if (self.sportDataArray){
        [self addNavigationTitle:@"动作详情"];
    }else{
        [self addNavigationTitle:@"运动一下"];
    }
    [kNotificationCenter addObserver:self selector:@selector(goHabitViewController:) name:HFGoHabitViewController object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarItemAction:(id)sender
{
    if ([HFLoadFileManager shareInstance].isLoading) {
        HFAlertView *alter = [HFAlertView initWithTitle:@"提示" withMessage:@"您正在下载视频，确定取消下载吗？" commpleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex) {
                [super leftBarItemAction:sender];
                [[HFLoadFileManager shareInstance]cancelLoad];
            }
        } cancelTitle:@"取消" determineTitle:@"确定"];
        [alter show];
    }else {
        [super leftBarItemAction:sender];
        [self.playerView stop];
        [self.playerView removeFromSuperview];
        self.playerView = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self reloadData];
//    BaseNavViewController *nav = (BaseNavViewController *)self.navigationController;
//    nav.gestureEnable = NO;
    self.fd_interactivePopDisabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    BaseNavViewController *nav = (BaseNavViewController *)self.navigationController;
//    nav.gestureEnable = YES;
    self.fd_interactivePopDisabled = NO;
    [self.playerView pause];
    self.playerView.isPlaying = NO;
}

- (void)dealloc
{
    [kNotificationCenter removeObserver:self name:HFGoHabitViewController object:nil];
    self.playerView = nil;
    self.gifPlayerView = nil;
}

- (void)goHabitViewController:(NSNotification *)notification
{
    [self.playerView back:nil];
    UILocalNotification *noti = (UILocalNotification *)notification.object;
    [[UIKitTool getAppdelegate]pushHabitDetailFromNotication:noti];
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
//    if (!self.sportData || !self.schemeData) {
//        return;
//    }

    WS(weakSelf)
    
    if (self.showFinishedBtn) {
        //底部按钮
        UIButton *finishedBtn = [[UIButton alloc]init];
        UIImage *image = [UIImage scaleWithImage:@"My_bigButton"];
        [finishedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [finishedBtn setTitle:@"完成动作" forState:UIControlStateNormal];
        [finishedBtn setBackgroundImage:image forState:UIControlStateNormal];
        [finishedBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [finishedBtn addTarget:self action:@selector(finishedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:finishedBtn];
        [finishedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).with.offset(20);
            make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(-10);
            make.right.equalTo(weakSelf.view.mas_right).with.offset(-20);
            make.height.equalTo(@40);
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left);
            make.bottom.equalTo(finishedBtn.mas_top).with.offset(-10);
            make.right.equalTo(weakSelf.view.mas_right);
            make.height.equalTo(@0.5);
        }];
    }
    
    
    
    //根据type来初始化UI
    if (self.sportData.type == 1 || self.sportDataArray) {
        //中间图文视图，用tableview来展示
        _mTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mTableView.backgroundColor = [UIColor whiteColor];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        [self.view addSubview:_mTableView];
        [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left);
            make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(weakSelf.showFinishedBtn? -60 : 0);
            make.right.equalTo(weakSelf.view.mas_right);
            make.top.equalTo(weakSelf.view.mas_top).with.offset(kScreenWidth/kPlayerScale);
        }];
        if (self.sportDataArray) {
            //gif
            _gifPlayerView = [[HFGifPlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/kPlayerScale)];
            [self.view addSubview:_gifPlayerView];
            _gifPlayerView.hidden = YES;
            self.schemeAction = [self.sportDataArray objectAtIndex:self.startIndex];
            
            HFSwitchView *bottomView = [[HFSwitchView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-60-64, kScreenWidth, 60) withTitles:self.titles];
            bottomView.currentPage = self.startIndex;
            bottomView.delegate = self;
            [self.view addSubview:bottomView];
        }
        
        //播放器
        _playerView = [[HFVideoPlayer alloc]init];
        _playerView.delegate = self;
        [self.view addSubview:_playerView];
        [_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left);
            make.top.equalTo(weakSelf.view.mas_top);
            make.right.equalTo(weakSelf.view.mas_right);
            make.height.equalTo(@(kScreenWidth/kPlayerScale));
        }];
        _playerView.hidden = YES;
        [_playerView bringToFront];
    }else {
        //web
        _webView = [[UIWebView alloc]init];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left);
            make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(weakSelf.showFinishedBtn? -60 : 0);
            make.right.equalTo(weakSelf.view.mas_right);
            make.top.equalTo(weakSelf.view.mas_top);
        }];
    }
}

- (void)reloadData
{
    if (self.sportDataArray) {
        if (self.playerView.isPlaying) {
            [self.playerView stop];
        }
        if (self.schemeAction.type == 3) {
            self.playerView.hidden = NO;
            self.gifPlayerView.hidden = YES;
            
            [_playerView setVideoLink:self.schemeAction.videoAddr];
            [_playerView setVideoPictureAddr:self.schemeAction.picAddr];
            [_playerView setDuration:self.schemeAction.duration];
            
        }else {
            self.playerView.hidden = YES;
            self.gifPlayerView.hidden = NO;
            
            [self.gifPlayerView setGifLink:self.schemeAction.videoAddr];
            [self.gifPlayerView setPictureUrl:self.schemeAction.picAddr];
        }
        [_mTableView reloadData];
    }else if (self.sportData.type == 1) {
        [_playerView setVideoLink:self.sportData.videoAddr];
        [_playerView setVideoFormat:self.sportData.format];
        [_playerView setVideoPictureAddr:self.sportData.picAddr];
        [_playerView setDuration:self.sportData.duration];
        [_mTableView reloadData];
    }else if (self.sportData.type == 2) {
        NSString *link = [NSString stringWithFormat:@"%@/CloudHealth/web/sports.html?sportId=%@&type=2",kBaseURL,@(self.sportData.sportId)];
        NSURL *url = [NSURL URLWithString:link];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }
}

#pragma mark - 完成运动一下

- (void)finishedAction:(UIButton *)btn
{
    [MobClick event:Scheme_DoSportFinish_Click];
    WS(weakSelf)
    [[[HIIProxy shareProxy]schemeProxy]uploadSportData:self.sportData.sportId type:self.sportData.type dayIndex:self.schemeData.currDay withBlock:^(HF_BaseAck *ack) {
        if (ack.recode == 1) {
            if (_delegate && [_delegate respondsToSelector:@selector(retSportFinsih)]) {
                [_delegate retSportFinsih];
            }
            [weakSelf leftBarItemAction:nil];
            
            if ([HFLoadFileManager shareInstance].isLoading) {
                [[HFLoadFileManager shareInstance]cancelLoad];
            }
        }
    }];
}

#pragma mark - HFVideoPlayerDelegate

- (void)HFVideoPlayerWillEnterFullscreen
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    _playerView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90));
    WS(weakSelf)
    [_playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(IOS8VERSION?-(kScreenHeight-kScreenWidth)/2:0);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(IOS8VERSION?(kScreenHeight-kScreenWidth)/2:0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(IOS8VERSION?(kScreenHeight-kScreenWidth)/2:0);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(IOS8VERSION?-(kScreenHeight-kScreenWidth)/2:0);
    }];
    [_playerView updateConstraints];
}

- (void)HFVideoPlayerExitEnterFullscreen
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    _playerView.transform = CGAffineTransformIdentity;
    WS(weakSelf)
    [_playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.top.equalTo(weakSelf.view.mas_top);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(@(kScreenWidth/kPlayerScale));
    }];
    [_playerView updateConstraints];
}

#pragma mark - HFSwitchViewDelegate

- (void)switchDidSelectAtIndex:(NSInteger)index
{
    if ([HFLoadFileManager shareInstance].isLoading) {
        [[HFLoadFileManager shareInstance]cancelLoad];
    }
    
    self.schemeAction = [self.sportDataArray objectAtIndex:index];
    [self reloadData];
}

#pragma mark - table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sportDataArray? 1 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFSportViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HFSportViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HFSportViewCell" owner:self options:nil]firstObject];
    }
    if (indexPath.row == 0) {
        if (self.sportDataArray) {
            [cell setImage:@"star" title:@"动作要领:" content:self.schemeAction.detail]; 
        }else {
            [cell setImage:@"smile_blue" title:@"治疗作用:" content:self.sportData.usages];
        }
        
    }else {
        [cell setImage:@"star" title:@"动作要领:" content:self.sportData.introduce];
    }
    return cell;
}

#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0f]};
    if (indexPath.row == 0) {
        if (self.sportDataArray) {
            height = [UIKitTool caculateHeight:[self.schemeAction.detail URLDecodedForString] sizeOfWidth:(kScreenWidth-57) withAttributes:attributes];
        }else {
            height = [UIKitTool caculateHeight:[self.sportData.usages URLDecodedForString] sizeOfWidth:(kScreenWidth-57) withAttributes:attributes];
        }
    }else {
        height = [UIKitTool caculateHeight:[self.sportData.introduce URLDecodedForString] sizeOfWidth:(kScreenWidth-57) withAttributes:attributes];
    }
    return height + 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 300, 50)];
    label.text = [self.schemeAction.title URLDecodedForString];
    label.font = [UIFont systemFontOfSize:16];
    [label setTextColor:[UIColor hexChangeFloat:@"333333" withAlpha:1]];
    [view addSubview:label];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 0.5f)];
    line.backgroundColor = [UIColor HFColorStyle_6];
    [view addSubview:line];
    
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
#pragma mark - pravite

-(NSMutableArray *)titles
{
    if (!_titles) {
        _titles = [[NSMutableArray alloc]initWithCapacity:self.sportDataArray.count];
        for (NSUInteger i = 0; i < self.sportDataArray.count; i++) {
            SchemeActionsData *data = [self.sportDataArray objectAtIndex:i];
            NSString *title = data.title;
            if (title == nil) {
                title = @"";
            }
            [_titles addObject:title];
        }
    }
    return _titles;
}

@end
