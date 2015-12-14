//
//  TKUserDetailInfoTableVM.m
//  tracedemo
//
//  Created by cmcc on 15/12/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKUserDetailInfoTableVM.h"
#import "UIColor+TK_Color.h"

@interface TKUserDetailInfoTableVM()
{

    NSString * address;
}

@end
@implementation TKUserDetailInfoTableVM


-(instancetype)init
{
    self = [super init];
    [self userDetailInitData];
    
    address = @"浙江省、杭州市、西湖区 西溪路555号";
    
    return self;
}


-(void)userDetailInitData
{
    NSMutableArray * data = [[NSMutableArray alloc] init];
    
    TKTableSectionM * s0 = [[TKTableSectionM alloc] init];
    TKTableViewRowM * r0 = [[TKTableViewRowM alloc] init];
    [s0.rowsData addObject:r0];
    r0.rowHeight = 100;
    [data addObject:s0];
    
    
    TKTableSectionM * s1 = [[TKTableSectionM alloc] init];
    TKTableViewRowM * s1r0 = [[TKTableViewRowM alloc] init];
    [s1.rowsData addObject:s1r0];
    [data addObject:s1];
    
    
    TKTableSectionM * s2 = [[TKTableSectionM alloc] init];
    TKTableViewRowM * s2r0 = [[TKTableViewRowM alloc] init];
    TKTableViewRowM * s2r1 = [[TKTableViewRowM alloc] init];
    TKTableViewRowM * s2r2 = [[TKTableViewRowM alloc] init];
    [s2.rowsData addObject:s2r0];
    [s2.rowsData addObject:s2r1];
    s2r1.rowHeight = 100;
    [s2.rowsData addObject:s2r2];
    
    s2.tkFootView = [self getBtnCell];
    s2.sectionFootHeight = 100;
    
    [data addObject:s2];

    self.sectionData = data;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    switch (indexPath.section) {
        case 0:
            cell = [self getUserHeadRow];
            break;
        case 1:
        {
            TK_SettingCell * tkCell = [TK_SettingCell loadDefaultTextType:self];
            tkCell.leftLabel.text = @"设置备注和标签";
            tkCell.rightLabel.hidden = YES;
            cell = tkCell;
            break;
        }
        case 2:
        {
            if(indexPath.row == 1)
            {
                cell = [self getPictureRow];
            }
            else if(indexPath.row == 0)
            {
                TK_SettingCell * tkCell = [TK_SettingCell loadDefaultTextType:self];
                [tkCell setAccessoryType:UITableViewCellAccessoryNone];
//                tkCell.rightLabel.hidden = YES;
                tkCell.leftLabel.text = @"地区";
                tkCell.rightLabel.text = address;
                cell = tkCell;
            }else if(indexPath.row == 2)
            {
                TK_SettingCell * tkCell = [TK_SettingCell loadDefaultTextType:self];
                tkCell.leftLabel.text = @"更多";
                tkCell.rightLabel.hidden = YES;
                cell = tkCell;
            }
        }
            break;
        default:
            cell = [[UITableViewCell alloc] init];
            break;
    }
    
    return cell;
}


-(UITableViewCell *)getUserHeadRow
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    UILabel * lb = [[UILabel alloc] init];
    lb.text = @"晒单相册";
    lb.textColor = [UIColor tkMainTextColorForDefaultBg];
    lb.textAlignment = NSTextAlignmentLeft;
    lb.font = [UIFont systemFontOfSize:14];
    [cell addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(21);
        make.left.equalTo(cell).with.offset(18);
        
    }];
    
    return cell;
}

-(UITableViewCell *)getPictureRow
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    UILabel * lb = [[UILabel alloc] init];
    lb.text = @"晒单相册";
    lb.textColor = [UIColor tkMainTextColorForDefaultBg];
    lb.textAlignment = NSTextAlignmentLeft;
    lb.font = [UIFont systemFontOfSize:14];
    [cell addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(21);
        make.left.equalTo(cell).with.offset(18);
        
    }];
    
    CGFloat width = (TKScreenWidth - 18 - 20 - 100 )/4;
    UIImageView * image1 = [[UIImageView alloc]init];
    [cell addSubview:image1];
    image1.image = IMG(@"tk_image_head");
    
    [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(cell);
        make.width.mas_equalTo (width);
        make.height.mas_equalTo (width);
        make.left.equalTo(lb).with.offset(80);
        
    }];
    
    UIImageView * image2 = [[UIImageView alloc]init];
    [cell addSubview:image2];
    image2.image = IMG(@"tk_image_head");
    
    [image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(cell);
        make.width.mas_equalTo (width);
        make.height.mas_equalTo (width);
        make.left.equalTo(image1).with.offset(width + 2);
        
    }];
    
    UIImageView * image3 = [[UIImageView alloc]init];
    [cell addSubview:image3];
    image3.image = IMG(@"tk_image_head");
    
    [image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(cell);
        make.width.mas_equalTo (width);
        make.height.mas_equalTo (width);
        make.left.equalTo(image2).with.offset(width + 2);
        
    }];
    
    UIImageView * image4 = [[UIImageView alloc]init];
    [cell addSubview:image4];
    image4.image = IMG(@"tk_image_head");
    
    [image4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(cell);
        make.width.mas_equalTo (width);
        make.height.mas_equalTo (width);
        make.left.equalTo(image3).with.offset(width + 2);
        
    }];


    return cell;
}

-(UIView *)getBtnCell
{
    UIView * cell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TKScreenWidth, 100)];
    UIButton * btn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"私信" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    [btn setClipsToBounds:YES];
    btn.backgroundColor = [UIColor tkMainActiveColor];
    [btn setTitleColor:[UIColor tkMainTextColorForActiveBg] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor tkMainTextColorForDefaultBg] forState:UIControlStateHighlighted];
    [cell addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(cell);
        make.width.mas_equalTo(cell.frame.size.width - 40);
        make.height.mas_equalTo(40);
        
    }];
    cell.backgroundColor = [UIColor clearColor];
    
    [btn addTarget:self action:@selector(tkSendMessage) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;

}

-(void)tkSendMessage
{
    DDLogInfo(@"send message ");
}


@end
