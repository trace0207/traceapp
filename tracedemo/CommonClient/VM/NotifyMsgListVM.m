//
//  NotifyMsgListVM.m
//  tracedemo
//
//  Created by cmcc on 16/4/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "NotifyMsgListVM.h"
#import "TKProxy.h"
#import "NotifyMsgTableCell.h"
#import "TK_BoxListAck.h"

@implementation NotifyMsgListVM


-(void)tkLoadDefaultData
{
    [[TKProxy proxy].mainProxy tkGetNotifyMsgList:self.boxId withBlock:^(HF_BaseAck *ack) {
        
        DDLogInfo(@"%@",ack);
        if(ack.sucess)
        {
            [self.defaultSection.rowsData removeAllObjects];
            TK_BoxListAck * ackData = (TK_BoxListAck *)ack;
            for (BoxListData * box in ackData.data) {
                TKTableViewRowM * row =  [[TKTableViewRowM alloc] init];
                row.rowData = box;
                [self.defaultSection.rowsData addObject:row];
                
            }
            
            [self.mTableView reloadData];
        }
        else
        {
            [[HFHUDView shareInstance] ShowTips:@"获取消息列表失败" delayTime:1.0 atView:nil];
        }
        
    }];
}

-(void)defaultViewSetting
{
    self.defaultSection.rowHeight = 80;
    self.defaultSection.sectionHeadHeight = 0.1;
//    [self.mTableView registerClass:[NotifyMsgTableCell class] forCellReuseIdentifier:@"NotifyMsgTableCell"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotifyMsgTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NotifyMsgTableCell"];
    if(cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NotifyMsgTableCell" owner:self options:nil].firstObject;
    }
    TKTableViewRowM * rowM = [self.defaultSection.rowsData objectAtIndex:indexPath.row];
    BoxListData * box =  (BoxListData *)rowM.rowData;
    cell.content.text = box.boxContent;
    cell.timeLabel.text = [NSDate stringWithTimeUTC:box.createTime/1000];
    return cell;
}


@end
