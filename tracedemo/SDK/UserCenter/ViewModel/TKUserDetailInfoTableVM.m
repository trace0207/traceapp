//
//  TKUserDetailInfoTableVM.m
//  tracedemo
//
//  Created by cmcc on 15/12/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKUserDetailInfoTableVM.h"
#import "UIColor+TK_Color.h"
#import "TKUITools.h"
#import "TKIBaseNavWithDefaultBackVC.h"
#import "AppDelegate.h"
#import "TKUserPageViewController.h"
#import "TKHeadImageView.h"

@interface TKUserDetailInfoTableVM()
{

    NSString * address;
    NSString * headAddress;
    NSString * nickName;
    NSInteger faithValue; //诚信值
}

@end
@implementation TKUserDetailInfoTableVM



-(instancetype)initWithDefaultTable
{
    self = [super initWithDefaultTable];
    return self;
}


-(instancetype)init
{
    self =  [super init];
    [self userDetailInitData];
    address = @"浙江省、杭州市、西湖区 西溪路555号";
    headAddress = @"tk_image_head";
    nickName = @"他是个疯子";
    faithValue = 199;
    
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
    
    DDLogInfo(@"\n getCellView at VM %@   sections == %ld  row == %ld",NSStringFromClass([self class]),indexPath.section,indexPath.row);
    
    switch (indexPath.section) {
        case 0:
            cell = [self getUserHeadRow];
            cell.selectionStyle = NO;
            break;
        case 1:
        {
            TK_SettingCell * tkCell = [TK_SettingCell loadDefaultTextType:self];
            tkCell.label1.text = @"设置备注和标签";
            tkCell.label2.hidden = YES;
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
                tkCell.label1.text = @"地区";
                tkCell.label2.text = address;
                cell = tkCell;
                cell.selectionStyle = NO;
            }else if(indexPath.row == 2)
            {
                TK_SettingCell * tkCell = [TK_SettingCell loadDefaultTextType:self];
                tkCell.label1.text = @"更多";
                tkCell.label2.hidden = YES;
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




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if(indexPath.row == 1 && indexPath.section == 2)
    {
        [self showUserPage];
    }else if(indexPath.section == 2 && indexPath.row == 2)
    {
        [self showMore];
    }
}


-(UITableViewCell *)getUserHeadRow
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
   
    // 头像
    TKHeadImageView * headImage = [[TKHeadImageView alloc]init];
    [headImage setUserInteractionEnabled:YES];
    [cell addSubview:headImage];
    headImage.image = IMG(headAddress);
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(cell);
        make.width.mas_equalTo (65);
        make.height.mas_equalTo (65);
        make.left.equalTo(cell).with.offset(18);
        
    }];
    
    
    
    // 增加头像放大事件
    
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigHead:)];
//    
//    [headImage addGestureRecognizer:tap];
//    
//    [headImage.layer setCornerRadius:5];
//    [headImage setClipsToBounds:YES];
    
    
    [headImage tkAddTapAction:@selector(showBigHead:) forTarget:self];

    // 昵称
    UILabel * lb = [[UILabel alloc] init];
    lb.text = nickName;
    lb.textColor = [UIColor tkMainTextColorForDefaultBg];
    lb.textAlignment = NSTextAlignmentLeft;
    lb.font = [UIFont systemFontOfSize:16];
    [cell addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell).with.offset(25);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(21);
        make.left.equalTo(cell).with.offset(28 + 65);
        
    }];
    
    
    //诚信值:
    UILabel * lb1 = [[UILabel alloc] init];
    lb1.text = @"诚信值:";
    lb1.textColor = [UIColor tkMainTextColorForDefaultBg];
    lb1.textAlignment = NSTextAlignmentLeft;
    lb1.font = [UIFont systemFontOfSize:14];
    [cell addSubview:lb1];
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lb.mas_bottom).with.offset(3);
        make.width.mas_equalTo([TKUITools getTextWidth:lb1.text withFontSize:lb1.font] + 5);
        make.height.mas_equalTo(21);
        make.left.equalTo(lb.mas_left);
        
    }];
    
    
    //诚信value
    UILabel * lb2 = [[UILabel alloc] init];
    lb2.text = TKStrFromNumber(faithValue);
    lb2.textColor = [UIColor tkMainTextColorForDefaultBg];
    lb2.textAlignment = NSTextAlignmentLeft;
    lb2.font = [UIFont systemFontOfSize:14];
    lb2.textColor = [UIColor tkThemeColor1];
    [cell addSubview:lb2];
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lb1.mas_top);
        make.width.mas_equalTo([TKUITools getTextWidth:lb2.text withFontSize:lb1.font] + 5);
        make.height.mas_equalTo(21);
        make.left.equalTo(lb1.mas_right).with.offset(1);
        
    }];

    return cell;
}


-(void)showBigHead:(UIGestureRecognizer *)tap
{
    [TKUITools showImageInBigScreen:headAddress withImageView:(UIImageView *)tap.view];
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
    btn.backgroundColor = [UIColor tkThemeColor1];
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



#pragma  mark ---  click event
-(void)showUserPage
{
    TKUserPageViewController * vc = [[TKUserPageViewController alloc] init];
    vc.navTitle = @"晒单相册";
    vc.userId = self.userId;
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
}

-(void)showMore
{
    TKIBaseNavWithDefaultBackVC * vc = [[TKIBaseNavWithDefaultBackVC alloc] init];
    vc.navTitle = @"更多个人信息";
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
}

-(void)tkSendMessage
{
    TKIBaseNavWithDefaultBackVC * vc = [[TKIBaseNavWithDefaultBackVC alloc] init];
    vc.navTitle = @"私信";
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
}




@end
