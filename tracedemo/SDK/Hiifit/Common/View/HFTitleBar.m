//
//  HFTitleBar.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFTitleBar.h"
#import "UIButton+MixButton.h"
#define kBarTag  1000

@interface HFTitleBar()
{
    NSInteger mCurrentIndex;
    
}
@property(nonatomic,strong)UIView  * mLineView;
@property(nonatomic,strong)UIColor * mSelColor;
@property(nonatomic,strong)UIColor * mDisColor;
@end


@implementation HFTitleBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        mCurrentIndex = 0;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        mCurrentIndex = 0;
    }
    return self;
}


#pragma mark -
#pragma mark public
- (void)updateBarItemFinish:(NSInteger)index
{
    UIButton * button = (UIButton *)[self viewWithTag:kBarTag + index];
    [button setImage:IMG(@"select_icon") forState:UIControlStateNormal withOffset:-15 direction:button_horizontalType];
}

- (void)updateItemSelected:(NSInteger)index
{
    UIButton * btn = (UIButton *)[self viewWithTag:kBarTag + index];
    
    if (btn)
    {
        [self barItemClick:btn];
    }
}


- (void)setBarTitles:(NSArray *)titles selectColor:(UIColor *)selColor  disColor:(UIColor *)disColor
{
    self.mTitles = titles;
    
    self.mSelColor = selColor;
    self.mDisColor = disColor;
    
    for (NSInteger i = 0; i < [titles count]; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        btn.tag = kBarTag + i;
        btn.frame = CGRectMake(i * self.frame.size.width / [titles count] , 0, self.frame.size.width / [titles count], self.frame.size.height - 2);
        btn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [btn setTitleColor:disColor forState:UIControlStateNormal];
        [btn setTitleColor:disColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(barItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        if (mCurrentIndex == i)
        {
            [btn setTitleColor:selColor forState:UIControlStateNormal];
        }
        
    }

    self.mLineView.backgroundColor = [UIColor hexChangeFloat:@"cccccc" withAlpha:1.0];
}


- (void)barItemClick:(UIButton *)button
{
    NSInteger index = button.tag - kBarTag;
    
    if (index == mCurrentIndex)
    {
        return;
    }
    
    UIButton * btn = (UIButton *)[self viewWithTag:kBarTag + mCurrentIndex];
    [btn setTitleColor:self.mDisColor forState:UIControlStateNormal];
    mCurrentIndex = index;
    
    UIButton * selectBtn = (UIButton *)[self viewWithTag:kBarTag + mCurrentIndex];
    [selectBtn setTitleColor:self.mSelColor forState:UIControlStateNormal];
    
    if (self.hasLine)
    {
        [self scrollLineToIndex:index];
    }
    
    
    if(_delegate && [_delegate respondsToSelector:@selector(selectBarItem:)])
    {
        [_delegate selectBarItem:button.tag - kBarTag];
    }
}

#pragma mark -
#pragma mark getter
- (UIView *)mLineView
{
    if (!_mLineView)
    {
      //  NSInteger titles = [self.mTitles count];
        _mLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
        _mLineView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_mLineView];
    }
    return _mLineView;
}

- (void)scrollLineToIndex:(NSInteger)index
{
    
    CGFloat width = self.frame.size.width / [self.mTitles count];
    
    if (!self.hasLine)
    {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.mLineView.frame = CGRectMake(width * mCurrentIndex, self.mLineView.frame.origin.y, self.mLineView.frame.size.width, self.mLineView.frame.size.height);
    }];
}

@end
