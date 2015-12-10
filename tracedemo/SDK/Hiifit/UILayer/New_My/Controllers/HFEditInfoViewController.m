//
//  HFEditInfoViewController.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/26.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFEditInfoViewController.h"
#import "HFEditInfoCell.h"
#import "ZHPickView.h"
#import "HFEditHeaderView.h"
#import "ModifySignatureController.h"
#import "HFBindPhoneNumViewController.h"
#import "HFModifyInfoReq.h"
#import "NSString+Message.h"
#import "TKUserCenter.h"

#define KEY_DES     @"description"
#define KEY_TYPE    @"type"

@interface HFEditInfoViewController () <UITableViewDelegate, UITableViewDataSource, HFEditInfoCellDelegate, ZHPickViewDelegate, HFEditHeaderDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, VPImageCropperDelegate, UINavigationControllerDelegate, UITextFieldDelegate, ModifySignatureControllerDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) HFEditHeaderView * headerView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) HFModifyInfoReq * req;
@property (nonatomic, strong) UITextField * textField;//定义一个全局变量。方便控制键盘收缩

@end

@implementation HFEditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    [self initData];
    [self addNavigationTitle:@"编辑资料"];
    [self addRightBarItemWithTitle:@"保存"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - privateFunction
- (void)loadUI
{
    [self.view addSubview:self.tableView];
    self.headerView = [[HFEditHeaderView alloc] init];
    self.headerView.delegate = self;
    self.tableView.tableHeaderView = self.headerView;
}
- (void)initData
{
//    UserRes *user = [GlobInfo shareInstance].usr;
    
    TKUser * user = [[TKUserCenter instance]getUser];
    
    [self.dataSource removeAllObjects];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:@"用户名" forKey:KEY_TXT];
    [dic1 setObject:user.nickName forKey:KEY_DES];
    [dic1 setObject:[NSNumber numberWithInteger:GZModifyNickname] forKey:KEY_TYPE];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setObject:@"出生年月" forKey:KEY_TXT];
    if (user.birthday.length == 10) {
        NSString *year = [user.birthday substringWithRange:NSMakeRange(0, 4)];
        
        NSString *mouth = [user.birthday substringWithRange:NSMakeRange(5, 2)];
        if ([mouth hasPrefix:@"0"]) {
            mouth = [mouth substringFromIndex:1];
        }
        NSString *birthday = [NSString stringWithFormat:@"%@年%@月",year,mouth];
        [dic2 setObject:birthday forKey:KEY_DES];
    }
    [dic2 setObject:[NSNumber numberWithInteger:GZModifyTypeAge] forKey:KEY_TYPE];
    
