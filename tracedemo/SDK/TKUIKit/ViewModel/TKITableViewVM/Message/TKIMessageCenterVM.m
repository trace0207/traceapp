//
//  TKIMessageCenterVM.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/18.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKIMessageCenterVM.h"
#import "TKMessageListIItemCell.h"
#import "TKMessageChatViewController.h"
#import "TKIBaseNavWithDefaultBackVC.h"

@implementation TKIMessageCenterVM



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TKMessageListIItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TKMessageListIItemCell"];
    if(!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TKMessageListIItemCell" owner:self options:nil].firstObject;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKMessageChatViewController * chat = [[TKMessageChatViewController alloc] init];
    TKIBaseNavWithDefaultBackVC * vc = [[TKIBaseNavWithDefaultBackVC alloc] init];
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
}


-(void)tkLoadDefaultData
{
    [self.defaultSection.rowsData removeAllObjects];
    self.defaultSection.rowHeight = 100;
    self.defaultSection.sectionHeadHeight = 0.01f;
    self.defaultSection.sectionFootHeight = 0.01f;
    for(int i =0;i<10;i++)
    {
        TKTableViewRowM * row = [[TKTableViewRowM alloc] init];
        row.isEmptyData = YES;
        [self.defaultSection.rowsData addObject:row];
    }
    [self.mTableView reloadData];
}

@end
