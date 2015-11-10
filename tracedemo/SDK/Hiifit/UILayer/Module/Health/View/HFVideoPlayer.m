//
//  HFVideoPlayer.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFVideoPlayer.h"
#import <MediaPlayer/MediaPlayer.h>
#import "HFLoadFileManager.h"
#import "GlobNotifyDefine.h"

//#import <AVFoundation/AVFoundation.h>

@interface HFVideoPlayer()
{
    NSString *filePath;
    NSUInteger toolBarHiddenTime;
    BOOL toolBarHidden;
}

//播放器
@property (nonatomic, strong) MPMoviePlayerController *player;
//上部导航视图
@property (nonatomic, strong) UIView *navBar;
@property (nonatomic, strong) UILabel *navTitleLabel;

//视频总时长
@property (nonatomic, strong) UILabel *timeLabel;
//视频标题
@property (nonatomic, strong) UILabel *titleLabel;

//视频第一帧的图片
@property (nonatomic, strong) UIImageView *videoImage;

//toolBar视图
@property (nonatomic, strong) UIView *toolBar;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UIButton *zoomBtn;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *startBtn;

//隐藏toolBar的计时器
@property (nonatomic, strong) NSTimer *toolBarTimer;
//实时更新进度条进度值的计时器
@property (nonatomic, strong) NSTimer *sliderTimer;

@property (nonatomic, strong) UIView *errorView;



@end

@implementation HFVideoPlayer
@synthesize delegate = _delegate;
@synthesize fullScreenState;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initPlayer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initPlayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initPlayer];
    }
    return self;
}

- (void)dealloc
{
    [kNotificationCenter removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [kNotificationCenter removeObserver:self name:MPMovieDurationAvailableNotification object:nil];
    [kNotificationCenter removeObserver:self name:HFApplicationDidBecomeActive object:nil];
    [kNotificationCenter removeObserver:self name:HFApplicationWillResignActive object:nil];

    [_toolBarTimer invalidate];
    [_sliderTimer invalidate];
    _toolBarTimer = nil;
    _sliderTimer = nil;
    self.player = nil;
}

- (void)setVideoLink:(NSString *)videoLink
{
    _videoLink = videoLink;
    [self.HUD hide:YES];
    filePath = [[HFLoadFileManager shareInstance]getFilePathFromDocuments:_videoLink];
    if (_errorView) {
        _errorView.hidden = YES;
    }
    [self changePlayButton:nil];
}

- (void)setVideoFormat:(NSString *)videoFormat
{
    _videoFormat = videoFormat;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.titleLabel setText:title];
}

- (void)setVideoPictureAddr:(NSString *)videoPictureAddr
{
    _videoPictureAddr = videoPictureAddr;
    //_videoPictureAddr = @"http://183.131.13.104:8080/share/data/spider/pic/videos/huitouwangyue.png";
    [self.videoImage sd_setImageWithURL:[NSURL URLWithString:_videoPictureAddr]];
}

- (void)setDuration:(NSUInteger)duration
{
    if (duration<=0) {
        return;
    }
    _duration = duration;
    _timeLabel.text = [NSString stringWithFormat:@"%@´%@˝",@(duration/60),@(duration%60)];
    _totalLabel.text = _timeLabel.text;
}

- (NSTimer *)toolBarTimer
{
    if (!_toolBarTimer) {
        _toolBarTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(hideToolBarAction:) userInfo:nil repeats:YES];
    }
    return _toolBarTimer;
}


- (NSTimer *)sliderTimer
{
    if (!_sliderTimer) {
        _sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(changeSliderValue:) userInfo:nil repeats:YES];
    }
    return _sliderTimer;
}

