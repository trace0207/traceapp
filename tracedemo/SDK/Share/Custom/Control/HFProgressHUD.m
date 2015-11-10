//
//  HFProgressHUD.m
//  MBProgressHUD
//
//  Created by zhuxiaoxia on 15/8/10.
//  Copyright (c) 2015年 cmcc. All rights reserved.
//


#import "HFProgressHUD.h"

#if __has_feature(objc_arc)
#define MB_AUTORELEASE(exp) exp
#define MB_RELEASE(exp) exp
#define MB_RETAIN(exp) exp
#else
#define MB_AUTORELEASE(exp) [exp autorelease]
#define MB_RELEASE(exp) [exp release]
#define MB_RETAIN(exp) [exp retain]
#endif

@implementation HFProgressHUD

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.color = [UIColor clearColor];
        self.mode = MBProgressHUDModeAnnularDeterminate;
        self.removeFromSuperViewOnHide = YES;
    }
    return self;
}

- (void)updateIndicators
{
    [_indicator removeFromSuperview];
    _indicator = MB_AUTORELEASE([[HFRoundProgressView alloc] init]);
    [self addSubview:_indicator];
    _indicator.center = self.center;
    [(HFRoundProgressView *)_indicator setAnnular:YES];
}

- (void)updateUIForKeypath:(NSString *)keyPath {
    if ([keyPath isEqualToString:@"progress"]) {
        if ([self.indicator respondsToSelector:@selector(setProgress:)]) {
            [(id)self.indicator setValue:@(self.progress) forKey:@"progress"];
        }
        return;
    }
    [self setNeedsLayout];
    [self setNeedsDisplay];
    
}


@end

@implementation HFRoundProgressView

- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0, 0, 60, 60)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundTintColor = [UIColor lightGrayColor];
        progressLabel = [[UILabel alloc]initWithFrame:frame];
        progressLabel.backgroundColor = [UIColor clearColor];
        progressLabel.textColor = [UIColor whiteColor];
        progressLabel.text = @"0%";
        progressLabel.font = [UIFont systemFontOfSize:14];
        progressLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:progressLabel];
    }
    return self;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"progress"]) {
        NSUInteger p = (NSUInteger)(self.progress*100);
        progressLabel.text= [NSString stringWithFormat:@"%lu%@",(unsigned long)p,@"%"];
    }
    
    [self setNeedsDisplay];
}

@end
