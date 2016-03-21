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
#import "GoodsDetailViewController.h"
#import "TKUserCenter.h"


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
        
        if(ack.sucess)
        {
            TK_RewardListForBuyerAck * ackData = (TK_RewardListForBuyerAck *)ack;
            for (RewardData *d in ackData.data) {
                [section.rowsData addObject:[TKRewardCellModel transformFromRewardData:d]];
            }
            [weakSelf setDefaultSection:section];
            [weakSelf.mTableView reloadData];
        }
        [weakSelf stopRefresh];
    }];
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
    TKRewardCellModel * cellData = (TKRewardCellModel *)[self.defaultSection.rowsData objectAtIndex:indexPath.row];
    RewardData * rowData  = cellData.ackData;
    GoodsDetailViewController *vc = [[GoodsDetailViewController alloc]initWithNibName:@"GoodsDetailViewController" bundle:nil];
    vc.data = [rowData copy];
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
    
    cell.priceText.text =  [NSString stringWithFormat:@"%0.2f",rowData.rewardPrice.floatValue/100];
    [cell.timeCountView setSecondsUTC:rowData.releaseTime.doubleValue/1000];
    [cell.infoIconBtn1 setTitle:rowData.brandName forState:UIControlStateNormal];
    [cell.infoIconBtn2 setTitle:rowData.categoryName forState:UIControlStateNormal];
    cell.delegate = self;
    cell.indexPath = indexPath;
    
}


-(void)setTableCellStyle:(TKRewardCell *)cell
{
    TKBorder(cell.btnLeft);
    TKBorder(cell.btnRight);
    
}



- (void)beginPullDownRefreshing
{
    [self tkLoadDefaultData];

}

- (void)beginPullUpLoading
{
    [self tkLoadDefaultData];
}

-(BOOL)hasRefreshFooterView
{
    return YES;
}


#pragma mark  TKRewardCellDelegate 

-(void)onAcceptBtnClick:(NSIndexPath *)indexPath
{
    TKRewardCellModel * cellData = (TKRewardCellModel *)[self.defaultSection.rowsData objectAtIndex:indexPath.row];
    RewardData * rowData  = cellData.ackData;
    [[TKProxy proxy].mainProxy accept:[[TKUserCenter instance] getUser].userId rewardId:rowData.id needDays:3 withBlock:^(HF_BaseAck * ack)
    {
        DDLogInfo(@"ack %@",ack);
    }];
}

-(void)onReleaseBtnClick:(NSIndexPath *)indexPath
{
    TKRewardCellModel * cellData = (TKRewardCellModel *)[self.defaultSection.rowsData objectAtIndex:indexPath.row];
    RewardData * rowData  = cellData.ackData;
    [[TKProxy proxy].mainProxy releaseReward:rowData.id source:0 withBlock:^(HF_BaseAck *ack) {
        DDLogInfo(@"ack %@",ack);
    }];
}


@end