//初始化播放器界面
- (void)initPlayer
{
    self.backgroundColor = [UIColor redColor];
    //播放器
    _player = [[MPMoviePlayerController alloc]init];
    [_player setControlStyle:MPMovieControlStyleNone];
    [self addSubview:_player.view];
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    _videoImage = [UIImageView new];
    [self addSubview:_videoImage];
    [_videoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIButton *lugeBtn  = [UIButton new];
    lugeBtn.backgroundColor = [UIColor clearColor];
    [lugeBtn addTarget:self action:@selector(hideToolBar:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lugeBtn];
    [lugeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    //中间播放按钮
    _startBtn = [UIButton new];
    [_startBtn addTarget:self action:@selector(startPlay:) forControlEvents:UIControlEventTouchUpInside];
    [_startBtn setBackgroundImage:IMG(@"play") forState:UIControlStateNormal];
    [self addSubview:_startBtn];
    WS(weakSelf)
    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(55, 55));
        make.centerX.equalTo(_videoImage.mas_centerX);
        make.centerY.equalTo(_videoImage.mas_centerY);
    }];
    
   //导航视图
    _navBar = [UIView new];
    _navBar.backgroundColor = [UIColor clearColor];
    [self addSubview:_navBar];
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(@44);
    }];
    
    
    UIView *bgNav = [UIView new];
    bgNav.backgroundColor = [UIColor blackColor];
    bgNav.alpha = 0.5f;
    [_navBar addSubview:bgNav];
    [bgNav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = @"运动一下";
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_navBar addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIButton *backBtn = [UIButton new];
    [backBtn setBackgroundImage:IMG(@"icon_back") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [_navBar addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.left.equalTo(@10);
        make.top.equalTo(@11);
    }];
    
    //初始化不现实导航
    _navBar.hidden = YES;
    
    //总时长
    _timeLabel = [UILabel new];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.backgroundColor = [UIColor clearColor];
    [_timeLabel setTextColor:[UIColor whiteColor]];
    _timeLabel.text = @"0'00˝";
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.right.equalTo(weakSelf.mas_right).with.offset(-15);
        make.top.equalTo(@15);
    }];
    
    //底部视图
    _toolBar = [UIView new];
    _toolBar.backgroundColor = [UIColor clearColor];
    [self addSubview:_toolBar];
    [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(@44);
    }];
    
    UIView *bgToolBar = [UIView new];
    bgToolBar.backgroundColor = [UIColor blackColor];
    bgToolBar.alpha = 0.5f;
    [_toolBar addSubview:bgToolBar];
    [bgToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    _playBtn = [UIButton new];
    [_playBtn addTarget:self action:@selector(playActoin:) forControlEvents:UIControlEventTouchUpInside];
    _playBtn.backgroundColor = [UIColor clearColor];
    [_playBtn setBackgroundImage:IMG(@"play") forState:UIControlStateNormal];
    [_playBtn setBackgroundImage:IMG(@"pause") forState:UIControlStateSelected];
    [_toolBar addSubview:_playBtn];
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(@10);
        make.top.equalTo(@7);
    }];
    
    _progressLabel = [UILabel new];
    _progressLabel.text = @"0´00˝";
    _progressLabel.backgroundColor = [UIColor clearColor];
    _progressLabel.textColor = [UIColor whiteColor];
    _progressLabel.textAlignment = NSTextAlignmentCenter;
    [_toolBar addSubview:_progressLabel];
    [_progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(CGSizeMake(60, 20));
        make.height.equalTo(@20);
        make.width.greaterThanOrEqualTo(@0);
        make.top.equalTo(@12);
        make.left.equalTo(_playBtn.mas_right).with.offset(10);
    }];
    //
    _zoomBtn = [UIButton new];
    [_zoomBtn setImage:IMG(@"zoom") forState:UIControlStateNormal];
    [_zoomBtn addTarget:self action:@selector(zoomAction:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:_zoomBtn];
    _zoomBtn.backgroundColor = [UIColor clearColor];
    [_zoomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.right.equalTo(@0);
        make.top.equalTo(@0);
    }];
    
    _totalLabel = [UILabel new];
    _totalLabel.text = @"0´00˝";
    _totalLabel.backgroundColor = [UIColor clearColor];
    _totalLabel.textColor = [UIColor whiteColor];
    _totalLabel.textAlignment = NSTextAlignmentCenter;
    [_toolBar addSubview:_totalLabel];
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.greaterThanOrEqualTo(@0);
        make.top.equalTo(@12);
        make.right.equalTo(weakSelf.mas_right).with.offset(-40);
    }];
    
    _slider = [[UISlider alloc]init];
    _slider.value = 0.0f;
    [_slider setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
//    [_slider setMinimumTrackImage:[UIImage imageNamed:@"progress_blue"] forState:UIControlStateNormal];
//    [_slider setMaximumTrackImage:[UIImage imageNamed:@"progress_dark"] forState:UIControlStateNormal];
    [_slider addTarget:self action:@selector(dragSliderAction:) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(dragSliderEnd:) forControlEvents:UIControlEventTouchUpInside];
    _slider.value = 0;
    [_toolBar addSubview:_slider];
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_progressLabel.mas_right).with.offset(8);
        make.right.equalTo(_totalLabel.mas_left).with.offset(-8);
        make.top.equalTo(@10);
        make.bottom.equalTo(@(-10));
    }];
    
    _toolBar.alpha = 0;
    toolBarHidden = YES;
    
    //播放完修改播放按钮的状态
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changePlayButton:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setTotalLabelText:) name:MPMovieDurationAvailableNotification object:nil];
    
    [kNotificationCenter addObserver:self selector:@selector(receivesResignActiveAction:) name:HFApplicationWillResignActive object:nil];
    [kNotificationCenter addObserver:self selector:@selector(receivesDidBecomeActiveAction:) name:HFApplicationDidBecomeActive object:nil];
}



