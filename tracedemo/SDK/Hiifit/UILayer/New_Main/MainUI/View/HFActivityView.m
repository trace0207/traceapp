//
//  HFActivityView.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/11/3.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import "HFActivityView.h"

@interface HFActivityView ()
{
    NSString *activityUrl;
}
@end

@implementation HFActivityView

- (instancetype)initWithImage:(NSString *)urlStr activityUrl:(NSString *)url
{
    self = [super initWithFrame:kScreenBounds];
    
    if (self) {
        activityUrl = url;
        self.backgroundColor = [UIColor clearColor];
        UIView *backgroundView = [[UIView alloc]init];
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 0.5;
        [self addSubview:backgroundView];
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        CGFloat with = 270.0 * kScreenScale;
        WS(weakSelf)
        UIButton *imageView = [[UIButton alloc]init];
        [imageView addTarget:self action:@selector(goActivityViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(with, with));
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.centerY.equalTo(weakSelf.mas_centerY);
        }];
        
        UIButton *cancelBtn =[[UIButton alloc]init];
        [cancelBtn setImage:IMG(@"cancle_x") forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.right.equalTo(imageView.mas_right);
            make.bottom.equalTo(imageView.mas_top);
        }];
        
        [imageView sd_setBackgroundImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal];
    }
    
    return self;
}

- (void)show
{
    UIViewController *vc = [[[UIApplication sharedApplication]keyWindow]rootViewController];
    [vc.view addSubview:self];
}

- (void)goActivityViewAction:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(goActivityView:)]) {
        [self.delegate goActivityView:activityUrl];
    }
    [self removeFromSuperview];
}

- (void)cancelAction:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancel)]) {
        [self.delegate cancel];
    }
    [self removeFromSuperview];
}

@end