//    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
//    [dic4 setObject:@"身高" forKey:KEY_TXT];
//    [dic4 setObject:[user getHeight] forKey:KEY_DES];
//    [dic4 setObject:[NSNumber numberWithInteger:GZModifyHeight] forKey:KEY_TYPE];
//    
//    NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
//    [dic5 setObject:@"体重" forKey:KEY_TXT];
//    [dic5 setObject:[user getWeight] forKey:KEY_DES];
//    [dic5 setObject:[NSNumber numberWithInteger:GZModifyWeight] forKey:KEY_TYPE];
    
    NSMutableArray * sectionZeroArray = [NSMutableArray arrayWithObjects:dic1, dic2, nil];
    
    NSMutableDictionary *dic6 = [NSMutableDictionary dictionary];
    [dic6 setObject:@"个性签名" forKey:KEY_TXT];
    if (user.signature) {
        [dic6 setObject:user.signature forKey:KEY_DES];
    }
    [dic6 setObject:[NSNumber numberWithInteger:GZModifySignature] forKey:KEY_TYPE];
    
    NSMutableDictionary *dic7 = [NSMutableDictionary dictionary];
    [dic7 setObject:@"手机号" forKey:KEY_TXT];
    if (user.mobile.length == 0) {
        [dic7 setObject:@"未绑定" forKey:KEY_DES];
    }else{
        [dic7 setObject:user.mobile forKey:KEY_DES];
    }
    [dic7 setObject:[NSNumber numberWithInteger:GZModifyBangding] forKey:KEY_TYPE];
    
    [self.dataSource addObjectsFromArray:@[sectionZeroArray, dic6, dic7]];
    
    [self.tableView reloadData];
    
    if (user.sex == 1) {
        [self.headerView changeUserSex:NO];
    }
    [self.headerView.headerImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:user.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
}
- (void)rightBarItemAction:(id)sender
{
    [self.textField resignFirstResponder];
    
    if (self.textField.text.length == 0) {
        HFAlertView *atler = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"昵称不能为空！" commpleteBlock:^(NSInteger buttonIndex) {
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [atler show];
        return;
    }else{
        if (self.textField.text.length > 8) {
            self.textField.text = [self.textField.text substringToIndex:8];
            self.req.nickName = self.textField.text;
        }{
            self.req.nickName = self.textField.text;
        }
    }
    WS(weakSelf)
    [[[HIIProxy shareProxy]userProxy]modifyWithInfo:self.req success:^(BOOL finished) {
        if (finished) {
            [[[HIIProxy shareProxy]userProxy]getUserInfo:^(BOOL finished) {
                if (finished) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
    }];
}
- (BOOL)checkText:(UITextField *)textField
{
    NSString *str = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (str.length == 0) {
        HFAlertView *atler = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"昵称不能为空！" commpleteBlock:^(NSInteger buttonIndex) {
            [textField becomeFirstResponder];
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [atler show];
        return NO;
    }
    return YES;
}
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        NSUInteger count1 = [[self.dataSource objectAtIndex:section] count];
        return count1;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        static NSString * cellIdentifier = @"cellIdentifier";
        HFEditInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[HFEditInfoCell alloc] initWithIndex:0];
            NSDictionary * dic = [[self.dataSource firstObject] objectAtIndex:0];
            NSString * title = [dic objectForKey:KEY_TXT];
            NSString * desc = [dic objectForKey:KEY_DES];
            cell.titleLabel.text = title;
            cell.textField.text = desc;
            cell.textField.delegate = self;
            self.textField = cell.textField;
            //[cell.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        }
        return cell;
    }
    if (indexPath.section == 0 && indexPath.row != 0) {
        static NSString * cellIdentifier = @"cellIdentifier1";
        HFEditInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[HFEditInfoCell alloc] initWithIndex:2];
            NSDictionary * dic = [[self.dataSource firstObject] objectAtIndex:indexPath.row];
            NSString * title = [dic objectForKey:KEY_TXT];
            NSString * desc = [dic objectForKey:KEY_DES];
            cell.nameLabel.text = title;
            cell.descriptionLabel.text = desc;
        }
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString * cellIdentifier = @"cellIdentifier2";
        HFEditInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[HFEditInfoCell alloc] initWithIndex:1];
            NSDictionary * dic = [self.dataSource objectAtIndex:indexPath.section];
            NSString * title = [dic objectForKey:KEY_TXT];
            NSString * desc = [dic objectForKey:KEY_DES];
            cell.titleLabel.text = title;
            cell.signLabel.text = desc;
        }
        return cell;
    }
    if (indexPath.section == 2) {
        static NSString * cellIdentifier = @"cellIdentifier1";
        HFEditInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[HFEditInfoCell alloc] initWithIndex:2];
            NSDictionary * dic = [self.dataSource objectAtIndex:indexPath.section];
            NSString * title = [dic objectForKey:KEY_TXT];
            NSString * desc = [dic objectForKey:KEY_DES];
            cell.nameLabel.text = title;
            cell.descriptionLabel.text = desc;
        }
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFEditInfoCell * cell = (HFEditInfoCell *)[tableView cellForRowAtIndexPath:indexPath];
    HFEditInfoCell * textFieldCell = (HFEditInfoCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [cell.textField becomeFirstResponder];
    }else{
        [textFieldCell.textField resignFirstResponder];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy年M月d日";
        NSDate * date = [formatter dateFromString:[[[GlobInfo shareInstance] usr] birthday]];
        ZHPickView * picker = [[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        picker.cell = cell;
        picker.delegate = self;
        [picker show];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        CGFloat height = [[[GlobInfo shareInstance] usr] height];
        ZHPickView * picker = [[ZHPickView alloc] initWithStyle:HF_Height isHaveNavController:NO parameter:height];
        picker.delegate = self;
        picker.cell = cell;
        [picker show];
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        CGFloat weight = [[[GlobInfo shareInstance] usr] weight];
        ZHPickView * picker = [[ZHPickView alloc] initWithStyle:HF_Weight isHaveNavController:NO parameter:weight];
        picker.delegate = self;
        picker.cell = cell;
        [picker show];
    }
    if (indexPath.section == 1) {
        ModifySignatureController *vc = [[ModifySignatureController alloc]initWithNibName:@"ModifySignatureController" bundle:nil];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 2) {
        if ([GlobInfo shareInstance].usr.mobile == nil || [[GlobInfo shareInstance].usr.mobile isEqualToString:@""]) {
            HFBindPhoneNumViewController * bindViewController = [[HFBindPhoneNumViewController alloc] initWithNibName:@"HFBindPhoneNumViewController" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:bindViewController animated:YES];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        return 4;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 40;
    }
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 81;
    }
    return 59;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.textField resignFirstResponder];
}
#pragma mark - HFEditInfoCellDelegate
#pragma mark - ZHPickViewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString cell:(HFEditInfoCell *)cell
{
    cell.descriptionLabel.text = resultString;
    if (pickView.pickerStyle == HF_Weight) {
        self.req.weight = [[resultString stringByReplacingOccurrencesOfString:@"kg" withString:@""] floatValue];
    }
    if (pickView.pickerStyle == HF_Height) {
        self.req.height = [[resultString stringByReplacingOccurrencesOfString:@"cm" withString:@""] floatValue];
    }
    if (pickView.pickerStyle == HF_BirthDay) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy年M月d日";
        NSDate *date = [formatter dateFromString:resultString];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSUInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth;
        NSDateComponents *dateComponent = [gregorian components:unitFlags fromDate:date];
        
        self.req.year = [NSString stringWithFormat:@"%@",@([dateComponent year])];
        self.req.month = [NSString stringWithFormat:@"%@",@([dateComponent month])];
        self.req.day = [NSString stringWithFormat:@"%@",@([dateComponent day])];

    }
}
#pragma mark - HFEditHeaderDelegate
- (void)choosePicture
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"修改头像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [sheet addButtonWithTitle:@"拍照"];
    }
    [sheet addButtonWithTitle:@"相册"];
    [sheet setCancelButtonIndex:[sheet addButtonWithTitle:@"取消"]];
    [sheet showInView:self.view];

}
- (void)chooseGirl
{
    self.req.sex = 1;
    [self.headerView changeUserSex:NO];
}
- (void)chooseBoy
{
    self.req.sex = 0;
    [self.headerView changeUserSex:YES];
}
#pragma action sheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"拍照"]) {
        [MobClick event:Photo_Upload_Click];
        [self presentImagePickerController];
    }else if ([title isEqualToString:@"相册"]){
        [MobClick event:Head_Photo_Select];
        [self presentPhotoLibrary];
    }else{
        [MobClick event:Head_Cancel];
    }
}

