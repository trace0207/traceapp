//
//  HFRefreshHeader.m
//  HFRefreshDemo
//
//  Created by zhuxiaoxia on 15/8/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFRefreshView.h"
#import "HFGifView.h"
@interface HFRefreshView ()
{
    UIImageView *arrowImageView;
}
@property (nonatomic, strong) HFGifView *gifView;
@end



@implementation HFRefreshView
@synthesize refreshState = _refreshState;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [bgImage setImage:[UIImage imageNamed:@"bg_circle"]];
        [self addSubview:bgImage];
        
        arrowImageView = [[UIImageView alloc]initWithFrame:bgImage.frame];
        [arrowImageView setImage:[UIImage imageNamed:@"arrow"]];
        [self addSubview:arrowImageView];

    }
    return self;
}

- (void)modifyRefreshState:(HFRefreshState)refreshState
{
    [self modifyRefreshState:refreshState withOffSetY:0];
}

/**
 *  修改刷新图标的状态
 *
 *  @param refreshState 状态
 *  @param offSetY      下拉的位置
 */
- (void)modifyRefreshState:(HFRefreshState)refreshState withOffSetY:(CGFloat)offSetY
{
    if (refreshState == HFRefreshStatePulling) {
        [self rotateArrowImage:offSetY];
    }else if (refreshState == HFRefreshStateLoading) {
        [self loadingRotate];
    }else {
        [self backStartPosition];
    }
}

//返回初始位置
- (void)backStartPosition
{
    arrowImageView.hidden = NO;
    [self.gifView stopGif];
    WS(weakSelf)
    [UIView animateWithDuration:0.25f animations:^{
        weakSelf.center = CGPointMake(weakSelf.center.x, -HFDefaultRefreshViewWidth/2);
        arrowImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (finished) {
            weakSelf.refreshState = HFRefreshStateNormal;
        }
    }];
}

//下拉的时候箭头图标跟着旋转
- (void)rotateArrowImage:(CGFloat)offSetY
{
    CGFloat angle = (offSetY/HFDefaultTopDistance)*M_PI;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.center = CGPointMake(self.center.x, -HFDefaultRefreshViewWidth/2 + offSetY*1.5);
        arrowImageView.transform = CGAffineTransformMakeRotation(angle);
    });
    
}

//progress开始画圈
- (void)loadingRotate
{
    arrowImageView.hidden = YES;
    self.refreshState = HFRefreshStateLoading;
    [self.gifView startGif];
}

- (HFGifView *)gifView
{
    if (!_gifView) {
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"refresh" ofType:@"gif"]];
        _gifView = [[HFGifView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) fileURL:url];
        [self addSubview:_gifView];
    }
    return _gifView;
}

@end
