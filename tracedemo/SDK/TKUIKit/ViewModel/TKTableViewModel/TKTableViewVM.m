//
//  TKTableViewVM.m
//  tracedemo
//
//  Created by cmcc on 15/12/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKTableViewVM.h"
#import "CLLRefreshHeadController.h"


@interface TKTableViewVM()<UITableViewDataSource,UITableViewDelegate,CLLRefreshHeadControllerDelegate>
{
    CLLRefreshHeadController * refreshController;
    UIView * tipsView;
}

@end
@implementation TKTableViewVM



-(instancetype)init
{
    self = [super init];
    _logTrace = NO;
    return self;
}


-(instancetype)initWithDefaultTable
{
    self = [self initTableWithStyle:UITableViewStyleGrouped];
    
    return self;
}

- (instancetype)initTableWithStyle:(UITableViewStyle)tableStyle
{
    self = [self init];
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:tableStyle];
    TKSetTableView(_mTableView, self, self);
    [self defaultViewSetting];
    return self;
}


-(instancetype)initWithFreshAbleTable
{
    self = [self initFreshTableWtihStyle:UITableViewStyleGrouped];
    return self;
}

- (instancetype)initFreshTableWtihStyle:(UITableViewStyle)tableStyle
{
    self = [self init];
    _pullRefreshView = [[UIView alloc]init];
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:tableStyle];
    TKSetTableView(_mTableView, self, self);
    [_pullRefreshView addSubview:_mTableView];
    refreshController = [[CLLRefreshHeadController alloc]initWithScrollView:_mTableView viewDelegate:self];
    [self defaultViewSetting];
    return self;
}


-(void)defaultViewSetting
{
    
}


/**
 *  初始化默认的table 带 frame
 *
 *  @return self
 */
-(instancetype)initDefaultTableWithFrame:(CGRect)frame
{
    self = [self init];
    _mTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    TKSetTableView(_mTableView, self, self);
    [self defaultViewSetting];
    return self;
}
/**
 *  初始化可刷新的table 带 frame
 *
 *  @return self
 */
-(instancetype)initFreshAbleTableWithFrame:(CGRect)frame
{
    self = [self init];
    _pullRefreshView = [[UIView alloc]initWithFrame:frame];
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
    TKSetTableView(_mTableView, self, self);
    [_pullRefreshView addSubview:_mTableView];
    refreshController = [[CLLRefreshHeadController alloc]initWithScrollView:_mTableView viewDelegate:self];
    [self defaultViewSetting];
    return self;
}



-(void)tkUpdateViewConstraint
{

    if(_pullRefreshView)
    {
        [_pullRefreshView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_pullRefreshView.superview);
        }];
    }
    
    [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_mTableView.superview);
    }];

}


-(void)showTipsView:(UIView *)view
{
    if(_pullRefreshView)
    {
        if(tipsView)
        {
            [tipsView removeFromSuperview];
        }
        tipsView = view;
        [_pullRefreshView addSubview:tipsView];
        [tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_pullRefreshView);
        }];
    }
}

-(void)hidTips
{
    if(tipsView)
    {
        [tipsView removeFromSuperview];
        tipsView = nil;
    }
}


-(void)tkLoadDefaultData
{
    [self.defaultSection.rowsData removeAllObjects];
    for(int i =0;i<10;i++)
    {
        TKTableViewRowM * row = [[TKTableViewRowM alloc] init];
        row.isEmptyData = YES;
        [self.defaultSection.rowsData addObject:row];
    }
    [self.mTableView reloadData];

}





-(NSMutableArray *)sectionData
{
    if(!_sectionData)
    {
        _sectionData = [[NSMutableArray alloc]init];//[[TKTableSectionM alloc] init];
        [_sectionData addObject:[[TKTableSectionM alloc] init]];
    }
    return _sectionData;
}


-(UITableView *)mTableView
{
    if(!_mTableView)
    {
        _mTableView = [[UITableView alloc] initWithFrame:TKMainViewFream style:UITableViewStyleGrouped];
        TKSetTableView(_mTableView, self, self);
    }
    return _mTableView;
}


-(TKTableSectionM *)defaultSection
{
//    if(self.sectionData.count == 0)
//    {
//        [self.sectionData addObject:[[TKTableSectionM alloc] init]];
//    }
    return [self.sectionData objectAtIndex:0];
}

-(void)setDefaultSection:(TKTableSectionM *)defaultSection
{
    [self.sectionData removeAllObjects];
    [self.sectionData addObject:defaultSection];
}


#pragma  mark  UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TKTableSectionM * tkSection = [self.sectionData objectAtIndex:section];
    NSInteger count =  tkSection.rowsData.count;
    
    if(_logTrace)
    {
        DDLogInfo(@"\n at VM %@   sections == %ld  row == %ld",NSStringFromClass([self class]),section,count);
    }
    
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TK_SettingCell * cell = [TK_SettingCell loadDefaultTextType:self];
    cell.label2.hidden = YES;
    if([[self.sectionData objectAtIndex:indexPath.section].rowsData objectAtIndex:indexPath.row].isEmptyData)
    {
        cell.label1.text = @"还未初始化数据的TableView";
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKTableSectionM * section =  [self.sectionData objectAtIndex:indexPath.section];
    CGFloat rowHeight =  [section.rowsData objectAtIndex:indexPath.row].rowHeight;
    if(rowHeight == 0)
    {
        return section.rowHeight;
    }
    return rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return [self.sectionData objectAtIndex:section].sectionHeadHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return [self.sectionData objectAtIndex:section].sectionFootHeight;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self.sectionData objectAtIndex:section].tkHeadView;
}   // custom view for header. will be adjusted to default or specified header height
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self.sectionData objectAtIndex:section].tkFootView;
}  // custom view for


- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}


#pragma mark CLLRefreshHeadControllerDelegate
- (BOOL)hasRefreshFooterView
{
    return false;
}

- (void)beginPullDownRefreshing
{
    [self tkLoadDefaultData];
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1.0];
}

- (void)beginPullUpLoading
{
   [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1.0];
}


- (void)startPullDownRefreshing
{
    if(refreshController)
    {
        [refreshController startPullDownRefreshing];
        [_mTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];// 滚动到顶部
    }
   
}


- (CLLRefreshViewLayerType)refreshViewLayerType
{
    return CLLRefreshViewLayerTypeOnScrollViews;
}


-(void)stopRefresh
{
    if(refreshController)
    {
        [refreshController endPullDownRefreshing];
        [refreshController endPullUpLoading];
    }
}

@end
