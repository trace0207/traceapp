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


@interface TKIRewardVM()
{
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       @end

@implementation TKIRewardVM



-(void)tkLoadDefaultData
{
    
    TKTableSectionM * section = [[TKTableSectionM alloc] init];
    
    
    section.sectionFootHeight = 0.1;
    section.sectionHeadHeight = 0.1;
    section.rowHeight = 260;
    
    
    for (int i = 0; i<20;i++) {
        
        TKRewardCellModel * rowM = [[TKRewardCellModel alloc] init];
        rowM.userName = @"李小龙";
        rowM.pic1Address = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
        rowM.pic2Address = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_084_X.jpg";
        
        rowM.headAddress = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_084_X.jpg";
        rowM.contentInfo = @"急求这款包包，意大利产，Prada包包，看图片";
        [section.rowsData addObject:rowM];
    }
    
    
    [self setDefaultSection:section];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TKRewardCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TKRewardCell"];
    
    DDLogInfo(@"get rewardcell view  cell is nill =  %d",cell == nil);
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
}


-(void)fillTableCell:(TKRewardCell *)cell withDataIndex:(NSIndexPath *)indexPath
{
    
   TKRewardCellModel * rowData = (TKRewardCellModel *)[self.defaultSection.rowsData objectAtIndex:indexPath.row];
    
    cell.userName.text = rowData.userName;
    TKSetLoadingImageView(cell.pic1, rowData.pic1Address);
    TKSetLoadingImageView(cell.pic2, rowData.pic2Address);
    TKSetHeadImageView(cell.headImageView,rowData.headAddress);
    
    cell.contentInfo.text = rowData.contentInfo;
    
    cell.backgroundColor = [UIColor clearColor];
    
}


-(void)setTableCellStyle:(TKRewardCell *)cell
{
    cell.contentInfo.textColor = [UIColor tkMainTextColorForDefaultBg];
    cell.userName.textColor = [UIColor tkLightGrayTextColor];
    cell.btnLeft.backgroundColor = [UIColor tkThemeColor1];
    cell.btnRight.backgroundColor = [UIColor tkLightGrayTextColor];
    [cell.btnRight setTitleColor:[UIColor tkMainTextColorForDefaultBg] forState:UIControlStateNormal];
    [cell.btnLeft setTitleColor:[UIColor tkMainTextColorForDefaultBg] forState:UIControlStateNormal];
}



@end
