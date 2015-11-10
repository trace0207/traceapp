//
//  RBCustomDatePickerView.m
//  RBCustomDateTimePicker
//  e-mail:rbyyy924805@163.com
//  Created by renbing on 3/17/14.
//  Copyright (c) 2014 renbing. All rights reserved.
//

#import "RBCustomDatePickerView.h"
#import "GlobConfig.h"

@interface RBCustomDatePickerView()
{
    MXSCycleScrollView          *hourScrollView;//时滚动视图
    MXSCycleScrollView          *minuteScrollView;//分滚动视图
    UILabel                     *nowPickerShowTimeLabel;//当前picker显示的时间
    UIButton                    *OkBtn;//自定义picker上的确认按钮
}
@end

@implementation RBCustomDatePickerView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)back
{
    [minuteScrollView back];
    [hourScrollView back];
}

#pragma mark -custompicker
//设置自定义datepicker界面
- (void)setTimeBroadcastView
{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    bgView.backgroundColor = [UIColor HFColorStyle_6];
    [self addSubview:bgView];
    
    
    UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 200, 14)];
    timeLabel.text = _T(@"HF_Habit_Time_Settings");
    timeLabel.font = [UIFont systemFontOfSize:14.0];
    timeLabel.textColor = [UIColor HFColorStyle_3];
    [bgView addSubview:timeLabel];
    
    CGFloat origX = 50.0;
    CGFloat width = self.frame.size.width - origX * 2;
    
    UIView *beforeSepLine = [[UIView alloc] initWithFrame:CGRectMake(origX, 115, width, 0.5)];
    [beforeSepLine setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:beforeSepLine];
    UIView *bottomSepLine = [[UIView alloc] initWithFrame:CGRectMake(origX, 155, width, 0.5)];
    [bottomSepLine setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:bottomSepLine];
    [self setHourScrollView];
    [self setMinuteScrollView];
    
    //添加时 和 分
    UILabel * hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(hourScrollView.frame.origin.x + 35, beforeSepLine.frame.origin.y + 10, 20, 20)];
    hourLabel.textColor = [UIColor lightGrayColor];
    hourLabel.text = _T(@"HF_Habit_Time_Hour");
    [self addSubview:hourLabel];
    
    UILabel * minLabel = [[UILabel alloc] initWithFrame:CGRectMake(minuteScrollView.frame.origin.x + 35, beforeSepLine.frame.origin.y + 10, 20, 20)];
    minLabel.textColor = [UIColor lightGrayColor];
    minLabel.text = _T(@"HF_Habit_Time_Min");
    [self addSubview:minLabel];

}

//设置年月日时分的滚动视图
- (void)setHourScrollView
{
    hourScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake((kScreenWidth - 40 * 2) / 3, 40, 40.0, 190.0)];
    NSInteger hourint = [self setNowTimeShow:0];
    [hourScrollView setCurrentSelectPage:(hourint-2)];
    hourScrollView.delegate = self;
    hourScrollView.datasource = self;
    [self setAfterScrollShowView:hourScrollView andCurrentPage:1];
    [self addSubview:hourScrollView];
}
//设置年月日时分的滚动视图
- (void)setMinuteScrollView
{
    minuteScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(hourScrollView.frame.origin.x * 2 + 40 , 40, 40.0, 190.0)];
    NSInteger minuteint = [self setNowTimeShow:1];
    [minuteScrollView setCurrentSelectPage:(minuteint-2)];
    minuteScrollView.delegate = self;
    minuteScrollView.datasource = self;
    [self setAfterScrollShowView:minuteScrollView andCurrentPage:1];
    [self addSubview:minuteScrollView];
}

- (void)setAfterScrollShowView:(MXSCycleScrollView*)scrollview  andCurrentPage:(NSInteger)pageNumber
{
    UILabel *oneLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber];
    [oneLabel setFont:[UIFont systemFontOfSize:12]];
    [oneLabel setTextColor:RGBA(186.0, 186.0, 186.0, 1.0)];
    UILabel *twoLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+1];
    [twoLabel setFont:[UIFont systemFontOfSize:14]];
    [twoLabel setTextColor:RGBA(113.0, 113.0, 113.0, 1.0)];
    
    UILabel *currentLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+2];
    [currentLabel setFont:[UIFont systemFontOfSize:22]];
    [currentLabel setTextColor:[UIColor HFColorStyle_5]];
    
    UILabel *threeLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+3];
    [threeLabel setFont:[UIFont systemFontOfSize:14]];
    [threeLabel setTextColor:RGBA(113.0, 113.0, 113.0, 1.0)];
    UILabel *fourLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+4];
    [fourLabel setFont:[UIFont systemFontOfSize:12]];
    [fourLabel setTextColor:RGBA(186.0, 186.0, 186.0, 1.0)];
}
#pragma mark mxccyclescrollview delegate
#pragma mark mxccyclescrollview databasesource
- (NSInteger)numberOfPages:(MXSCycleScrollView*)scrollView
{
    if (scrollView == hourScrollView)
    {
        return 24;
    }
    else
    {
        return 60;
    }
}

- (UIView *)pageAtIndex:(NSInteger)index andScrollView:(MXSCycleScrollView *)scrollView
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scrollView.bounds.size.width, scrollView.bounds.size.height/5)];
    l.tag = index+1;
    if (scrollView == hourScrollView)
    {
        if (index < 10) {
            l.text = [NSString stringWithFormat:@"0%ld",(long)index];
        }
        else
            l.text = [NSString stringWithFormat:@"%ld",(long)index];
    }
    else
    {
        if (index < 10) {
            l.text = [NSString stringWithFormat:@"0%ld",(long)index];
        }
        else
            l.text = [NSString stringWithFormat:@"%ld",(long)index];
    }
    
    l.font = [UIFont systemFontOfSize:12];
    l.textAlignment = NSTextAlignmentCenter;
    l.backgroundColor = [UIColor clearColor];
    return l;
}

//设置现在时间
- (NSInteger)setNowTimeShow:(NSInteger)timeType
{
    if (delegate && [delegate respondsToSelector:@selector(showTimeString)])
    {
       NSString *dateString = [delegate showTimeString];
        
        if (dateString.length < 4)
        {
            DDLogError(@"警告，传入的字符串必须为大于4个字符的!格式0907");
        }
        switch (timeType) {
            case 0:
            {
                NSRange range = NSMakeRange(0, 2);
                NSString *hourString = [dateString substringWithRange:range];
                return hourString.integerValue;
            }
                break;
            case 1:
            {
                NSRange range = NSMakeRange(2, 2);
                NSString *minString = [dateString substringWithRange:range];
                return minString.integerValue;
            }
                break;
            default:
                break;
        }
    }
   
    return 00;
}

//滚动时上下标签显示(当前时间和是否为有效时间)
- (void)scrollviewDidChangeNumber
{
    UILabel *hourLabel = [[(UILabel*)[[hourScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *minuteLabel = [[(UILabel*)[[minuteScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    
    NSInteger hourInt = hourLabel.tag - 1;
    NSInteger minuteInt = minuteLabel.tag - 1;
    
    NSLog(@"%02ld    %02ld",(long)hourInt,(long)minuteInt);
    
    if (delegate && [delegate respondsToSelector:@selector(setTimeHour:min:)])
    {
        [delegate setTimeHour:hourInt min:minuteInt];
    }
    
}
@end
