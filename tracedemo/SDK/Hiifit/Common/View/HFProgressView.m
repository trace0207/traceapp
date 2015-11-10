//
//  HFProgressView.m
//
//  Created by zhuxiaoxia on 14-8-5.
//  Copyright (c) 2014年 ChinaMobile. All rights reserved.
//

#import "HFProgressView.h"

@interface HFProgressView()

@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UIView *trackView;

@end

@implementation HFProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initProgress];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initProgress];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initProgress];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)initProgress
{
    self.backgroundColor = [UIColor clearColor];
    _separatorColor = [UIColor whiteColor];
    _separatorWidth = 2.0f;
    
    _trackView = [[UIView alloc]init];
    _trackView.backgroundColor = RGBA(234, 234, 234, 1);
    [self addSubview:_trackView];

    [_trackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    _progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
    _progressView.backgroundColor = [UIColor lightGrayColor];
    [self setProgressStyle:HFProgressViewBorderStyleDefault];
    [self addSubview:_progressView];
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated;
{
    if (progress<0) {
        progress = 0.;
    }else if (progress > 1) {
        progress = 1.;
    }
    if (animated) {
        CGFloat speed = 320.0f;
        CGFloat distance = fabs(progress-_currentProgress)*self.frame.size.width;
        
       // NSLog(@"distance:~~~~~~~~~~%f",distance);
        
        WS(weakSelf)
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:distance/speed animations:^{
                _progressView.frame = CGRectMake(_progressView.frame.origin.x, _progressView.frame.origin.y, weakSelf.frame.size.width*progress, weakSelf.frame.size.height);
            }];
        });
    }else {
        WS(weakSelf)
        dispatch_async(dispatch_get_main_queue(), ^{
            _progressView.frame = CGRectMake(_progressView.frame.origin.x, _progressView.frame.origin.y, weakSelf.frame.size.width*progress, weakSelf.frame.size.height);
        });
        
    }
    _currentProgress = progress;
}

- (void)setProgressImage:(UIImage *)progressImage
{
    _progressImage = progressImage;
    if (_progressView) {
        [_progressView setBackgroundColor:[UIColor colorWithPatternImage:progressImage]];
    }
}

- (void)setTrackImage:(UIImage *)trackImage
{
    _trackImage = trackImage;
    if (_trackView) {
        [_trackView setBackgroundColor:[UIColor colorWithPatternImage:trackImage]];
    }
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressTintColor = progressTintColor;
    if (_progressView) {
        [_progressView setBackgroundColor:progressTintColor];
    }
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    _trackTintColor = trackTintColor;
    if (_trackView) {
        [_trackView setBackgroundColor:trackTintColor];
    }
}

- (void)setSeparatorNumber:(NSInteger)separatorNumber
{
    
    for (NSUInteger i = 1; i <= _separatorNumber; i++) {
        UIView *sepatator = [self viewWithTag:i+100];
        if (sepatator) {
            [sepatator removeFromSuperview];
            sepatator = nil;
        }
    }
    WS(weakSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        for (NSInteger i = 1; i <= separatorNumber; i++) {
            CGFloat width = weakSelf.frame.size.width/(_separatorNumber+1);
            UIView *separator = [[UIView alloc]initWithFrame:CGRectMake(i*width-0.5*_separatorWidth, 0, _separatorWidth, weakSelf.frame.size.height)];
            separator.backgroundColor = _separatorColor;
            separator.tag = 100 + i;
            [weakSelf addSubview:separator];
            
        }
    });
    _separatorNumber = separatorNumber;
}

- (void)setSeparatorColor:(UIColor *)separatorColor
{
    _separatorColor = separatorColor;
    for (NSInteger i = 1; i <= _separatorNumber; i++) {
        UIView *sepatator = [self viewWithTag:i+100];
        sepatator.backgroundColor = separatorColor;
    }
}

- (void)setSeparatorWidth:(CGFloat)separatorWidth
{
    _separatorWidth = separatorWidth;
    for (NSInteger i = 1; i <= _separatorNumber; i++) {
        UIView *sepatator = [self viewWithTag:i+100];
        sepatator.frame = CGRectMake(sepatator.frame.origin.x, sepatator.frame.origin.y, separatorWidth, self.frame.size.height);
    }
}

- (void)setProgressStyle:(HFProgressViewBorderStyle)progressStyle
{
    if (progressStyle == HFProgressViewBorderSquare) {
        [_trackView.layer setCornerRadius:0.0f];
        [_progressView.layer setCornerRadius:0.0f];
    }else if (progressStyle == HFProgressViewBorderHalfSquare) {
        
        [_trackView.layer setCornerRadius:self.frame.size.height/2.0f];
        [_progressView.layer setCornerRadius:self.frame.size.height/2.0f];
    }else {
        [_trackView.layer setCornerRadius:self.frame.size.height/3.0f];
        [_progressView.layer setCornerRadius:self.frame.size.height/3.0f];
    }
}

@end
