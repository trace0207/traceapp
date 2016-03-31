//
//  TK_UserCenterVM.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/30.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_UserCenterVM.h"
#import "TK_SettingCell.h"
#import "TKUserCenter.h"
#import "UIColor+TK_Color.h"
#import "TKUserPageViewController.h"
#import "TKAppSettingViewController.h"
#import "TKEditUserInfoVC.h"
#import "UIView+Border.h"
#import "CAcountViewController.h"
#import "AbountViewController.h"
#import "TKSettingsViewController.h"
#import "TKBuyerCenterViewController.h"
@interface TK_UserCenterVM()
{
 
}
@end

@implementation TK_UserCenterVM


-(void)tkLoadDefaultData
{
    
    self.mTableView.backgroundColor = [UIColor clearColor];
    [self.mTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIView *view = [self getHeadCell];
    [self.mTableView setTableHeaderView:view];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.mTableView setTableFooterView:footerView];
    
    
    UIButton *exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 50, kScreenWidth-40, 40)];
    [footerView addSubview:exitBtn];
    [exitBtn setTitle:@"退出" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor hexChangeFloat:TKColorRed] forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
    [exitBtn setBorderColor:[UIColor tkBorderColor] borderWidth:1];
    
    
    TKTableSectionM * section0 = [[TKTableSectionM alloc] init];
    section0.sectionHeadHeight = 0.01;
    section0.sectionFootHeight = 10;
    [section0 initDefaultRowData:2];
    section0.rowHeight = 50;
    
    TKTableSectionM * section1 = [[TKTableSectionM alloc] init];
    section1.sectionHeadHeight = 0.01;
    section1.sectionFootHeight = 10;
    section0.rowHeight = 50;
    [section1 initDefaultRowData:2];
    
    
    TKTableSectionM * section2 = [[TKTableSectionM alloc] init];
    section2.sectionHeadHeight = 0.01;
    section2.sectionFootHeight = 0.01;
    section0.rowHeight = 50;
    [section2 initDefaultRowData:1];
    
    
    NSMutableArray * sections = [[NSMutableArray alloc] initWithObjects:section0,section1,section2, nil];
    self.sectionData = sections;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor whiteColor];
    return v;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return [self getSection0Row:indexPath.row];
    }
    else if(indexPath.section == 1)
    {
        return [self getSection1Row:indexPath.row];
    }
    else if(indexPath.section == 2)
    {
        return [self getSection2Row:indexPath.row];
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            [self onTableRowSelectFromSectionZore:indexPath.row];
            break;
        case 1:
            [self onTableRowSelectFromSectionOne:indexPath.row];
            break;
        case 2:
            //[self onTableRowSelectFromSectionTwo:indexPath.row];
            break;
        default:
            break;
    }
}

- (void)exit:(id)sender
{
    //退出操作
    TKBuyerCenterViewController *vc = [[TKBuyerCenterViewController alloc]init];
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
}

-(void)goToUserPage
{
    TKEditUserInfoVC * bvc = [[TKEditUserInfoVC alloc] init];
    [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
}


-(TK_SettingCell *)getSection1Row:(NSInteger)row
{
    TK_SettingCell * cell =   [TK_SettingCell loadDefaultTextWithLeftIconType:self];
    cell.label2.hidden  = YES;
    switch (row) {
        case 0:
            cell.label1.text = @"设置";
            cell.icon1.image = IMG(@"tk_icon_setting");
            break;
        case 1:
            cell.label1.text = @"关于";
            cell.icon1.image = IMG(@"tk_icon_about");
            break;
        default:
            break;
    }

    return cell;
}

-(TK_SettingCell *)getSection0Row:(NSInteger)row
{
    TK_SettingCell * cell =   [TK_SettingCell loadDefaultTextWithLeftIconType:self];
    cell.label2.hidden  = YES;
    switch (row) {
        case 0:
            cell.label1.text = @"账户详情";
            cell.icon1.image = IMG(@"tk_icon_account_detail");
            break;
        case 1:
            cell.label1.text = @"我的个人信息";
            cell.icon1.image = IMG(@"tk_icon_myuserinfo");
            break;
        default:
            break;
    }
    
    return cell;
}


-(TK_SettingCell *)getSection2Row:(NSInteger)row
{
    TK_SettingCell * cell =   [TK_SettingCell loadDefaultTextWithLeftIconType:self];
    cell.label2.hidden  = NO;
    cell.label1.text = @"联系客服";
    cell.icon1.image = IMG(@"tk_icon_gethelp");
    cell.label2.text = @"400-800-8008";
    return cell;
}



-(TK_SettingCell *)getHeadCell
{
    TK_SettingCell * cell =   [TK_SettingCell loadLeftImageViewType:self];
    cell.contentView.backgroundColor = [UIColor clearColor];
    TKUser * user = [[TKUserCenter instance]getUser];
    if (user.headPortraitUrl.length>0) {
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:user.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"user"]];
        
    }else{
        [cell.headImage setImage:IMG(@"user")];
    }
    cell.label1.text = user.nickName;
//    cell.label1.text = 
    cell.label2.text = user.signature;
//    cell.label3.textColor = [UIColor tkThemeColor1];
//    cell.label3.text = TKStrFromNumber(user.score);//[[NSNumber numberWithInteger:user.score]stringValue];
    return cell;
}

-(void)onTableRowSelectFromSectionZore:(NSInteger)row
{
    if (row == 0) {
        CAcountViewController * bvc = [[CAcountViewController alloc] init];
       
        [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
    }else{
        TKEditUserInfoVC * bvc = [[TKEditUserInfoVC alloc] init];
         bvc.navTitle = @"我的个人信息";
        [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
    }
}

-(void)onTableRowSelectFromSectionOne:(NSInteger)row
{
    if (row == 0) {
        TKSettingsViewController *vc = [[TKSettingsViewController alloc]init];
        [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
    }else if (row == 1){ //晒单相册
        AbountViewController * vc = [[AbountViewController alloc] init];
        [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
    }
}

-(void)onTableRowSelectFromSectionTwo:(NSInteger)row
{
    if (row == 0) {
        
        TKIBaseNavWithDefaultBackVC * bvc = [[TKIBaseNavWithDefaultBackVC alloc] init];
        bvc.navTitle = @"我的账户";
        [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
    }
    if (row == 1) {
        TKIBaseNavWithDefaultBackVC * bvc = [[TKIBaseNavWithDefaultBackVC alloc] init];
        bvc.navTitle = @"我的卡券";
        [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
    }
    else if (row == 2){
        
        TKIBaseNavWithDefaultBackVC * bvc = [[TKIBaseNavWithDefaultBackVC alloc] init];
        bvc.navTitle = @"附近买手";
        [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
        
    }
    else if(row == 3)
    {
        TKIBaseNavWithDefaultBackVC * bvc = [[TKIBaseNavWithDefaultBackVC alloc] init];
        bvc.navTitle = @"活动";
        [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
    }
    else if (row == 4) {
        TKAppSettingViewController * setVC = [[TKAppSettingViewController alloc] init];
        [[AppDelegate getMainNavigation] pushViewController:setVC animated:YES];
        
    }
    
}




@end
