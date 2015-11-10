//
//  HFGifPlayer.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/16.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFGifPlayer.h"
#import "HFProgressHUD.h"
#import "Masonry.h"
#import "SDWebImageCompat.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

@interface HFGifPlayer ()

@property (nonatomic, strong) UIImageView *gifView;
@property (nonatomic, strong) UIImageView *picView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UILabel *gifLabel;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) HFProgressHUD *HUD;

@end

@implementation HFGifPlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = [UIColor blackColor];
    _gifView = [[UIImageView alloc]init];
    [self addSubview:_gifView];
    [_gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _picView = [[UIImageView alloc]init];
    _picView.backgroundColor = [UIColor blackColor];
    [self addSubview:_picView];
    [_picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    WS(weakSelf)
    _gifLabel = [[UILabel alloc]init];
    _gifLabel.text = @"GIF";
    _gifLabel.textColor = [UIColor whiteColor];
    _gifLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview: _gifLabel];
    [_gifLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(weakSelf.mas_top).with.offset(10);
        make.right.equalTo(weakSelf.mas_right).with.offset(-15);
    }];
}

- (void)playGif
{
    if (self.gifLink == nil || ![self.gifLink hasPrefix:@"http"]) {
        
        [self.errorLabel setHidden:NO];
        return;
    }
    if (_errorLabel) {
        _errorLabel.hidden = YES;
    }
    WS(weakSelf)
    if (![[SDImageCache sharedImageCache]diskImageExistsWithKey:self.gifLink]) {
        self.picView.hidden = NO;
        [self addSubview:self.HUD];
        [self.HUD mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(weakSelf.frame), CGRectGetHeight(weakSelf.frame)));
            make.centerX.equalTo(_gifView.mas_centerX);
            make.centerY.equalTo(_gifView.mas_centerY);
        }];
        [self.HUD show:YES];
    }
    NSURL *url = [NSURL URLWithString:self.gifLink];
    [_gifView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (expectedSize>0) {
            weakSelf.HUD.progress = (CGFloat)receivedSize/expectedSize;
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (_HUD) {
            [_HUD hide:YES];
        }
        _picView.hidden = YES;
        if (error) {
            [weakSelf.errorLabel setHidden:NO];
        }
    }];
}

- (void)setGifLink:(NSString *)gifLink
{
    _gifLink = gifLink;
    [self playGif];
}

- (void)setPictureUrl:(NSString *)pictureUrl
{
    _pictureUrl = pictureUrl;
    [_picView sd_setImageWithURL:[NSURL URLWithString:pictureUrl] placeholderImage:nil];
}

- (UILabel *)errorLabel
{
    if (!_errorLabel) {
        _errorLabel = [[UILabel alloc]init];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        _errorLabel.numberOfLines = 0;
        _errorLabel.textColor = [UIColor hexChangeFloat:@"fefefe" withAlpha:1];
        _errorLabel.font = [UIFont systemFontOfSize:18.0f];
        _errorLabel.text = @"图片加载失败，稍后再试试吧";
        [self addSubview:_errorLabel];
        [_errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(320, 40));
            make.centerY.equalTo(_gifView.mas_centerY);
            make.centerX.equalTo(_gifView.mas_centerX);
        }];
    }
    _picView.hidden = NO;
    return _errorLabel;
}

- (HFProgressHUD *)HUD
{
    if (!_HUD) {
        _HUD = [[HFProgressHUD alloc]initWithView:self];
    }
    return _HUD;
}

@end
