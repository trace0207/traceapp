//
//  TKIShowGoodsDetailVM.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/16.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKIShowGoodsDetailVM.h"
#import "TKShowGoodsCell.h"

@implementation TKIShowGoodsDetailVM





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        TKShowGoodsCell * cell = [[NSBundle mainBundle] loadNibNamed:@"TKShowGoodsCell" owner:self options:nil].firstObject;
        return cell;
        
    }else
    {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        return 350;
    }
    else
    {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}


@end
