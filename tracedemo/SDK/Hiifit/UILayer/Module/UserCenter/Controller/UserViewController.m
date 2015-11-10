//
//  UserViewController.m
//  GuanHealth
//
//  Created by hermit on 15/5/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "UserViewController.h"
#import "UserInfoCell.h"
#import "UserRes.h"
#import "ModifyViewController.h"
#import "ModifySignatureController.h"
#import "SignThreeViewController.h"
#import "HFBindPhoneNumViewController.h"

#define KEY_DES     @"description"
#define KEY_TYPE    @"type"

@interface UserViewController ()<VPImageCropperDelegate>

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"个人信息"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initData];
}

- (void)initData
{
    UserRes *user = [GlobInfo shareInstance].usr;
    [self.dataSource removeAllObjects];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:@"昵称" forKey:KEY_TXT];
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
    
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:@"性别" forKey:KEY_TXT];
    [dic3 setObject:[user getSexStr] forKey:KEY_DES];
    [dic3 setObject:[NSNumber numberWithInteger:GZModifyTypeSex] forKey:KEY_TYPE];
    
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setObject:@"身高" forKey:KEY_TXT];
    [dic4 setObject:[user getHeight] forKey:KEY_DES];
    [dic4 setObject:[NSNumber numberWithInteger:GZModifyHeight] forKey:KEY_TYPE];
    
    NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
    [dic5 setObject:@"体重" forKey:KEY_TXT];
    [dic5 setObject:[user getWeight] forKey:KEY_DES];
    [dic5 setObject:[NSNumber numberWithInteger:GZModifyWeight] forKey:KEY_TYPE];
    
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
    
    
    
    [self.dataSource addObjectsFromArray:@[dic1,dic2,dic3,dic4,dic5,dic6,dic7]];
    
    
    [self.tableView reloadData];
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:user.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
}

- (IBAction)seeBigHeadImage:(id)sender
{
    NSString *urlStr = [UIKitTool getRawImage:[GlobInfo shareInstance].usr.headPortraitUrl];
    HFBigImageView *view = [[HFBigImageView alloc]initWithImage:_headImage.image withImageUrl:urlStr];
    [view show];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.headCell;
    }else{
        static NSString *identifier = @"UserInfoCell";
        UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:self options:nil]firstObject];
        }
        NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        
        NSString *text = [dic objectForKey:KEY_TXT];
        id description = [dic objectForKey:KEY_DES];
        
        cell.text.text = text;
        cell.descriptionText.text = [NSString stringWithFormat:@"%@",description];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 88;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"修改头像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [sheet addButtonWithTitle:@"拍照"];
        }
        [sheet addButtonWithTitle:@"相册"];
        [sheet setCancelButtonIndex:[sheet addButtonWithTitle:@"取消"]];
        [sheet showInView:self.view];
        [MobClick event:User_info_Click];
    }else {
        
        NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        NSInteger type = [[dic objectForKey:KEY_TYPE]integerValue];
        if (type == GZModifyHeight || type == GZModifyNickname || type == GZModifyTypeAge || type == GZModifyWeight) {
            ModifyViewController *vc = [[ModifyViewController alloc]init];
            vc.modyfyType = type;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (type == GZModifyTypeSex){
            [MobClick event:User_Sex_Click];
            SignThreeViewController *vc = [[SignThreeViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (type == GZModifySignature){
            ModifySignatureController *vc = [[ModifySignatureController alloc]initWithNibName:@"ModifySignatureController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (type == GZModifyBangding) {
            if ([GlobInfo shareInstance].usr.mobile == nil || [[GlobInfo shareInstance].usr.mobile isEqualToString:@""]) {
                HFBindPhoneNumViewController * bindViewController = [[HFBindPhoneNumViewController alloc] initWithNibName:@"HFBindPhoneNumViewController" bundle:[NSBundle mainBundle]];
                [self.navigationController pushViewController:bindViewController animated:YES];
            }
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
//            [[NetHTTPClient shareInstance]uploadImage:editedImage type:HIUploadImageTypePortrait callback:^(ResponseData *responseData) {
//                if ([responseData success]) {
//                    [[[HIIProxy shareProxy]userProxy]getUserInfo:^(BOOL finished) {
//                        [weakSelf initData];
//                    }];
//                }else{
//                    NSLog(@"%@",responseData.msg);
//                }
//            }];
            
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

@end
