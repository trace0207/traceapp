//
//  TKTableViewVM.h
//  tracedemo
//
//  Created by cmcc on 15/12/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTableSectionM.h"
#import "TKTableViewRowM.h"
#import "TK_SettingCell.h"


@protocol TKTableViewVMDelegate <NSObject>

@optional
-(void)onPull;
-(void)onTableItemSelect:(NSIndexPath *)indexPath withItemData:(id)data;

@end




@interface TKTableViewVM : NSObject
@property (nonatomic,strong) UITableView * mTableView;
@property (nonatomic,strong) UIView * pullRefreshView;
@property (nonatomic,strong) NSMutableArray<__kindof TKTableSectionM *> * sectionData;
@property (weak,nonatomic) id<TKTableViewVMDelegate> tkDelegate;
@property (assign,nonatomic)  BOOL logTrace;


@property (nonatomic,strong) TKTableSectionM *defaultSection;


-(void)defaultViewSetting;

/**
 *  初始化默认的table 需
 *  需要在 add到view之后，再调用 tkUpdateViewConstraint
 *
 *  @return self
 */
-(instancetype)initWithDefaultTable;
- (instancetype)initTableWithStyle:(UITableViewStyle)tableStyle;
/**
 *  初始化可刷新的table 需
 *  需要在 add到view之后，再调用 tkUpdateViewConstraint
 *
 *  @return self
 */
-(instancetype)initWithFreshAbleTable;
- (instancetype)initFreshTableWtihStyle:(UITableViewStyle)tableStyle;
/**
 *  初始化默认的table 带 frame
 *
 *  @return self
 */
-(instancetype)initDefaultTableWithFrame:(CGRect)frame;
/**
 *  初始化可刷新的table 带 frame
 *
 *  @return self
 */
-(instancetype)initFreshAbleTableWithFrame:(CGRect)frame;

-(void)tkLoadDefaultData;
// 更新约束
-(void)tkUpdateViewConstraint;

-(void)showTipsView:(UIView *)view;
-(void)hidTips;


#pragma  mark  UITableViewDelegate && UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;


///////////////////////////--下拉刷新相关方法-//////////////////////////////////////////////
/**
 *  外部手动启动下拉加载的方法，例如 第一次进来 tableview自动下拉刷新
 */
- (void)startPullDownRefreshing;

- (void)beginPullDownRefreshing;

- (void)beginPullUpLoading;

-(void)stopRefresh;

- (BOOL)hasRefreshFooterView;





@end
