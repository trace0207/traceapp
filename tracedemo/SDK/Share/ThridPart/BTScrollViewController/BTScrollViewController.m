//
//  BTScrollViewController.m
//  LaiWen
//
//  Created by hermit on 14-8-13.
//  Copyright (c) 2014年 BeanTink. All rights reserved.
//

#import "BTScrollViewController.h"
#import "UIButton+RedPointButton.h"
#define DefaultHeight 48.0f

@interface BTScrollViewController ()
{
    UIView * mHeaderView;
}
@end

@implementation BTScrollViewController
@synthesize BTScrolldelegate;
@synthesize hasSeperatorLine;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        if (IOS7_OR_LATER) {
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.modalPresentationCapturesStatusBarAppearance= NO;
        }
        
        [self defaultSettings];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initHeaderView];
    [self initContentView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)defaultSettings
{
    NSLog(@"defaultSettings");
    _indicatorColor = [UIColor HFColorStyle_5];
    _headerColor = [UIColor HFColorStyle_5];;
    _headerHeight = DefaultHeight;
    _headerWidth = kScreenWidth;
    _selectTextColor = [UIColor whiteColor];
    _unselectTextColor = [UIColor whiteColor];
    _currentIndex = 0;
}

- (void)initHeaderView
{
    mHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _headerWidth, _headerHeight)];
    mHeaderView.backgroundColor = _headerColor;
    CGFloat tabWidth = _headerWidth/self.titleArray.count;
    indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, _headerHeight-2, tabWidth, 2)];
    indicatorView.backgroundColor = _indicatorColor;
    [mHeaderView addSubview:indicatorView];
    lastLineCenter_x = indicatorView.center.x;
    for (int i=0; i<self.titleArray.count; i++) {
        UIButton *tapBt = [[UIButton alloc]initWithFrame:CGRectMake(i*tabWidth, 0, tabWidth -1, _headerHeight)];
        tapBt.tag = i+1000;
        tapBt.backgroundColor = [UIColor clearColor];
        NSString *title = [self.titleArray objectAtIndex:i];
        [tapBt setTitle:title forState:UIControlStateNormal];
        [tapBt.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0f]];
        if (i == _currentIndex) {
            [tapBt setTitleColor:_selectTextColor forState:UIControlStateNormal];
        }else{
            [tapBt setTitleColor:_unselectTextColor forState:UIControlStateNormal];
        }
        [tapBt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [tapBt addTarget:self action:@selector(tapTitle:) forControlEvents:UIControlEventTouchUpInside];
        [mHeaderView addSubview:tapBt];
        
        if (hasSeperatorLine)
        {
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(i * tabWidth, 8, 1, _headerHeight - 16)];
            line.backgroundColor = [UIColor HFColorStyle_6];
            [mHeaderView addSubview:line];
        }
    }
    
    if (hasSeperatorLine)
    {
        UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _headerHeight - 1, mHeaderView.frame.size.width, 1)];
        bottomLine.backgroundColor = [UIColor HFColorStyle_6];
        [mHeaderView addSubview: bottomLine];
    }
    
    
    [self.view addSubview:mHeaderView];
}

- (void)switchMessageTipState:(BOOL)show atIndex:(NSInteger)index
{
    UIButton * button = (UIButton *)[mHeaderView viewWithTag:index + 1000];
    if (show)
    {
        [button addRedPoint];
    }
    else
    {
        [button dismissRedPoint];
    }
}

- (void)initContentView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,_headerHeight, _headerWidth, kScreenHeight-_headerHeight)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.alwaysBounceVertical = NO;
    //_scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(_headerWidth*self.titleArray.count, _scrollView.frame.size.height);
    _scrollView.backgroundColor = [UIColor whiteColor];
    for (int i=0; i<self.ContentArray.count; i++) {
        UIView *ContentView = [self.ContentArray objectAtIndex:i];
        ContentView.frame = CGRectMake(i*_headerWidth, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        [_scrollView addSubview:ContentView];
    }
    [self.view addSubview:_scrollView];
    lastOffset_x = _scrollView.contentOffset.x;
}

- (void)tapTitle:(UIButton *)bt
{
    if (_currentIndex == bt.tag) {
        return;
    }
    [_scrollView setContentOffset:CGPointMake(_headerWidth*(bt.tag - 1000),0) animated:YES];
    for (int i=0; i<self.titleArray.count; i++) {
        UIButton *_bt = (UIButton *)[self.view viewWithTag:i+1000];
        if (_bt.tag == bt.tag) {
            [_bt setTitleColor:_selectTextColor forState:UIControlStateNormal];
        }else{
            [_bt setTitleColor:_unselectTextColor forState:UIControlStateNormal];
        }
    }
    _currentIndex = bt.tag - 1000;
    if (BTScrolldelegate && [BTScrolldelegate respondsToSelector:@selector(ScrollAtIndex:)]) {
        [BTScrolldelegate ScrollAtIndex:_currentIndex];
    }
}

#pragma - scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isEqual:_scrollView]) {
        return;
    }
    
    indicatorView.center = CGPointMake((-lastOffset_x+scrollView.contentOffset.x)/self.titleArray.count + lastLineCenter_x, indicatorView.center.y);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (![scrollView isEqual:_scrollView]) {
        return;
    }
    lastOffset_x = scrollView.contentOffset.x;
    lastLineCenter_x = indicatorView.center.x;
    _currentIndex = scrollView.contentOffset.x/_headerWidth;
    UIButton *bt = (UIButton *)[self.view viewWithTag:_currentIndex+1000];
    if (bt) {
        [self tapTitle:bt];
    }
}
@end