#pragma mark - receives notification
- (void)setTotalLabelText:(NSNotification *)noti
{
    _totalLabel.text = [NSString stringWithFormat:@"%@´%@˝",@((NSUInteger)_player.duration/60), @((NSUInteger)_player.duration%60)];
    _timeLabel.text = _totalLabel.text;
}
//修改播放按钮的状态
- (void)changePlayButton:(NSNotification *)not
{
    [self hiddenStartView:NO];
    _playBtn.selected = NO;
    _slider.value = 0;
    _progressLabel.text = @"0´00˝";
    //[_player setCurrentPlaybackTime:0];
    
    [self.sliderTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:GID_MAX]];
    [self.toolBarTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:GID_MAX]];
    _isPlaying = NO;
    toolBarHidden = YES;
    _toolBar.alpha = 0;
    _navBar.alpha = 0;
}

- (void)receivesResignActiveAction:(NSNotification *)notification
{
    if (self.isPlaying) {
        [self.player pause];
    }
}

- (void)receivesDidBecomeActiveAction:(NSNotification *)notification
{
    if (self.isPlaying) {
        [self.player play];
    }
}


//中间按钮触发播放
- (void)startPlay:(UIButton *)btn
{
    if (_videoLink.length == 0 || ![_videoLink hasPrefix:@"http"]) {
        [self.errorView setHidden:NO];
        return;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        [self playWithVideoPath];
        return;
    }
    if (_videoLink == nil || ![_videoLink hasPrefix:@"http"]) {
        [self addErrorView];
        return;
    }
    AFNetworkReachabilityStatus state = [BaseHFHttpClient shareInstance].netState;
    if (state == AFNetworkReachabilityStatusNotReachable || state == AFNetworkReachabilityStatusUnknown) {
        [MBProgressHUD showMessage:@"请检查你的网络设置" toView:nil];
    }else if (state == AFNetworkReachabilityStatusReachableViaWWAN) {
        WS(weakSelf)
        HFAlertView *altert = [HFAlertView initWithTitle:@"确定播放视频" withMessage:@"当前使用的是数据网络，播放视频可能会消耗较多的流量。" commpleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [weakSelf loadVideo];
            }
        } cancelTitle:@"取消" determineTitle:@"确定"];
        [altert show];
    }else {
        [self loadVideo];
    }
}

