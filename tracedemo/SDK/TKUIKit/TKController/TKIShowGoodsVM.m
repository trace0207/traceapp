//
//  TKIShowGoodsVM.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKIShowGoodsVM.h"

@implementation TKIShowGoodsVM


-(void)tkLoadDefaultData
{
    
    TKTableSectionM * section = [[TKTableSectionM alloc] init];
    [section.rowsData removeAllObjects];
    section.sectionHeadHeight = 1;
    section.sectionFootHeight = 1;
    
    section.rowHeight = 100;
    
    for(int i=0;i<10;i++)
    {
        TKTableViewRowM * row = [[TKTableViewRowM alloc] init];
        [section.rowsData addObject:row];
    }
    [self setDefaultSection:section];
}




- (void)beginPullDownRefreshing
{
    [self tkLoadDefaultData];
    [self.mTableView reloadData];
    
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:0.3];
}

- (void)beginPullUpLoading
{
    [self tkLoadDefaultData];
    [self.mTableView reloadData];
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:0.3];
}

-(BOOL)hasRefreshFooterView
{
    return YES;
}

@end
