//
//  TKIRewardVM.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/16.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKIRewardVM.h"
#import "TKRewardCell.h"
#import "UIColor+TK_Color.h"
#import "TKRewardDetailViewController.h"
#import "AppDelegate.h"
#import "TKUITools.h"
#import "UIColor+TK_Color.h"
#import "TK_RewardListForBuyerAck.h"



#define IN_REWARDING  101

@interface TKIRewardVM()<TKRewardCellDelegate>
{
    
    NSInteger nowPage;
    
    NSMutableArray <RewardData> * dataList;
    TKTableSectionM * section;
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       @end

@implementation TKIRewardVM



-(instancetype)init
{
    self = [super init];
    nowPage = 0; // 开始页 是  0
    dataList = [[NSMutableArray<RewardData> alloc] init];
    section = [[TKTableSectionM alloc] init];
    section.sectionFootHeight = 0.1;
    section.sectionHeadHeight = 0.1;
    section.rowHeight = 304;
    return self;
}

-(void)defaultViewSetting
{
     self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


-(void)tkLoadDefaultData
{
    WS(weakSelf)
    [[TKProxy proxy].mainProxy getMyRewardList:self.category.categoryId page:nowPage rewardStatus:IN_REWARDING withBlock:^(HF_BaseAck *ack) {
        
//        DDLogInfo(@"%@",ack);
        
        if(ack.sucess)
        {
            TK_RewardListForBuyerAck * ackData = (TK_RewardListForBuyerAck *)ack;
//            [dataList removeAllObjects];
//            [dataList addObjectsFromArray:ackData.data];
            for (RewardData *d in ackData.data) {
                [section.rowsData addObject:[TKRewardCellModel transformFromRewardData:d]];
            }
            [weakSelf setDefaultSection:section];
            [weakSelf.mTableView reloadData];
        }
        [weakSelf stopRefresh];
    }];
    
    
    
    
    
//    for (int i = 0; i<20;i++) {
//        
//        TKRewardCellModel * rowM = [[TKRewardCellModel alloc] init];
//        rowM.userName = @"李小龙";
//        rowM.pic1Address = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
//        rowM.pic2Address = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_084_X.jpg";
//        
//        rowM.headAddress = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_084_X.jpg";
//        rowM.contentInfo = @"急求这款包包，意大利产，Prada包包，看图片";
//        [section.rowsData addObject:rowM];
//    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TKRewardCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TKRewardCell"];
//    DDLogInfo(@"get rewardcell view  cell is nill =  %d",cell == nil);
    if(!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TKRewardCell" owner:self options:nil].firstObject;
        [self setTableCellStyle:cell];
    }
    
    [self fillTableCell:cell withDataIndex:indexPath];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    TKRewardDetailViewController *vc = [[TKRewardDetailViewController alloc] init];
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
    
}


-(void)fillTableCell:(TKRewardCell *)cell withDataIndex:(NSIndexPath *)indexPath
{
    
    TKRewardCellModel * cellData = (TKRewardCellModel *)[self.defaultSection.rowsData objectAtIndex:indexPath.row];
    RewardData * rowData  = cellData.ackData;
    cell.userName.text = rowData.userNickName;
    TKSetLoadingImageView(cell.pic1, rowData.picAddr1);
    TKSetLoadingImageView(cell.pic2, rowData.picAddr2);
    TKSetHeadImageView(cell.headImageView,rowData.userHeaderUrl);
    cell.contentInfo.text = rowData.content;
    cell.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    cell.indexPath = indexPath;
    
}


-(void)setTableCellStyle:(TKRewardCell *)cell
{
//    cell.contentInfo.textColor = [UIColor tkMainTextColorForDefaultBg];
//    cell.userName.textColor = [UIColor tkLightGrayTextColor];
//    cell.btnLeft.backgroundColor = [UIColor tkThemeColor1];
//    cell.btnRight.backgroundColor = [UIColor tkLightGrayTextColor];
//    [cell.btnRight setTitleColor:[UIColor tkMainTextColorForDefaultBg] forState:UIControlStateNormal];
//    [cell.btnLeft setTitleColor:[UIColor tkMainTextColorForDefaultBg] forState:UIControlStateNormal];
//    [TKUITools setRoudBorderForView:cell.btnLeft  borderColor:[UIColor tkThemeColor1] radius:2 borderWidth:1];
    TKBorder(cell.btnLeft);
    TKBorder(cell.btnRight);
    
}



- (void)beginPullDownRefreshing
{
    [self tkLoadDefaultData];
//    [self.mTableView reloadData];
    // tableView.separatorStyle = UITableViewCellSeparatorStyleNone
//    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:0.3];
}

- (void)beginPullUpLoading
{
    [self tkLoadDefaultData];
//    [self.mTableView reloadData];
//    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:0.3];
}

-(BOOL)hasRefreshFooterView
{
    return YES;
}


#pragma mark  TKRewardCellDelegate 

-(void)onAcceptBtnClick:(NSIndexPath *)indexPath
{
    [[TKProxy proxy].mainProxy accept:@"1" rewardId:@"2" needDays:3 withBlock:^(HF_BaseAck * ack)
    {
        DDLogInfo(@"ack %@",ack);
    }];
}

-(void)onReleaseBtnClick:(NSIndexPath *)indexPath
{
    [[TKProxy proxy].mainProxy releaseReward:@"1" source:1 withBlock:^(HF_BaseAck *ack) {
        DDLogInfo(@"ack %@",ack);
    }];
}


@end
