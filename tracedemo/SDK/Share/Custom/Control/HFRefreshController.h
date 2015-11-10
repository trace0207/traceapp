//
//  HFRefreshController.h
//  HFRefreshDemo
//
//  Created by zhuxiaoxia on 15/8/19.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol HFRefreshControllerDelegate <NSObject>

- (void)startRefreshing;

@optional

- (BOOL)hasMoreData;

- (void)loadMoreData;

@end

@interface HFRefreshController : NSObject

- (instancetype)initWithScrollView:(UIScrollView *)scrollView viewDelegate:(id <HFRefreshControllerDelegate>)delegate;

@property (nonatomic, getter=isLoading) BOOL loading;

- (void)endRefreshing;

@end
