//
//  HFVideoPlayer.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFProgressHUD.h"
@protocol HFVideoPlayerDelegate <NSObject>
@required

//视频窗口将要进入全屏
- (void)HFVideoPlayerWillEnterFullscreen;

//视频窗口将要退出全屏
- (void)HFVideoPlayerExitEnterFullscreen;

@end

@interface HFVideoPlayer : UIView

@property (nonatomic, weak) id<HFVideoPlayerDelegate>delegate;

//文件的链接
@property (nonatomic, copy) NSString *videoLink;
//视频的格式
@property (nonatomic, copy) NSString *videoFormat;
//视频第一帧的图片地址
@property (nonatomic, copy) NSString *videoPictureAddr;
//视频总时长
@property (nonatomic, assign) NSUInteger duration;
//视频的标题
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) HFProgressHUD *HUD;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, assign) BOOL fullScreenState;
//播放
- (void)play;
//暂停
-(void)pause;
//停止
-(void)stop;

- (void)back:(id)sender;//返回键

@end



