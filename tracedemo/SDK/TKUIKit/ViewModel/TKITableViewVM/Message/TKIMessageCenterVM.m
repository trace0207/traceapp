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
#import "TK_MessageCenterArg.h"
#import "TKUserCenter.h"
#import "TK_MessageCenterAck.h"
@implementation TKIMessageCenterVM



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TKMessageListIItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TKMessageListIItemCell"];
    if(!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TKMessageListIItemCell" owner:self options:nil].firstObject;
    }
    TKMessageData *data = [self.defaultSection.rowsData objectAtIndex:indexPath.row];
    [cell setContentData:data];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    //TKMessageChatViewController * chat = [[TKMessageChatViewController alloc] init];
    TKChatViewController * vc = [[TKChatViewController alloc] init];
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
}


-(void)tkLoadDefaultData
{
    
    TK_MessageCenterArg * arg = [[TK_MessageCenterArg alloc] init];
    arg.pageOffset = 0;
    arg.pageSize = 20;
    arg.fromUserRole = @"1";
#if B_Client == 1
    arg.fromUserRole = @"0";
#endif
    arg.fromUserId = [TKUserCenter instance].getUser.userId;
    arg.toUserId = @"3";
    arg.toUserRole = @"1";
    WS(weakSelf)
    [[TKProxy proxy].mainProxy getMessageCenter:arg
                                      withBlock:^(HF_BaseAck *ack) {
                                          
                                          if(ack.sucess)
                                          {
                                              [weakSelf onBoxAckBack:(TK_MessageCenterAck *)ack];
                                          }else
                                          {
                                              [[HFHUDView shareInstance] ShowTips:@"获取消息盒子数据失败" delayTime:1.0 atView:nil];
                                          }
                                          
                                          
                                      }];
    
    [self.defaultSection.rowsData removeAllObjects];
}


-(void)onBoxAckBack:(TK_MessageCenterAck *)ack
{
    [self.defaultSection.rowsData removeAllObjects];
    MsgBoxAckData * data = ack.data;
    TKMessageData * item = [[TKMessageData alloc] init];
    item.boxItemData = data.MSG_ORDER;
    [self.defaultSection.rowsData addObject:item];
    
    TKMessageData * item1 = [[TKMessageData alloc] init];
    item1.boxItemData = data.MSG_PAY;
    [self.defaultSection.rowsData addObject:item1];
    
    TKMessageData * item2 = [[TKMessageData alloc] init];
    item2.boxItemData = data.MSG_SOCIAL;
    [self.defaultSection.rowsData addObject:item2];
    
    
    for (MSGData * im in data.MSG_IM) {
        TKMessageData * msgItem = [[TKMessageData alloc] init];
        msgItem.msgData = im;
        [self.defaultSection.rowsData addObject:msgItem];
    }
    [self.mTableView reloadData];
}



-(void)defaultViewSetting
{
    self.defaultSection.rowHeight = 62;
    self.defaultSection.sectionHeadHeight = 0.01f;
    self.defaultSection.sectionFootHeight = 0.01f;
}

@end
