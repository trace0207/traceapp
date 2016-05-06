//
//  BUserCenterVM.m
//  tracedemo
//
//  Created by cmcc on 16/3/1.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "BUserCenterVM.h"
#import "TK_SettingCell.h"
#import "TKUserCenter.h"
#import "UIColor+TK_Color.h"
#import "TKUserPageViewController.h"
#import "TKAppSettingViewController.h"
#import "TKEditUserInfoVC.h"
#import "NSString+HFStrUtil.h"
#import "AbountViewController.h"
#import "TKBuyerCenterViewController.h"
#import "TKSettingsViewController.h"
#import "TKInviteCodeViewController.h"
#import "TKBuyerCenterViewController.h"
#import "CBillViewController.h"
#import "TKWebViewController.h"
#import "TKUITools.h"
@implementation BUserCenterVM



-(void)tkLoadDefaultData
{
    self.mTableView.backgroundColor = [UIColor clearColor];
    [self.mTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//    TKTableSectionM * section0 = [[TKTableSectionM alloc] init];
//    section0.sectionHeadHeight = 0.01;
//    section0.sectionFootHeight = 0.01;
//    [section0 initDefaultRowData:1];
//    section0.rowHeight = 150;
    
    UIView *view = [self getHeadCell];
    [self.mTableView setTableHeaderView:view];
    
    TKTableSectionM * section1 = [[TKTableSectionM alloc] init];
    section1.sectionHeadHeight = 0.01;
    section1.sectionFootHeight = 15;
    [section1 initDefaultRowData:5];
    
    
    TKTableSectionM * section2 = [[TKTableSectionM alloc] init];
    section2.sectionHeadHeight = 0.01;
    section2.sectionFootHeight = 15;
    [section2 initDefaultRowData:3];
    
    TKTableSectionM * section3 = [[TKTableSectionM alloc] init];
    section3.sectionHeadHeight = 0.01;
    section3.sectionFootHeight = 0.001;
    [section3 initDefaultRowData:1];
    
    NSMutableArray * sections = [[NSMutableArray alloc] initWithObjects:section1,section2,section3,nil];
    self.sectionData = sections;
    [self.mTableView reloadData];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return [self getSection1Row:indexPath.row];
    }
    else if(indexPath.section == 1)
    {
        return [self getSection2Row:indexPath.row];
    }
    else if(indexPath.section == 2)
    {
        return [self getSection3Row:indexPath.row];
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor whiteColor];
    return v;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            [self onTableRowSelectFromSectionOne:indexPath.row view:[tableView cellForRowAtIndexPath:indexPath]];
            break;
        case 1:
            [self onTableRowSelectFromSectionTwo:indexPath.row];
            break;
        case 2:
            //打客服电话
            [UIKitTool callPhone:SERVER];
            break;
        default:
            break;
    }
}

-(void)goToUserPage
{
    TKBuyerCenterViewController * bvc = [[TKBuyerCenterViewController alloc] init];
    bvc.isBuyer = YES;
    bvc.userId = [TKUserCenter instance].getUser.userId;
    [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
}


-(TK_SettingCell *)getSection1Row:(NSInteger)row
{
    TK_SettingCell * cell =   [TK_SettingCell loadDefaultTextWithLeftIconType:self];
    cell.label2.hidden  = YES;
    switch (row) {
        case 0:
        {
            cell.label1.text = @"保证金";
            cell.icon1.image = IMG(@"tk_icon_ deposit");
            cell.label2.hidden = NO;
            NSString  * value = [NSString stringWithFormat:@"%0.2f元",[[TKUserCenter instance] getUser].guarantee.integerValue/100.0];
            cell.label2.text = value;//[[TKUserCenter instance] getUser].guarantee;
            break;
        }
        case 1:
            cell.label1.text = @"账户详情";
            cell.icon1.image = IMG(@"tk_icon_account_detail");
            break;
        case 2:
            cell.label1.text = @"我的个人信息";
            cell.icon1.image = IMG(@"tk_icon_myuserinfo");
            break;
        case 3:
            cell.label1.text = @"我的账单流水";
            cell.icon1.image = IMG(@"tk_icon_my_paylist");
            break;
        case 4:
            cell.label1.text = @"我的客户管理";
            cell.icon1.image = IMG(@"tk_icon_myconsumers");
            break;

        default:
            break;
    }
    
    return cell;
}


-(TK_SettingCell *)getSection2Row:(NSInteger)row
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
            cell.label1.text = @"生成邀请码";
            cell.icon1.image = IMG(@"tk_icon_invitecode");
            break;
    }
    
    return cell;
}


