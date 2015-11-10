//
//  HFDevInfoViewController.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFDevInfoViewController.h"
#import "HFDevHistoryViewController.h"
#import "BandCenter.h"
#import "HFBindingViewController.h"
#import "HFBindDeviceListController.h"
#import "HFRemindView.h"
#import "GlobNotifyDefine.h"

@interface HFDevInfoViewController ()<HFRemindViewDelegate>
{
    BOOL  bHasBind;       //是否已经绑定
    
    RightBarType mType;
    
    NSInteger  mSteps;
    NSInteger  mCol;
    NSString  *createDate;
    
}
@property(nonatomic,strong)UIView * mBgView;
@property(nonatomic,strong)UILabel * mTitleView;
@property(nonatomic,strong)UIActivityIndicatorView * mloadingView;
@property(nonatomic,strong)UIButton * mRefreashBtn;
@property(nonatomic,strong)UIView * mTipView;
@property(nonatomic,strong)UIButton  * mFuncBtn;
@property(nonatomic,strong)UIButton * mBindBtn;

//@property(nonatomic,strong)BandCenter * bandCenter;
@end

@implementation HFDevInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavgaitionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatebandDayData:) name:KBandSyncDayDataNotication object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateband5minData:) name:KBandSync5minDataNotication object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unBindBandRefrash) name:KUnBindBandNotication object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bindBandRefrash) name:KBindBandNotication object:nil];
    
    
    NSDictionary * bandDict = [kUserDefaults objectForKey:kParamBandInfo];
    
    self.stepLabel.text = [bandDict objectForKey:@"step"];
    
    [self requestBandData];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KBandSyncDayDataNotication object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KBandSync5minDataNotication object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KUnBindBandNotication object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KBindBandNotication object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark -
#pragma mark private
- (void)requestBandData
{
    bHasBind = [[BandCenter shareInstance] getBindStauts];
    
    if (bHasBind)
    {
        [self getBandSportData];
    }
    else
    {
        [self setRightBarStatus:Bar_Unbind_State];
    }
}

- (void)configNavgaitionView
{
    self.mBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    self.mBgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mBgView];
    
    //返回按钮
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 44, 44);
    [backBtn setBackgroundImage:IMG(@"My_back") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.mBgView addSubview:backBtn];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)bindAction
{
    HFBindDeviceListController * bind = [[HFBindDeviceListController alloc] init];
    bind.bBindStatus = NO;
    [self.navigationController pushViewController:bind animated:YES];
}

- (void)funcAction
{
    HFRemindView * remindView = [[HFRemindView alloc] init];
    remindView.bHasSetting = [[BandCenter shareInstance] isBandI5];
    remindView.delegate = self;
    [remindView show];
}

- (void)refreshAction
{
    self.mTipView.hidden = YES;
    self.mRefreashBtn.hidden = YES;
    [self getBandSportData];
}

- (void)getBandSportData
{
    WS(weakSelf)
    [self.mTitleView setText:@"今日活动"];
    self.mFuncBtn.hidden = NO;
    [self.mloadingView startAnimating];
    [[BandCenter shareInstance] getBlueTooth:^(BOOL success) {
        
        if (success)
        {
            [weakSelf syncData];
        }
        else
        {
            [self.mloadingView stopAnimating];
            [weakSelf setRightBarStatus:Bar_Fail_State];
        }
    }];
}


- (void)syncData
{
    [self performSelector:@selector(loadingTimeOut) withObject:nil afterDelay:15.0];
    
    WS(weakSelf)
    [[BandCenter shareInstance] syncBandData:^(NSInteger error) {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadingTimeOut) object:nil];
        [weakSelf.mloadingView stopAnimating];
        [weakSelf setRightBarStatus:Bar_Success_State];
    }];
}

- (void)loadingTimeOut
{
    [self.mloadingView stopAnimating];
    [self setRightBarStatus:Bar_Fail_State];
}

#pragma mark -
#pragma mark Notication
- (void)updatebandDayData:(NSNotification *)notication
{
    self.mTipView.hidden = YES;
    self.mRefreashBtn.hidden = YES;
    
    NSDictionary * dict = [notication object];
    
    mSteps = [[dict objectForKey:@"CSTEP"] integerValue];
    mCol = [[dict objectForKey:@"CCALO"] integerValue];
    
    NSLog(@"总步数:%ld 总的卡路里：%ld",mSteps,mCol);
    
    self.stepLabel.text = [NSString stringWithFormat:@"%ld",mSteps];
    self.calariesLabel.text = [NSString stringWithFormat:@"%ld大卡",mCol];
}

- (void)updateband5minData:(NSNotification *)notication
{
    
}

- (void)unBindBandRefrash
{
    self.mFuncBtn.hidden = YES;
    self.mRefreashBtn.hidden = YES;
    self.mTipView.hidden = YES;
    
    [self setRightBarStatus:Bar_Unbind_State];
}

- (void)bindBandRefrash
{
    
    [self.mTitleView setText:@"今日活动"];
    self.mBindBtn.hidden = YES;
    self.mRefreashBtn.hidden = YES;
    self.mTipView.hidden = YES;
    [self getBandSportData];
}

#pragma mark -
#pragma mark rightBarStatus

