//
//  CountDownView.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "CountDownView.h"
#import "UIColor+TK_Color.h"
@interface CountDownView ()

@property (nonatomic, strong) UILabel *hourLabel;
@property (nonatomic, strong) UILabel *minuteLabel;
@property (nonatomic, strong) UILabel *secondLabel;

@property (nonatomic, strong) UILabel *firstcolonLabel;
@property (nonatomic, strong) UILabel *secondcolonLabel;

@property (nonatomic, strong) NSTimer *countDownTimer;

@end

@implementation CountDownView

- (UILabel *)hourLabel
{
    if (_hourLabel == nil) {
        _hourLabel = [[UILabel alloc]init];
        _hourLabel.clipsToBounds = YES;
        _hourLabel.text = @"00";
        _hourLabel.textAlignment = NSTextAlignmentCenter;
        _hourLabel.textColor = [UIColor hexChangeFloat:TKColorRed];
        _hourLabel.font = [UIFont systemFontOfSize:11];
        [_hourLabel.layer setBorderColor:[UIColor hexChangeFloat:TKColorRed].CGColor];
        [_hourLabel.layer setBorderWidth:1];
        [self addSubview:_hourLabel];
    }
    return _hourLabel;
}

- (UILabel *)minuteLabel
{
    if (_minuteLabel == nil) {
        _minuteLabel = [[UILabel alloc]init];
        _minuteLabel.text = @"00";
        _minuteLabel.clipsToBounds = YES;
        _minuteLabel.textAlignment = NSTextAlignmentCenter;
        _minuteLabel.textColor = [UIColor hexChangeFloat:TKColorRed];
        _minuteLabel.font = [UIFont systemFontOfSize:11];
        [_minuteLabel.layer setBorderColor:[UIColor hexChangeFloat:TKColorRed].CGColor];
        [_minuteLabel.layer setBorderWidth:1];
        [self addSubview:_minuteLabel];
    }
    return _minuteLabel;
}

- (UILabel *)secondLabel
{
    if (_secondLabel == nil) {
        _secondLabel = [[UILabel alloc]init];
        _secondLabel.text = @"00";
        _secondLabel.clipsToBounds = YES;
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        _secondLabel.textColor = [UIColor hexChangeFloat:TKColorRed];
        _secondLabel.font = [UIFont systemFontOfSize:11];
        [_secondLabel.layer setBorderColor:[UIColor hexChangeFloat:TKColorRed].CGColor];
        [_secondLabel.layer setBorderWidth:1];
        [self addSubview:_secondLabel];
    }
    return _secondLabel;
}

- (UILabel *)firstcolonLabel
{
    if (_firstcolonLabel == nil) {
        _firstcolonLabel = [[UILabel alloc]init];
        _firstcolonLabel.textAlignment = NSTextAlignmentCenter;
        _firstcolonLabel.textColor = [UIColor hexChangeFloat:TKColorRed];
        _firstcolonLabel.font = [UIFont systemFontOfSize:11];
        _firstcolonLabel.text = @":";
        [self addSubview:_firstcolonLabel];
    }
    return _firstcolonLabel;
}

- (UILabel *)secondcolonLabel
{
    if (_secondcolonLabel == nil) {
        _secondcolonLabel = [[UILabel alloc]init];
        _secondcolonLabel.textAlignment = NSTextAlignmentCenter;
        _secondcolonLabel.textColor = [UIColor hexChangeFloat:TKColorRed];
        _secondcolonLabel.font = [UIFont systemFontOfSize:11];
        _secondcolonLabel.text = @":";
        [self addSubview:_secondcolonLabel];
    }
    return _secondcolonLabel;
}

- (void)layoutSubviews
{
    [self.hourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.bottom.equalTo(self).with.offset(-1);
    }];
    [self.firstcolonLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hourLabel.mas_right);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(6);
    }];
    [self.minuteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstcolonLabel.mas_right).with.offset(1);
        make.top.equalTo(self);
        make.bottom.equalTo(self).with.offset(-1);
        make.width.equalTo(self.hourLabel);
    }];
    [self.secondcolonLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.minuteLabel.mas_right).with.offset(1);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(6);
    }];
    [self.secondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondcolonLabel.mas_right);
        make.top.right.equalTo(self);
        make.bottom.equalTo(self).with.offset(-1);
//        make.right.equalTo(self).with.offset(-1);
        make.width.equalTo(self.minuteLabel);
    }];
}

- (NSTimer *)countDownTimer
{
   
    if (_countDownTimer == nil) {
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_countDownTimer forMode:NSRunLoopCommonModes];
    }
    return _countDownTimer;
}

- (void)countDown:(NSTimer *)timer
{
    _secondsUTC --;
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_secondsUTC];
//    NSTimeInterval seconds = [date timeIntervalSinceNow];
    if (_secondsUTC <= 0) {
        [self timeOverAction];
    }else {
        [self setCountDownTimeWihtUTC:_secondsUTC];
    }
}

- (void)setSecondsUTC:(NSTimeInterval)secondsUTC
{
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval since1970 = [currentDate timeIntervalSince1970];
    if (secondsUTC <= since1970) {
        [self timeOverAction];
        return;
    }
    
    _secondsUTC = secondsUTC;
    [self.countDownTimer fire];
}


-(void)beginCutDownFromSeconds:(NSInteger)remainSeconds
{
//     NSDate *currentDate = [NSDate date];
    _secondsUTC = remainSeconds;
    if(remainSeconds < 0)
    {
        _secondsUTC = 0;
    }
//    _secondsUTC = [currentDate timeIntervalSinceNow] + remainSeconds;
    [self.countDownTimer fire];
}


- (void)setCountDownTimeWihtUTC:(NSTimeInterval)seconds
{
    int hours = seconds/BSHour;
    int minutes = ((NSUInteger)seconds%BSHour)/BSMinute;
    int second = (seconds - hours*BSHour - minutes*BSMinute);
    self.hourLabel.text = [NSString stringWithFormat:@"%02i",hours];
    self.minuteLabel.text = [NSString stringWithFormat:@"%02i",minutes];
    self.secondLabel.text = [NSString stringWithFormat:@"%02i",second];
    
}

- (void)timeOverAction
{
    [self setCountDownTimeWihtUTC:0];
    if (_countDownTimer) {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(timeOver)]) {
        [self.delegate timeOver];
    }
}

- (void)dealloc
{
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
    self.firstcolonLabel = nil;
    self.secondLabel = nil;
    self.secondcolonLabel = nil;
    self.hourLabel = nil;
    self.minuteLabel = nil;
}

@end
