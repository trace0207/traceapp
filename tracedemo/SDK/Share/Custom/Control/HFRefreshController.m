//
//  HFRefreshController.m
//  HFRefreshDemo
//
//  Created by zhuxiaoxia on 15/8/19.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFRefreshController.h"
#import "HFRefreshView.h"



@interface HFRefreshController ()
{
    BOOL activity; //下拉释放修改状态开关
}

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)HFRefreshView *refreshView;

@property (nonatomic,weak)id<HFRefreshControllerDelegate>delegate;
@property (nonatomic, readwrite) CGFloat originalTopInset;

@end

@implementation HFRefreshController
- (instancetype)initWithScrollView:(UIScrollView *)scrollView viewDelegate:(id <HFRefreshControllerDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.scrollView = scrollView;
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.loading = YES;
    UIView *superView = self.scrollView.superview;
    [superView insertSubview:self.refreshView atIndex:100];
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}

- (HFRefreshView *)refreshView
{
    if (!_refreshView) {
        _refreshView = [[HFRefreshView alloc]initWithFrame:CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds)-HFDefaultRefreshViewWidth)/2.0, 0-HFDefaultRefreshViewWidth, HFDefaultRefreshViewWidth, HFDefaultRefreshViewWidth)];
    }
    return _refreshView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat contentOffsetY = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue].y;
        
        //下拉
        if (self.scrollView.isTracking && contentOffsetY < 0) {
            activity = YES;
            if (self.refreshView.refreshState != HFRefreshStateLoading && contentOffsetY >= -HFDefaultTopDistance) {
                //NSLog(@"contentOffsetY: %f",contentOffsetY);
                [self.refreshView modifyRefreshState:HFRefreshStatePulling withOffSetY:-contentOffsetY];
            }
        }
        
        if (!self.scrollView.isTracking && contentOffsetY < 0) {
            if (activity && self.refreshView.refreshState != HFRefreshStateLoading) {
                if (contentOffsetY <= -HFDefaultTopDistance+20) {
                    [self.refreshView modifyRefreshState:HFRefreshStateLoading];
                    if (self.delegate && [self.delegate respondsToSelector:@selector(startRefreshing)]) {
                        [self.delegate startRefreshing];
                    }
                }else {
                    [self.refreshView modifyRefreshState:HFRefreshStateNormal];
                }
                activity = NO;
            }
        }

        //上拉
        if (contentOffsetY > self.scrollView.contentSize.height - CGRectGetHeight(self.scrollView.frame)) {
            
            if (self.scrollView.tracking) {
                self.loading = NO;
            }
            
            if (!self.scrollView.isTracking && !self.isLoading) {
                
                if ([self.delegate respondsToSelector:@selector(hasMoreData)]) {
                    
                    if ([self.delegate hasMoreData] &&
                        [self.delegate respondsToSelector:@selector(loadMoreData)]) {
                        
                        self.loading = YES;
                        [self.delegate loadMoreData];
                    }
                }
            }
        }
    }
}

- (void)endRefreshing
{
    self.refreshView.refreshState = HFRefreshStateStopped;
    [self.refreshView modifyRefreshState:HFRefreshStateStopped];
}

@end
