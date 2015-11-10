//
//  CLLRefreshHeadView.m
//  RefreshLoadView
//
//  Created by chuliangliang on 14-6-12.
//  Copyright (c) 2014年 aikaola. All rights reserved.
//

#import "CLLRefreshHeadView.h"

@implementation CLLRefreshHeadView

//刷新操作提示
- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 100)/2,20, 100, 20)];
        
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.font = [UIFont systemFontOfSize:14.f];
        _statusLabel.textColor = [UIColor blackColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}
//时间
//- (UILabel *)timeLabel
//{
//    if (!_timeLabel) {
//        CGRect timeLabelFrame = self.statusLabel.frame;
//        timeLabelFrame.origin.y += CGRectGetHeight(timeLabelFrame) + 6;
//        _timeLabel = [[UILabel alloc] initWithFrame:timeLabelFrame];
//        _timeLabel.backgroundColor = [UIColor clearColor];
//        _timeLabel.font = [UIFont systemFontOfSize:11.f];
//        _timeLabel.textColor = [UIColor colorWithWhite:0.659 alpha:1.000];
//
//    }
//    return _timeLabel;
//}
//刷新圆圈
- (CLLRefreshCircleView *)circleView
{
    if (!_circleView) {
//        _circleView = [[CLLRefreshCircleView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) / 2.0 - CLLRefreshCircleViewHeight, CGRectGetMaxY(self.frame) + 14, CLLRefreshCircleViewHeight, CLLRefreshCircleViewHeight)];
//        NSLog(@"CGRectGetMaxX(self.frame) : %f",CGRectGetMaxX(self.frame));
        _circleView = [[CLLRefreshCircleView alloc] initWithFrame:CGRectMake(_statusLabel.frame.origin.x,20,CLLRefreshCircleViewHeight,CLLRefreshCircleViewHeight)];
    }
    return _circleView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.statusLabel];
        //[self addSubview:self.timeLabel];
        [self addSubview:self.circleView];
    }
    return self;
}
@end