- (void)hiddenStartView:(BOOL)hidden
{
    _timeLabel.hidden = hidden;
    _videoImage.hidden = hidden;
    _startBtn.hidden = hidden;
}

//下载视频
- (void)loadVideo
{
    [self hiddenStartView:YES];
    
    [self addSubview:self.HUD];
    WS(weakSelf)
    [self.HUD mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(weakSelf.frame), CGRectGetHeight(weakSelf.frame)));
        make.centerX.equalTo(_videoImage.mas_centerX);
        make.centerY.equalTo(_videoImage.mas_centerY);
    }];
    [self.HUD show:YES];
    [[HFLoadFileManager shareInstance]loadFileWithUrl:_videoLink progress:^(CGFloat rate) {
        self.HUD.progress = rate;
    } success:^{
        if ([UIKitTool getAppdelegate].appActiviting) {
            [weakSelf playWithVideoPath];
        }else {
            [weakSelf hiddenStartView:NO];
        }
        [weakSelf.HUD hide:YES];
        
    } failure:^(NSError *error) {
        [weakSelf.HUD hide:YES];
        [weakSelf addErrorView];
    }];
}

//下载或播放失败加视图
- (void)addErrorView
{
    [self hiddenStartView:YES];
    self.errorView.hidden = NO;
}

//第一次播放
- (void)playWithVideoPath
{
    _isPlaying = YES;
    [self hiddenStartView:YES];
    toolBarHiddenTime = 0;
    _playBtn.selected = YES;
    NSURL *url = [[NSURL alloc]initFileURLWithPath:filePath];
    [self.player setContentURL:url];
    [self.player play];
    [self.sliderTimer setFireDate:[NSDate date]];
    [self.sliderTimer fire];
}

//控制bar上的按钮触发播放
- (void)playActoin:(UIButton *)btn
{
    toolBarHiddenTime = 0;
    _startBtn.hidden = YES;
    if (btn.selected) {
        [self.player pause];
        _isPlaying = NO;
    }else {
        [self.player play];
        _isPlaying = YES;
    }
    btn.selected = !btn.selected;
    [self.sliderTimer setFireDate:[NSDate date]];
    [self.sliderTimer fire];
}

//播放
- (void)play
{
    [self.player play];
    _playBtn.selected = YES;
}
//暂停
-(void)pause
{
    [self.player pause];
    _playBtn.selected = NO;
}
//停止
-(void)stop
{
    [self.sliderTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:GID_MAX]];
    [self.toolBarTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:GID_MAX]];
    [self.player stop];
    _isPlaying = NO;
}

//导航返回按钮触发
- (void)back:(id)sender
{
    toolBarHiddenTime = 0;
    if (_delegate && [_delegate respondsToSelector:@selector(HFVideoPlayerExitEnterFullscreen)]) {
        _navBar.hidden = YES;
        _zoomBtn.hidden = NO;
        fullScreenState = NO;
        toolBarHidden = YES;
        [_delegate HFVideoPlayerExitEnterFullscreen];
        [self fixToolBarViewConstraint:NO];
        [[GlobInfo shareInstance] setBIsFullScreenState:NO];
    }
}

//缩放按钮触发
- (void)zoomAction:(UIButton *)btn
{
    toolBarHiddenTime = 0;
    if (_delegate && [_delegate respondsToSelector:@selector(HFVideoPlayerWillEnterFullscreen)]) {
        _navBar.hidden = NO;
        _zoomBtn.hidden = YES;
        fullScreenState = YES;
        [_delegate HFVideoPlayerWillEnterFullscreen];
        [self fixToolBarViewConstraint:YES];
        [[GlobInfo shareInstance] setBIsFullScreenState:YES];
    }
}