-(TK_SettingCell *)getSection3Row:(NSInteger)row
{
    TK_SettingCell * cell =   [TK_SettingCell loadDefaultTextWithLeftIconType:self];
    cell.label2.hidden  = YES;
    switch (row) {
        case 0:
            cell.label1.text = @"联系客服";
            cell.icon1.image = IMG(@"tk_icon_gethelp");
            cell.label2.hidden = NO;
            cell.label2.text = @"400-800-8008";
            break;
        default:
            break;
    }
    
    return cell;
}



-(TK_SettingCell *)getHeadCell
{
    TK_SettingCell * cell =   [TK_SettingCell loadCenterImageType:self];
    cell.contentView.backgroundColor = [UIColor tkThemeColor2];
    TKUser * user = [[TKUserCenter instance]getUser];
    if (user.headPortraitUrl.length>0) {
        TKSetHeadImageView(cell.headImage, [TKUITools getRawImage:user.headPortraitUrl])
    }else{
        [cell.headImage setImage:IMG(@"tk_image_head_default")];
    }
    [cell.headImage tkAddTapAction:@selector(goToUserPage) forTarget:self];
    cell.label2.text = user.nickName;
    cell.label1.text =  [[NSString alloc] initWithFormat:@"Vip:%@级",user.vip];  // @"Vip:%级别";
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    return cell;
}



-(void)onTableRowSelectFromSectionOne:(NSInteger)row view:(TK_SettingCell *)cell
{
    if(row == 0)//保证金
    {
        [TKWebViewController showWebView:@"保证金" url:BDepositURL];
    }
    else if (row == 1)
    {
        [TKWebViewController showWebView:@"账户详情" url:BaccountDetailURL];
    }
    else if (row == 2) {
        TKEditUserInfoVC *vc = [[TKEditUserInfoVC alloc]init];
        [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
    }else if(row == 3)
    {
        CBillViewController * vc = [[CBillViewController alloc] init];
        [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
    }
    else if (row == 4)
    {
        [TKWebViewController showWebView:@"我的客户管理" url:MyCustomerURL];
    }
    else{
        TKIBaseNavWithDefaultBackVC * normalVC = [[TKIBaseNavWithDefaultBackVC alloc] init];
        normalVC.navTitle = cell.label1.text;
        [[AppDelegate getMainNavigation] pushViewController:normalVC animated:YES];
    }
    

    
//    if (row == 0) {
//        TKIBaseNavWithDefaultBackVC * bvc = [[TKIBaseNavWithDefaultBackVC alloc] init];
//        bvc.navTitle = @"我的订单";
//        [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
//    }else if (row == 1){ //  晒单相册
//        TKUserPageViewController * userPage = [[TKUserPageViewController alloc] init];
//        userPage.userId = TKUserId;
//        userPage.navTitle = @"我的晒单";
//        [[AppDelegate getMainNavigation] pushViewController:userPage animated:YES];
//    }else if (row == 2)
//    {
//        TKIBaseNavWithDefaultBackVC * bvc = [[TKIBaseNavWithDefaultBackVC alloc] init];
//        bvc.navTitle = @"我的私信";
//        [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
//    }
    
}

-(void)onTableRowSelectFromSectionTwo:(NSInteger)row
{
    if (row == 0) {
        
        TKSettingsViewController * bvc = [[TKSettingsViewController alloc] init];
        [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
    }
    if (row == 1) {
//        TKIBaseNavWithDefaultBackVC * bvc = [[TKIBaseNavWithDefaultBackVC alloc] init];
//        bvc.navTitle = @"我的卡券";
//        [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
        AbountViewController *vc = [[AbountViewController alloc]initWithNibName:@"AbountViewController" bundle:nil];
        [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
    }
    else if (row == 2){
        TKInviteCodeViewController *vc = [[TKInviteCodeViewController alloc]initWithNibName:@"TKInviteCodeViewController" bundle:nil];
        [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
//        TKIBaseNavWithDefaultBackVC * bvc = [[TKIBaseNavWithDefaultBackVC alloc] init];
//        bvc.navTitle = @"附近买手";
//        [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
        
    }
//    else if(row == 3)
//    {
//        TKIBaseNavWithDefaultBackVC * bvc = [[TKIBaseNavWithDefaultBackVC alloc] init];
//        bvc.navTitle = @"活动";
//        [[AppDelegate getMainNavigation] pushViewController:bvc animated:YES];
//    }
//    else if (row == 4) {
//        TKAppSettingViewController * setVC = [[TKAppSettingViewController alloc] init];
//        [[AppDelegate getMainNavigation] pushViewController:setVC animated:YES];
//        
//    }
    
}

@end
