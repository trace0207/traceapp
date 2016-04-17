//
//  TKEditUserInfoVC.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/10.
//  Copyright © 2015年 trace. All rights reserved.
//
#import "HFEditInfoCell.h"
#import "ZHPickView.h"
#import "HFEditHeaderView.h"
#import "ModifySignatureController.h"
#import "HFBindPhoneNumViewController.h"
#import "HFModifyInfoReq.h"
#import "NSString+Message.h"
#import "TKUserCenter.h"
#import "TKEditTextViewController.h"

#import "TKEditUserInfoVC.h"
#import "TK_SettingCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "TKPicSelectTool.h"
#import "TKWebViewController.h"
#import "TKModifyNameViewController.h"
#define KEY_DES     @"description"
#define KEY_TYPE    @"type"

@interface TKEditUserInfoTableVM()
{
    TK_SettingCell * headView;
    UIImageView * headImageView;
    
}
@property (nonatomic, strong) TKUser * user;
@end


@implementation TKEditUserInfoTableVM
@synthesize user;


-(instancetype)init
{
    self = [super init];
    user = [[TKUserCenter instance]getUser];
    return self;
}

-(void)tkLoadDefaultData
{
    
    
    [self.defaultSection.rowsData removeAllObjects];
    
    TKTableViewRowM * headRow = [[TKTableViewRowM alloc] init];
    headRow.rowHeight = 100;
    [self.defaultSection.rowsData addObject:headRow];
    
    self.defaultSection.rowHeight = 44;
    self.defaultSection.sectionFootHeight = 1.0;
    self.defaultSection.sectionHeadHeight = 1.0;
    for(int i =0;i<6;i++)
    {
        TKTableViewRowM * r = [[TKTableViewRowM alloc] init];
        [self.defaultSection.rowsData addObject:r];
    }
    
//
//    TKTableSectionM * m = [[TKTableSectionM alloc] init];
//    m.sectionHeadHeight = 15;
//    m.sectionFootHeight = 0.01;
//    m.rowHeight = 44;
    
//    [m.rowsData removeAllObjects];

    
    [self.mTableView reloadData];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0)
    {
        return [self getHeadView];
    }else
    {
        TK_SettingCell *cell = [TK_SettingCell loadDefaultTextType:self];
        [self fillCellContent:indexPath.row forCell:cell];
        return cell;
    }
    
}


-(void)fillCellContent:(NSInteger)row forCell:(TK_SettingCell *)cell
{
    
    switch (row) {
        case 1:
            cell.label1.text = @"昵称";
            cell.label2.text = user.nickName;
            break;
        case 2:
            cell.label1.text = @"神器账号";
            cell.label2.text = user.mobile;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            break;
        case 3:
            cell.label1.text = @"手机号码";
            cell.label2.text = user.mobile;
            break;
            
        case 4:
            cell.label1.text = @"通讯地址";
            cell.label2.text = user.address;
            break;
        case 5:
            cell.label1.text = @"性别";
            cell.label2.text = [user getSexString];
            break;
        case 6:
            cell.label1.text = @"个性签名";
            cell.label2.text = user.signature;
            break;
        default:
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    [self.tkDelegate onTableItemSelect:indexPath withItemData:nil];
}




-(TK_SettingCell *)getHeadView
{
    if(!headView)
    {
        headView = [TK_SettingCell loadRightImageViewType:self];
    }
    headView.label1.text = @"头像";
    headView.headImage.backgroundColor = [UIColor whiteColor];
    [headView.headImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:user.headPortraitUrl]]
                  placeholderImage:[UIImage imageNamed:@"head_default"]];
    [headView.headImage tkAddTapAction:@selector(showBigImage:) forTarget:self];
    return  headView;
}


/**
 查看大图
 **/
-(void)showBigImage:(UITapGestureRecognizer *)tap{
    
    // 大图 的 url 需要转换一下
    NSString * rawPicUrl = [UIKitTool getRawImage:user.headPortraitUrl];
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0;
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.srcImageView = (UIImageView *)tap.view;
    photo.url = [NSURL URLWithString:rawPicUrl];
    browser.photos = [NSArray arrayWithObjects:photo,nil];
    [browser show];
}

@end


@interface TKEditUserInfoVC ()<TKPicSelectDelegate,TKTableViewVMDelegate,UIActionSheetDelegate>
{
    TKEditUserInfoTableVM * vm;
    TKPicSelectTool * tool;
}


@end


@implementation TKEditUserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"我的个人信息";
    vm = [[TKEditUserInfoTableVM alloc] initWithDefaultTable];
    [self.view addSubview:vm.mTableView];
    [vm tkUpdateViewConstraint];
    [vm tkLoadDefaultData];
    vm.tkDelegate = self;
}


#pragma mark  cellEvent


-(void)onImageSelect:(UIImage *)image
{
    
    //    [headImageView setImage:image];
}

-(void)doSelectImage
{
    
    if(!tool)
    {
        tool = [[TKPicSelectTool alloc] init];
    }
    
    tool.viewController = self;
    tool.selectDelegate = self;
    [tool doSelectPic:@"选择头像" clipping:YES maxSelect:1];
}


-(void)dealloc
{
    tool = nil;
}


-(void)onTableItemSelect:(NSIndexPath *)indexPath withItemData:(id)data
{
    switch (indexPath.row) {
        case 0:
            [self doSelectImage];
            break;
        case 1:
        {
            TKModifyNameViewController * vc = [[TKModifyNameViewController alloc] init];
            vc.navTitle = @"修改昵称";
            vc.modifyType = ModifyName;
            [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
        }
            break;
           
        case 2:
        {
            TKEditTextViewController * vc = [[TKEditTextViewController alloc] init];
            vc.inPutType = 0;
            vc.navTitle = @"神器账号";
            vc.tag = indexPath.row;
            [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            TKEditTextViewController * vc = [[TKEditTextViewController alloc] init];
            vc.inPutType = 0;
            vc.navTitle = @"手机号码";
            vc.tag = indexPath.row;
            [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
//            TKEditTextViewController * vc = [[TKEditTextViewController alloc] init];
//            vc.inPutType = 0;
//            vc.navTitle = @"通讯地址";
//            vc.tag = indexPath.row;
//            [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
            
            [TKWebViewController showWebView:@"我的收货地址" url:AddressURL];
        }
            break;
        case 5:
        {
//            TKEditTextViewController * vc = [[TKEditTextViewController alloc] init];
//            vc.inPutType = 0;
//            vc.navTitle = @"性别";
//            vc.tag = indexPath.row;
//            [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
            
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"修改性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"女",@"男", nil];
            [sheet showInView:self.view];
            sheet.delegate = self;
        }
            break;
        case 6:
        {
            TKModifyNameViewController * vc = [[TKModifyNameViewController alloc] init];
            vc.navTitle = @"修改个性签名";
            vc.modifyType = ModifySignature;
            
            [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
            [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
//    
//    if (buttonIndex == 0) {
//        //女
//        arg.sex = 0;
//    }else if (buttonIndex == 1) {
//        //男
//        arg.sex = 1;
//    }
//    
//
    WS(weakSelf)
    TKUserCenter *userCenter = [TKUserCenter instance];
    [userCenter updateSex:buttonIndex block:^(BOOL result) {
        if (result) {
            vm.user.sex = 1;
            [weakSelf performSelector:@selector(reloadDD) withObject:nil afterDelay:1.0];
        }
    }];
}

- (void)reloadDD
{
    
    [vm.mTableView reloadData];
}
@end