- (void)setRightBarStatus:(RightBarType)type
{
    mType = type;
    
    switch (type)
    {
        case Bar_Unbind_State:
        {
            [self.mTitleView setText:@"未绑定手环"];
            self.mBindBtn.hidden = NO;
            break;
        }
        case Bar_Success_State:
        {
            self.connectStatusLabel.hidden = NO;
            self.connectStatusLabel.text = @"刚刚同步";
            break;
        }
        case Bar_Loading_State:
        {
            break;
        }
        case Bar_Fail_State:
        {
            self.mRefreashBtn.hidden = NO;
            self.mTipView.hidden = NO;
            self.connectStatusLabel.hidden = YES;
            break;
        }
            
        default:
            break;
    }
}

- (IBAction)lookHistoryAction:(id)sender
{
    HFDevHistoryViewController *vc = [[HFDevHistoryViewController alloc]initWithNibName:@"HFDevHistoryViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - HFRemindViewDelegate
- (void)myDeviceClicked
{
    HFBindDeviceListController * myDevice = [[HFBindDeviceListController alloc] init];
    myDevice.bBindStatus = YES;
    [self.navigationController pushViewController:myDevice animated:YES];
}

#pragma mark -
#pragma mark getter
- (UILabel *)mTitleView
{
    if (!_mTitleView)
    {
        _mTitleView = [[UILabel alloc] init];
        _mTitleView.backgroundColor = [UIColor clearColor];
        _mTitleView.textColor = [UIColor HFColorStyle_1];
        _mTitleView.font = [UIFont systemFontOfSize:20.0];
        [self.mBgView addSubview:_mTitleView];
        WS(weakSelf)
        [_mTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.mBgView.mas_centerX);
            make.height.mas_equalTo(44.0);
            make.bottom.equalTo(weakSelf.mBgView).with.offset(0);
            make.width.mas_greaterThanOrEqualTo(1);
        }];
    }
    
    return _mTitleView;
}

- (UIView *)mloadingView
{
    if (!_mloadingView)
    {
        WS(weakSelf)
        _mloadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.mBgView addSubview: _mloadingView];
        [_mloadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.left.equalTo(weakSelf.mTitleView.mas_right).with.offset(15);
            make.centerY.mas_equalTo(weakSelf.mTitleView.mas_centerY);
        }];
    }
    return _mloadingView;
}

- (UIButton *)mRefreashBtn
{
    if (!_mRefreashBtn)
    {
        _mRefreashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mRefreashBtn setBackgroundImage:IMG(@"refresh") forState:UIControlStateNormal];
        [_mRefreashBtn addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
        [self.mBgView addSubview:_mRefreashBtn];
        WS(weakSelf)
        [_mRefreashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.left.equalTo(weakSelf.mTitleView.mas_right).with.offset(0);
            make.top.equalTo(weakSelf.mBgView.mas_top).with.offset(20);
        }];
    }
    return _mRefreashBtn;
}

- (UIButton *)mFuncBtn
{
    if (!_mFuncBtn)
    {
        _mFuncBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mFuncBtn setBackgroundImage:IMG(@"My_dotdotdot") forState:UIControlStateNormal];
        [_mFuncBtn addTarget:self action:@selector(funcAction) forControlEvents:UIControlEventTouchUpInside];
        [self.mBgView addSubview:_mFuncBtn];
        WS(weakSelf)
        [_mFuncBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.right.equalTo(weakSelf.mBgView.mas_right).with.offset(-10);
            make.top.equalTo(weakSelf.mBgView.mas_top).with.offset(20);
        }];
    }
    return _mFuncBtn;
}

- (UIButton *)mBindBtn
{
    if (!_mBindBtn)
    {
        _mBindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mBindBtn setTitle:@"绑定" forState:UIControlStateNormal];
        [_mBindBtn setTitleColor:[UIColor HFColorStyle_1] forState:UIControlStateNormal];
        [_mBindBtn addTarget:self action:@selector(bindAction) forControlEvents:UIControlEventTouchUpInside];
        [self.mBgView addSubview:_mBindBtn];
        WS(weakSelf)
        [_mBindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.right.equalTo(weakSelf.mBgView.mas_right).with.offset(-10);
            make.top.equalTo(weakSelf.mBgView.mas_top).with.offset(20);
        }];
    }
    return _mBindBtn;
}

- (UIView *)mTipView
{
    if (!_mTipView)
    {
        _mTipView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 200) / 2, 64, 200, 30)];
        _mTipView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_mTipView];
        
        UIImageView * tipView = [[UIImageView alloc] initWithFrame:CGRectMake(28, 1, 13, 14)];
        tipView.image = IMG(@"bandtip");
        [_mTipView addSubview:tipView];
        
        UILabel * errorLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, _mTipView.frame.size.width - 45, 15)];
        errorLabel1.font = [UIFont systemFontOfSize:12.0];
        errorLabel1.textAlignment = NSTextAlignmentLeft;
        errorLabel1.text = @"连接失败，请重新刷新";
        errorLabel1.textColor = [UIColor HFColorStyle_8];
        [_mTipView addSubview:errorLabel1];
        
        UILabel * errorLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, _mTipView.frame.size.width, 15)];
        errorLabel2.font = [UIFont systemFontOfSize:12.0];
        errorLabel2.textAlignment = NSTextAlignmentCenter;
        errorLabel2.text = @"并确定手环靠近手机且电量充足";
        errorLabel2.textColor = [UIColor HFColorStyle_8];
        [_mTipView addSubview:errorLabel2];
        
    }
    return _mTipView;
}


@end
