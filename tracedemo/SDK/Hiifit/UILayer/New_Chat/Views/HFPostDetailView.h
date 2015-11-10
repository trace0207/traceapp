//
//  BasePostDetailView.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/21.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BasePostDetailViewDelegate <NSObject>
@optional
- (CGFloat)heightForCustomHeaderView;

- (UIView *)viewForCustomHeaderView;

- (void)loadPullDownRefreashData;

- (void)loadPullUpMoreData;

@end

@class PostDetailData;
@interface HFPostDetailView : UIView
{
    UITableView * mTableView;
    
    BOOL  bSupportPullUpLoad;         //是否支持上啦加载
    
    BOOL  bNeedPushUserCenter;        //是否需要跳转到主页
}
@property(nonatomic,weak)id<BasePostDetailViewDelegate>delegate;
@property(nonatomic,strong)UITableView * mTableView;
@property(nonatomic)BOOL  bSupportPullUpLoad;
@property(nonatomic)BOOL  bNeedPushUserCenter;
@property(nonatomic)BOOL  showDeleteBtn;
@property(nonatomic)NSInteger pageSize;
- (instancetype)initWithFrame:(CGRect)frame withTableViewStyle:(UITableViewStyle)style;

//停止下拉刷新
- (void)endRefreash;
//停止上拉加载
- (void)endLoad;
//刷新全局数据
- (void)reloadData:(NSArray *)datas;

- (void)startRequest;

- (void)updatePriseOrCommentForPostData:(PostDetailData *)data;
@end
