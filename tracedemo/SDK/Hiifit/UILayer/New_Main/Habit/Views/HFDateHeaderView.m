//
//  HFDateHeaderView.m
//  GuanHealth
//
//  Created by hermit on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFDateHeaderView.h"
#import "NSDate+Helpers.h"
#import "NSDate+HFHelper.h"

@implementation HFDateHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    _leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(24, 20, 12, 20)];
    [_leftImage setImage:IMG(@"cusp_left")];
    [self addSubview:_leftImage];
    
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    [_leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtn];
    
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2-100-3, 0, 100, 60)];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    _dateLabel.textColor = [UIColor HFColorStyle_2];
    _dateLabel.font = [UIFont systemFontOfSize:14.0f];
    _dateLabel.text = @"5月21日";
    [self addSubview:_dateLabel];
    _dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2 + 3, 0, 60, 60)];
    _dayLabel.textColor = [UIColor HFColorStyle_5];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dayLabel.font = [UIFont systemFontOfSize:16.0f];
    _dayLabel.text = @"今日";
    [self addSubview:_dayLabel];
    
    _rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-24-12, 20, 12, 20)];
    [_rightImage setImage:IMG(@"cusp_right")];
    _rightImage.hidden = YES;
    [self addSubview:_rightImage];
    
    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-60, 0, 60, 60)];
    [_rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtn];
    
    return self;
}

- (void)leftAction:(UIButton*)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(leftPage:)]) {
        [_delegate leftPage:self];
    }
}

- (void)rightAction:(UIButton*)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(rightPage:)]) {
        [_delegate rightPage:self];
    }
}

- (void)setLeftViewHidden:(BOOL)hidden
{
    self.leftBtn.hidden = hidden;
    self.leftImage.hidden = hidden;
}

- (void)setRightViewHidden:(BOOL)hidden
{
    self.rightBtn.hidden = hidden;
    self.rightImage.hidden = hidden;
}

- (void)setTitileWithDate:(NSDate *)date nearDay:(NSInteger)day
{
    if (day == 0) {
        self.dayLabel.text = @"今天";
    }else if (day == 1) {
        self.dayLabel.text = @"昨天";
    }else{
        NSInteger week = [NSDate getCurrentWeekday:date];
        self.dayLabel.text = [self weekString:week];
    }
    
    NSString *dateStr = [NSDate stringFromDate:date withFormatString:@"MM月dd日" andTimeZone:NSDateTimeZoneGMT];
    self.dateLabel.text = dateStr;
}

- (NSString *)weekString:(NSInteger)week
{
    switch (week) {
        case 1:
            return @"星期一";
            break;
        case 2:
            return @"星期二";
            break;
        case 3:
            return @"星期三";
            break;
        case 4:
            return @"星期四";
            break;
        case 5:
            return @"星期五";
            break;
        case 6:
            return @"星期六";
            break;
            
        default:
            return @"星期日";
            break;
    }
}

@end
