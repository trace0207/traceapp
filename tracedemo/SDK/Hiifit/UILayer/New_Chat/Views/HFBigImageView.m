//
//  HFBigImageView.m
//  GuanHealth
//
//  Created by hermit on 15/5/24.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFBigImageView.h"

@implementation HFBigImageView

- (instancetype)initWithImage:(UIImage *)image withImageUrl:(NSString *)urlStr
{
    self = [super initWithFrame:kScreenBounds];
    self.backgroundColor = [UIColor blackColor];
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.frame];
    [self addSubview:imageView];
    [self addSubview:indicatorView];
    [indicatorView startAnimating];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:image options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [indicatorView removeFromSuperview];
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSelf:)];
    [imageView addGestureRecognizer:tap];
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithFrame:kScreenBounds];
    self.backgroundColor = [UIColor blackColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.frame];
    [imageView setImage:image];
    [self addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSelf:)];
    [imageView addGestureRecognizer:tap];
    return self;
}

- (void)show
{
    [[UIKitTool getAppdelegate].window addSubview:self];
}

- (void)hideSelf:(UITapGestureRecognizer*)tapGes
{
    [self removeFromSuperview];
}

@end