//由于缩放按钮的显示和隐藏，需要修改约束条件
- (void)fixToolBarViewConstraint:(BOOL)zoomBtnHidden
{
    WS(weakSelf)
    [_totalLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.greaterThanOrEqualTo(@0);
        make.top.equalTo(@12);
        make.right.equalTo(weakSelf.mas_right).with.offset(zoomBtnHidden?-15:-45);
    }];
    
    [_totalLabel updateConstraints];
    [_slider updateConstraintsIfNeeded];
}

//隐藏toolBar和navBar
- (void)hideToolBar:(UIButton *)btn
{
    if (_startBtn.hidden == NO && !fullScreenState) {
        return;
    }
    WS(weakSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4f animations:^{
            if (!(_startBtn.hidden == NO && fullScreenState)) {
                _toolBar.alpha = toolBarHidden?1:0;
            }
            
            _navBar.alpha = toolBarHidden?1:0;
        } completion:^(BOOL finished) {
            toolBarHidden = !toolBarHidden;
            if (!(_startBtn.hidden == NO && fullScreenState)) {
                if (!toolBarHidden) {
                    toolBarHiddenTime = 0;
                    [weakSelf.toolBarTimer setFireDate:[NSDate date]];
                    [weakSelf.toolBarTimer fire];
                }
            }
        }];
    });
}

//计时器来隐藏toolBar
- (void)hideToolBarAction:(NSTimer *)t
{
    if (toolBarHidden == YES) {
        [self.toolBarTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:GID_MAX]];
    }else {
        if (++toolBarHiddenTime == 5) {
            [self hideToolBar:_startBtn];
            toolBarHiddenTime = 0;
        }
    }
}

//播放进度
- (void)changeSliderValue:(NSTimer *)t
{
     _slider.value = _player.currentPlaybackTime/_player.duration;
    _progressLabel.text = [NSString stringWithFormat:@"%@´%@˝",@((NSUInteger)_player.currentPlaybackTime/60), @((NSUInteger)_player.currentPlaybackTime%60)];
}

//拖拉进度条
- (void)dragSliderAction:(UISlider *)slider
{
    if (self.isPlaying) {
        [self.player pause];
    }
    
    [self.sliderTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:GID_MAX]];
    [self.toolBarTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:GID_MAX]];
    _progressLabel.text = [NSString stringWithFormat:@"%@´%@˝",@((NSUInteger)(slider.value*_player.duration)/60), @((NSUInteger)(slider.value*_player.duration)%60)];
}
//放开进度条
- (void)dragSliderEnd:(UISlider *)slider
{
    [_player setCurrentPlaybackTime:slider.value * _player.duration];
    //NSLog(@"//////%f",slider.value * _player.duration);
    if (self.isPlaying) {
        [self.player play];
    }
    toolBarHiddenTime = 0;
    [self.sliderTimer setFireDate:[NSDate date]];
    [self.sliderTimer fire];
    [self.toolBarTimer setFireDate:[NSDate date]];
    [self.toolBarTimer fire];
}

- (UIView *)errorView
{
    if (!_errorView) {
        _errorView = [[UIView alloc]init];
        _errorView.backgroundColor = [UIColor blackColor];
        [self addSubview:_errorView];
        [_errorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        UIImageView *cryImage = [UIImageView new];
        [cryImage setImage:IMG(@"video_error")];
        [_errorView addSubview:cryImage];
        [cryImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(49, 49));
            make.center.equalTo(_errorView);
        }];
        
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor hexChangeFloat:@"fefefe" withAlpha:1];
        label.font = [UIFont systemFontOfSize:18.0f];
        label.text = @"出错了，视频暂时无法播放";
        [_errorView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(320, 20));
            make.top.equalTo(cryImage.mas_bottom);
            make.centerX.equalTo(cryImage.mas_centerX);
        }];
        
    }
    return _errorView;
}

- (HFProgressHUD *)HUD
{
    if (!_HUD) {
        _HUD = [[HFProgressHUD alloc]initWithView:self];
    }
    return _HUD;
}

@end
