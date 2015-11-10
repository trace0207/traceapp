//
//  HFTitleView.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/10/21.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import "HFTitleView.h"
CGFloat const titleWidth = 60;

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

- (instancetype)initWithTitles:(NSArray *)titles withScrollView:(UIScrollView *)scrollView
{
    self = [super initWithFrame:CGRectMake(0, 0, titles.count*titleWidth, 44)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        scrollView.delegate = self;
        mScrollView = scrollView;
        indicatorView = [[UIView alloc]initWithFrame:CGRectMake(10, 42, 40, 2)];
        indicatorView.backgroundColor = [UIColor whiteColor];
        lastLineCenter_x = indicatorView.center.x;
        [self addSubview:indicatorView];
        for (NSInteger i = 0; i < titles.count; i++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*titleWidth, 0, titleWidth, 44)];
            btn.tag = i+100;
            NSString *text = [titles objectAtIndex:i];
            [btn setTitle:text forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor HFColorStyle_6] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(selectTitleItem:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i == 0) {
                btn.selected = YES;
            }
        }
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
    indicatorView.center = CGPointMake(currentBtn.center.x,indicatorView.center.y);
    [mScrollView setContentOffset:CGPointMake(kScreenWidth*currentIndex, 0) animated:NO];
}

#pragma - scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    indicatorView.center = CGPointMake((scrollView.contentOffset.x-lastOffset_x)*(titleWidth/kScreenWidth) + lastLineCenter_x, indicatorView.center.y);
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
