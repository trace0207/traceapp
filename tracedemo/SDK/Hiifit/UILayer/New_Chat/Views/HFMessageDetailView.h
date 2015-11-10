//
//  HFMessageDetailView.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFMessageCell.h"

@protocol HFMessageDetailViewDelegate<NSObject>
@optional
- (void)loadPullDownRefreashData;

- (void)loadPullUpRefreshData;

- (void)detailMessageActionAtIndex:(NSInteger)index withType:(MessageType)type;

- (void)headPageJump:(NSInteger)userId;

@end

@interface HFMessageDetailView : UIView

@property(nonatomic,weak)id<HFMessageDetailViewDelegate>delegate;
@property(nonatomic,strong)UITableView * mTableView;
@property (nonatomic, assign) NSInteger currentPage;

//init
- (instancetype)initWithFrame:(CGRect)frame withTableViewStyle:(UITableViewStyle)style;

//刷新全局数据
- (void)reloadData:(NSArray *)datas withType:(MessageType)type;

//开始请求数据
- (void)startRequest;

- (void)endRefreash;

@end