- (void)presentImagePickerController
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)presentPhotoLibrary
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    WS(weakSelf)
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKeyedSubscript:UIImagePickerControllerOriginalImage];
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:[UIKitTool fixOrientation:image] cropFrame:CGRectMake(0, 100.0f, weakSelf.view.frame.size.width, weakSelf.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = weakSelf;
        [weakSelf presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}
#pragma VPImageCropperDelegate

- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage
{
    WS(weakSelf);
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
            
            [[NetHTTPClient shareInstance]uploadImage:editedImage type:HIUploadImageTypePortrait showToast:YES callback:^(ResponseData *responseData) {
                if ([responseData success]) {
                    [[[HIIProxy shareProxy]userProxy]getUserInfo:^(BOOL finished) {
                        [weakSelf initData];
                    }];
                }else{
                    NSLog(@"%@",responseData.msg);
                }
            }];
        });
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController
{
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length > 8) {
        textField.text = [textField.text substringToIndex:8];
        self.req.nickName = textField.text;
    }else{
        self.req.nickName = textField.text;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (![[textField textInputMode] primaryLanguage]) {
        return NO;
    }
    return YES;
}
#pragma mark - Notification
//- (void)textFieldDidChange:(UITextField *)textField
//{
//    if (textField.text.length > 1) {
//        NSString * lastStr = [textField.text substringFromIndex:textField.text.length - 1];
//        if ([NSString isContainsEmoji:lastStr]) {
//            NSLog(@"1");
//        }
//    }
//    if (textField.text.length > 8) {
//        textField.text = [textField.text substringToIndex:8];
//        [textField resignFirstResponder];
//    }
//    self.req.nickName = textField.text;
//}

#pragma mark - ModifySignatureControllerDelegate
- (void)finishModify
{
    [self initData];
}
#pragma mark - lazyLoading
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
    }
    return _tableView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (HFModifyInfoReq *)req
{
    if (!_req) {
        _req = [[HFModifyInfoReq alloc] init];
    }
    return _req;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
