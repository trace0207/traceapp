//
//  MJPhotoProgressView.m
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MJPhotoProgressView.h"

#define kDegreeToRadian(x) (M_PI/180.0 * (x))

@interface MJPhotoProgressView()
{
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
    
    CGPoint centerPoint;
}
@property (nonatomic) float progressWidth;
@end


@implementation MJPhotoProgressView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor blackColor];
        self.layer.cornerRadius = frame.size.width / 2;
        
        _trackLayer = [CAShapeLayer new];
        [self.layer addSublayer:_trackLayer];
        _trackLayer.frame = CGRectMake(5, 5, frame.size.width - 10, frame.size.width - 10);
        _trackLayer.lineWidth = 5.0;
        
        
        _progressLayer = [CAShapeLayer new];
        [self.layer addSublayer:_progressLayer];
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.frame = CGRectMake(5, 5, frame.size.width - 10, frame.size.width - 10);
        _progressLayer.lineWidth = 5.0;
        
        centerPoint = CGPointMake((frame.size.width - 10)/2, (frame.size.height - 10)/2);
        
        [self initTrack];
        [self initProcess];
    }
    return self;
}

#pragma mark - Property Methods

- (UIColor *)trackTintColor
{
    if (!_trackTintColor)
    {
        _trackTintColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f];
    }
    return _trackTintColor;
}

- (UIColor *)progressTintColor
{
    if (!_progressTintColor)
    {
        _progressTintColor = [UIColor whiteColor];
    }
    return _progressTintColor;
}


- (void)initTrack
{
    
    _trackPath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:(self.bounds.size.width - _progressWidth - 10)/ 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];;
    _trackLayer.path = _trackPath.CGPath;
    _trackLayer.strokeColor = self.trackTintColor.CGColor;
}

- (void)initProcess
{
    _progressPath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:(self.bounds.size.width - _progressWidth - 10)/ 2 startAngle:- M_PI_2 endAngle:M_PI * 2 - M_PI_2 clockwise:YES];
    _progressLayer.path = _progressPath.CGPath;
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = 0;
    _progressLayer.strokeColor = self.progressTintColor.CGColor;
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    [self updateProcess];
}

- (void)updateProcess
{
    _progressLayer.strokeEnd = _progress;
}

@end
