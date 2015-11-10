//
//  BaseTableView.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BaseTableViewDelegate <NSObject>
@optional
- (void)pullDownAction;

- (void)pullUpAction;

@end


@interface BaseTableView : UITableView

@property(nonatomic)BOOL bPullDownRefreash;
@property(nonatomic)BOOL bPullUpRefreash;
@property(nonatomic,weak)id<BaseTableViewDelegate>baseDelegate;

//如果需要一开始初始化进行网络请求，你调用此方法
- (void)startRequest;

//重置是否有上拉刷新
- (void)resetFooterRefreash:(BOOL)bFooter;

/**
 *  停止加载
 */
- (void)endLoadMore;

/**
 *  停止刷新
 */
- (void)endRefreash;
@end
