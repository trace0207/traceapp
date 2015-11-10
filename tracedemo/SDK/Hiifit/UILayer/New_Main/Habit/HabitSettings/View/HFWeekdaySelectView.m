//
//  HFWeekdaySelectView.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFWeekdaySelectView.h"

#define kBaseWeekBtnTag  1001

@interface HFWeekdaySelectView()
{
    NSArray * mSources;
}
@end

@implementation HFWeekdaySelectView
@synthesize delegate;
- (id)init
{
    self = [super init];
    if (self)
    {
        [self loadUI];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initSource];
        [self loadUI];
        
    }
    return self;
}

- (void)initSource
{
    mSources = [[NSArray alloc] initWithObjects:_T(@"HF_Common_Sun"),_T(@"HF_Common_Mon"),_T(@"HF_Common_Tus"),_T(@"HF_Common_Wen"),_T(@"HF_Common_Thu"),_T(@"HF_Common_Fri"),_T(@"HF_Common_Sat"), nil];
}

- (void)loadUI
{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    bgView.backgroundColor = [UIColor HFColorStyle_6];
    [self addSubview:bgView];
    
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 100, 14)];
    titleLabel.text = _T(@"HF_Habit_Time_Repeat");
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    titleLabel.textColor = [UIColor HFColorStyle_3];
    [bgView addSubview:titleLabel];

    CGFloat sizeBounds = kScreenWidth > 320 ? 40 : 32;
    CGFloat orignX = (kScreenWidth - (sizeBounds + 10) * 7 + 15)/2;
    for (int i = 0; i < 7; i++)
    {
        BasePortraitButton * btn = [[BasePortraitButton alloc] initWithFrame:CGRectMake(orignX + (sizeBounds + 10) * i, titleLabel.frame.size.height + 50 , sizeBounds, sizeBounds)];
        [btn setTitle:[mSources objectAtIndex:i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor HFColorStyle_5]];
        btn.selected = YES;
        btn.tag = kBaseWeekBtnTag + i;
        [btn addTarget:self action:@selector(weekdaySelect:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)weekdaySelect:(UIButton *)btn
{
    if (delegate && [delegate respondsToSelector:@selector(weekSelectAction:selectedState:)])
    {
        btn.selected = !btn.selected;
        if (btn.selected)
        {
            [btn setBackgroundColor:[UIColor HFColorStyle_5]];
        }
        else
        {
            [btn setBackgroundColor:[UIColor HFColorStyle_6]];
        }
        
        [delegate weekSelectAction:btn.tag - kBaseWeekBtnTag selectedState:btn.selected];
    }
}

#pragma mark -
#pragma mark public
- (void)reloadData:(NSArray *)sources
{
    for (int i = 0; i < [sources count]; i++)
    {
        NSInteger flag = [[sources objectAtIndex:i] integerValue];
        NSInteger index = i == [sources count] - 1 ? 0 : i + 1;
        UIButton * btn = (UIButton *)[self viewWithTag:kBaseWeekBtnTag + index];
        if (flag == 1)
        {
            [btn setBackgroundColor:[UIColor HFColorStyle_5]];
            btn.selected = YES;
        }
        else
        {
            [btn setBackgroundColor:[UIColor HFColorStyle_6]];
            btn.selected = NO;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
