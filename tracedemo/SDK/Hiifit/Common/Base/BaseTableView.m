//
//  BaseTableView.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseTableView.h"
#import "CLLRefreshHeadController.h"
@interface BaseTableView()<CLLRefreshHeadControllerDelegate>
{
    CLLRefreshHeadController * refreshController;
    
    BOOL  bHasFooter;
}
@end


@implementation BaseTableView
- (id)init
{
    self = [super init];
    if (self)
    {
        [self initSetting];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initSetting];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self initSetting];
    }
    return self;
}

- (void)initSetting
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (void)setBPullDownRefreash:(BOOL)bPullDown
{
    if (!refreshController)
    {
        refreshController = [[CLLRefreshHeadController alloc]initWithScrollView:self viewDelegate:self];
    }
    
    _bPullDownRefreash = bPullDown;
    
}


- (void)setBPullUpRefreash:(BOOL)bPullUp
{
    if (!refreshController)
    {
        refreshController = [[CLLRefreshHeadController alloc]initWithScrollView:self viewDelegate:self];
    }
    
    bHasFooter = bPullUp;
    
    _bPullUpRefreash = bPullUp;
    
}

- (void)startRequest
{
    [refreshController startPullDownRefreshing];
}

- (void)resetFooterRefreash:(BOOL)bFooter
{
    bHasFooter = bFooter;
}

- (void)endLoadMore
{
    [refreshController endPullUpLoading];
}

- (void)endRefreash
{
    [refreshController endPullDownRefreshing];
}

#pragma mark -
#pragma mark CLLRefreshHeadControllerDelegate
- (void)beginPullDownRefreshing
{
    if (_baseDelegate && [_baseDelegate respondsToSelector:@selector(pullDownAction)])
    {
        [_baseDelegate pullDownAction];
    }
}

- (void)beginPullUpLoading
{
    if (_baseDelegate && [_baseDelegate respondsToSelector:@selector(pullUpAction)])
    {
        [_baseDelegate pullUpAction];
    }
}

- (BOOL)hasRefreshFooterView
{
    if (!_bPullUpRefreash)
    {
        return NO;
    }
    else
    {
        if (bHasFooter)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}

- (CLLRefreshViewLayerType)refreshViewLayerType
{
    return CLLRefreshViewLayerTypeOnSuperView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
