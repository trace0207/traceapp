//
//  TKShowGoodsListVM.m
//  tracedemo
//
//  Created by cmcc on 16/3/3.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKShowGoodsListVM.h"
#import "TKISHowGoodsCell.h"

@implementation TKShowGoodsListVM



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    TKISHowGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TKISHowGoodsCell"];
    if(!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TKISHowGoodsCell" owner:self options:nil].firstObject;
        [self setTableCellStyle:cell];
    }
    
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  350.0f;
}



-(void)setTableCellStyle:(TKISHowGoodsCell*)cell
{
    
}





@end
