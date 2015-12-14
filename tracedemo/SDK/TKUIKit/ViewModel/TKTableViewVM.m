//
//  TKTableViewVM.m
//  tracedemo
//
//  Created by cmcc on 15/12/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKTableViewVM.h"


@interface TKTableViewVM()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation TKTableViewVM



-(NSMutableArray *)sectionData
{
    if(!_sectionData)
    {
        _sectionData = [[NSMutableArray alloc]init];//[[TKTableSectionM alloc] init];
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
    if(self.sectionData.count == 0)
    {
        [self.sectionData addObject:[[TKTableSectionM alloc] init]];
    }
    return [self.sectionData objectAtIndex:0];
}



#pragma  mark  UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sectionData objectAtIndex:section].rowsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TK_SettingCell * cell = [TK_SettingCell loadDefaultTextType:self];
    cell.rightLabel.hidden = YES;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionData.count;;
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

@end
