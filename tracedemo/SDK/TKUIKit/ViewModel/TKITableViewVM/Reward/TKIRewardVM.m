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
#import "TKAlertView.h"

#define IN_REWARDING  101

@interface TKIRewardVM()<TKRewardCellDelegate>
{
    
    NSInteger nowPage;
    
    NSMutableArray <RewardData> * dataList;
    TKTableSectionM * section;
    BOOL isMore;
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
    WS(weakSelf);
    [self hidTips];
    
//    [[TKProxy proxy].mainProxy getRewardList:@"" brandId:@"" page:1 type:1 rewardStatus:1 withBlock:nil];
    
    NSInteger page = isMore?nowPage +1:nowPage;
    [[TKProxy proxy].mainProxy getRewardList:self.category.categoryId
                                        brandId:self.brand.brandId
                                        page:page
                                        type:self.rewardPageType
                                rewardStatus:101
                                   withBlock:^(HF_BaseAck *ack) {
                                       if(ack.sucess)
                                       {
                                            TK_RewardListForBuyerAck * ackData = (TK_RewardListForBuyerAck *)ack;
                                           if(!isMore)
                                           {
                                               [section.rowsData removeAllObjects];
                                           }
                                           else
                                           {
                                               isMore = false;
                                           }
                                          
                                           for (RewardData *d in ackData.data) {
                                               [section.rowsData addObject:[TKRewardCellModel transformFromRewardData:d]];
                                           }
                                           [weakSelf setDefaultSection:section];
                                           [weakSelf.mTableView reloadData];
                                       }
                                       
                                       
                                       [weakSelf stopRefresh];
                                       
                                       if(nowPage == 0 && weakSelf.defaultSection.rowsData.count == 0)
                                       {
                                           [weakSelf showTipsView:[TKUITools getListViewEmptyTip]];
                                       }
                                   }];
    
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKRewardCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TKRewardCell"];
//    [cell isEqual:<#(id)#>]
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
    TKRewardCellModel * cellData = [self.defaultSection.rowsData objectAtIndex:indexPath.row];
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
    [cell.timeCountView beginCutDownFromSeconds:rowData.clock.integerValue/1000];
    [cell.infoIconBtn1 setTitle:rowData.brandName forState:UIControlStateNormal];
    [cell.infoIconBtn2 setTitle:rowData.categoryName forState:UIControlStateNormal];
    cell.delegate = self;
    cell.indexPath = indexPath;
    
}


-(void)setTableCellStyle:(TKRewardCell *)cell
{
    TKBorder(cell.btnLeft);
    TKBorder(cell.btnRight);
    cell.headImageView.roundValue = 2.0;
    
}



- (void)beginPullDownRefreshing
{
    nowPage = 0;
    isMore = false;
    [self tkLoadDefaultData];

}

- (void)beginPullUpLoading
{
    isMore = YES;
    [self tkLoadDefaultData];
}

-(BOOL)hasRefreshFooterView
{
    return self.defaultSection.rowsData.count >= 20;
}


#pragma mark  TKRewardCellDelegate 

-(void)onAcceptBtnClick:(NSIndexPath *)indexPath
{
    
    TKRewardCellModel * cellData = (TKRewardCellModel *)[self.defaultSection.rowsData objectAtIndex:indexPath.row];
    RewardData * rowData  = cellData.ackData;
    [TKAlertView showDeliveryTime:[rowData.requireDay intValue] WithBlock:^(NSInteger buttonIndex, int deliveryTime) {
        if (buttonIndex == 1) {
            [[TKProxy proxy].mainProxy accept:[[TKUserCenter instance] getUser].userId rewardId:rowData.id needDays:deliveryTime withBlock:^(HF_BaseAck * ack)
             {
//                 DDLogInfo(@"ack %@",ack);
                 
                 if(ack.sucess)
                 {
                     [TKAlertView showSuccessWithTitle:@"抢单成功" withMessage:nil commpleteBlock:nil cancelTitle:nil determineTitle:@"确定"];
                 }
                 else
                 {
                     [TKAlertView showFailedWithTitle:@"抢单失败" withMessage: ack.msg commpleteBlock:nil cancelTitle:nil determineTitle:@"确定"];
                 }
                 
             }];
        }
    }];
    
    
}

-(void)onReleaseBtnClick:(NSIndexPath *)indexPath
{
   
    
    
    TKRewardCellModel * cellData = (TKRewardCellModel *)[self.defaultSection.rowsData objectAtIndex:indexPath.row];
    RewardData * rowData  = cellData.ackData;
    
    [TKAlertView showAltertWithTitle:@"确定不接该笔悬赏？" withMessage:@"释放后，您可以在悬赏状态切换位置找到“已释放的悬赏”。" commpleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [[TKProxy proxy].mainProxy releaseReward:rowData.id source:0 withBlock:^(HF_BaseAck *ack) {
                if(ack.sucess)
                {
                    [TKAlertView showSuccessWithTitle:@"悬赏已释放" withMessage:nil commpleteBlock:nil cancelTitle:nil determineTitle:@"确定"];
                }
                else
                {
                    [TKAlertView showFailedWithTitle:@"释放失败" withMessage: ack.msg commpleteBlock:nil cancelTitle:nil determineTitle:@"确定"];
                }
            }];
        }
    } cancelTitle:@"取消" determineTitle:@"不接"];
    
    
}


@end
