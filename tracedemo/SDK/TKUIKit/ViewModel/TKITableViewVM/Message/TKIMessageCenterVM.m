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
#import "TKChatViewController.h"
@implementation TKIMessageCenterVM



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TKMessageListIItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TKMessageListIItemCell"];
    if(!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TKMessageListIItemCell" owner:self options:nil].firstObject;
    }
    TKTableViewRowM *data = [self.defaultSection.rowsData objectAtIndex:indexPath.row];
    [cell setContentData:(TKMessageData *)data.rowData];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TKMessageChatViewController * chat = [[TKMessageChatViewController alloc] init];
    TKChatViewController * vc = [[TKChatViewController alloc] init];
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
}


-(void)tkLoadDefaultData
{
    [self.defaultSection.rowsData removeAllObjects];
    self.defaultSection.rowHeight = 62;
    self.defaultSection.sectionHeadHeight = 0.01f;
    self.defaultSection.sectionFootHeight = 0.01f;
    
    TKMessageData *data = [[TKMessageData alloc]init];
    data.type = TKMessageTypeForgive;
    data.name = @"弃单通知";
    data.describle = @"您的保证金中，已扣掉100元支付给了您的买家。";
    data.secondsUTC = 33434545;
    TKTableViewRowM * row = [[TKTableViewRowM alloc] init];
    row.rowData = data;
    [self.defaultSection.rowsData addObject:row];
    
    TKMessageData *data1 = [[TKMessageData alloc]init];
    data1.type = TKMessageTypeStatement;
    data1.name = @"结算通知";
    data1.describle = @"平台已支付给您60%的尾款，快去看看吧！";
    data1.secondsUTC = 3343454335;
    TKTableViewRowM * row1 = [[TKTableViewRowM alloc] init];
    row1.rowData = data1;
    [self.defaultSection.rowsData addObject:row1];
    
    TKMessageData *data2 = [[TKMessageData alloc]init];
    data2.type = TKMessageTypePraise;
    data2.name = @"点赞提醒";
    data2.describle = @"您的买家小米花花卷给您的晒单点赞啦！";
    data2.secondsUTC = 33434545;
    TKTableViewRowM * row2 = [[TKTableViewRowM alloc] init];
    row2.rowData = data2;
    [self.defaultSection.rowsData addObject:row2];
    
    TKMessageData *data3 = [[TKMessageData alloc]init];
    data3.type = TKMessageTypeDefault;
    data3.name = @"小猪猪";
    data3.describle = @"那么这个单子我们该怎么处理呢？总不能让我一个人承担全部的费用吧，这样怎么玩？";
    data3.secondsUTC = 33434545;
    TKTableViewRowM * row3 = [[TKTableViewRowM alloc] init];
    row3.rowData = data3;
    [self.defaultSection.rowsData addObject:row3];
    
    [self.mTableView reloadData];
}

@end
