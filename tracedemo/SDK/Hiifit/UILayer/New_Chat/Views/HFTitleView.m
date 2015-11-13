//
//  HFTitleView.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/10/21.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import "HFTitleView.h"
CGFloat const titleWidth = 80;

@interface HFTitleView ()<UIScrollViewDelegate>
{
    UIView *indicatorView;
    UIScrollView *mScrollView;
    CGFloat lastOffset_x;
    CGFloat lastLineCenter_x;
}

@end

@implementation HFTitleView
@synthesize delegate;

- (instancetype)initWithTitles:(NSArray *)titles withScrollView:(UIScrollView *)scrollView defaultColor:(UIColor *)defaultcColor activeColor:(UIColor *)activeColor;
{
    self = [super initWithFrame:CGRectMake(0, 0, titles.count*titleWidth, 44)];
    if (self) {
        lastLineCenter_x = 0;
        self.backgroundColor = [UIColor clearColor];
        scrollView.delegate = self;
        mScrollView = scrollView;
        indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 42, titleWidth, 2)];
        indicatorView.backgroundColor = activeColor;
//        lastLineCenter_x = indicatorView.center.x;
        [self addSubview:indicatorView];
        UIButton * defaultSelect;
        for (NSInteger i = 0; i < titles.count; i++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*titleWidth, 0, titleWidth, 44)];
            btn.tag = i+100;
            NSString *text = [titles objectAtIndex:i];
            [btn setTitle:text forState:UIControlStateNormal];
            [btn setTitleColor:defaultcColor forState:UIControlStateNormal];
            [btn setTitleColor:activeColor forState:UIControlStateSelected];
            [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
//            [btn setBackgroundColor:[UIColor grayColor]];
            [btn addTarget:self action:@selector(selectTitleItem:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i == 0) {
//                btn.selected = YES;
                defaultSelect = btn;
                
            }
        }
        defaultSelect.selected = YES;
        [self selectTitleItem:defaultSelect];
        lastLineCenter_x = indicatorView.center.x;
    }
    return self;
}

- (void)selectTitleItem:(UIButton *)btn
{
    [self setCurrentIndex:btn.tag-100];
    if (self.delegate && [self.delegate respondsToSelector:@selector(titleViewDidSelectedAtIndex:clickMenuTap:)]) {
        [self.delegate titleViewDidSelectedAtIndex:btn.tag-100 clickMenuTap:YES];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (_currentIndex == currentIndex) {
        return;
    }
    UIButton *lastBtn = (UIButton *)[self viewWithTag:_currentIndex+100];
    lastBtn.selected = NO;
    UIButton *currentBtn = (UIButton *)[self viewWithTag:currentIndex+100];
    currentBtn.selected = YES;
    _currentIndex = currentIndex;
//    indicatorView.center = CGPointMake(currentBtn.center.x,indicatorView.center.y);
    [mScrollView setContentOffset:CGPointMake(kScreenWidth*currentIndex, 0) animated:YES];
//    [mScrollView scrollRectToVisible:CGPointMake(kScreenWidth*currentIndex, 0) animated:YES];
}

#pragma - scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentX = (scrollView.contentOffset.x-lastOffset_x)*(titleWidth/kScreenWidth) + lastLineCenter_x ;
    indicatorView.center = CGPointMake(currentX, indicatorView.center.y);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    lastOffset_x = scrollView.contentOffset.x;
    lastLineCenter_x = indicatorView.center.x;
    NSInteger page = scrollView.contentOffset.x/kScreenWidth;
    if (_currentIndex != page) {
        
        [self setCurrentIndex:page];
        if (self.delegate && [self.delegate respondsToSelector:@selector(titleViewDidSelectedAtIndex:clickMenuTap:)]) {
            [self.delegate titleViewDidSelectedAtIndex:page clickMenuTap:NO];
        }
    }
}

@end
