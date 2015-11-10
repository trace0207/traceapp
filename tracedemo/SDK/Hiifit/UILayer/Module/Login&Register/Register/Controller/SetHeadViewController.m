//
//  SetHeadViewController.m
//  GuanHealth
//
//  Created by hermit on 15/5/14.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "SetHeadViewController.h"
#import "HFAlertView.h"
#import "DataRes.h"
#import "HFModifySignatureReq.h"
@interface SetHeadViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate,VPImageCropperDelegate>

@end

@implementation SetHeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidesKeyBoard:)];
    [self.view addGestureRecognizer:tap];
    [self addNavigationTitle:@"注册信息"];
    [self addRightBarItemWithTitle:_T(@"HF_Common_Finish")];
    UserRes *user = [GlobInfo shareInstance].usr;
    if (user.headPortraitUrl.length>0) {
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:user.headPortraitUrl]] placeholderImage:IMG(@"photo_normal")];
    }else{
        [self.headImage setImage:IMG(@"photo_normal")];
    }
    
    if (user.nickName != nil || ![user.nickName isEqualToString:@""])
    {
        self.nameTextField.text = user.nickName;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBarItemAction:(id)sender
{
    NSString *text = [self.nameTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (text.length == 0) {
        [self.nameTextField endEditing:YES];
        WS(weakSelf)
        HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"来一个响亮的称号吧" commpleteBlock:^(NSInteger buttonIndex) {
            [weakSelf.nameTextField becomeFirstResponder];
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [alter show];
    }else if (self.nameTextField.text.length>8){
        [self.nameTextField endEditing:YES];
        WS(weakSelf)
        HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"昵称不能超过8位字符哦" commpleteBlock:^(NSInteger buttonIndex) {
            [weakSelf.nameTextField becomeFirstResponder];
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [alter show];
    }
    else{
        [self modifyInfo];
    }
}

- (void)hidesKeyBoard:(UITapGestureRecognizer*)tap
{
    if (self.nameTextField.editing) {
        [self.nameTextField endEditing:YES];
    }
}

- (void)modifyInfo
{
    int sex = [[self.param objectForKey:kParamSex]intValue];
    CGFloat weight = [[self.param objectForKey:kParamWeight]floatValue];
    CGFloat height = [[self.param objectForKey:kParamHeight]floatValue];
    NSString *year = [self.param objectForKey:kParamYear];
    NSString *mouth = [self.param objectForKey:kParamMonth];
    NSString *name = self.nameTextField.text;
    HFModifySignatureReq *req = [[HFModifySignatureReq alloc]init];
    req.nickName = name;
    req.height = height;
    req.weight = weight;
    req.year = year;
    req.month = mouth;
    req.day = @"1";
    req.sex = sex;
    req.showToastStr = @"NO";
    req.signature = @"我想做出一些积极的改变";
    WS(weakSelf)
    [[[HIIProxy shareProxy] userProxy] modifyWithInfo:req success:^(BOOL finished) {
        if (finished) {
            [[[HIIProxy shareProxy] userProxy] getUserInfo:^(BOOL finished) {
                [[UIKitTool getAppdelegate] goGuideViewController];
            }];
        }else{
            [weakSelf createFailInfo];
        }
    }];
}

- (void)createFailInfo
{
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackground:)];
    [backGroundView addGestureRecognizer:tapGesture];
    UIView * blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.5;
    [backGroundView addSubview:blackView];
    
    UIView * smallView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, kScreenWidth - 120, 200)];
    smallView.layer.cornerRadius = 5;
    smallView.layer.masksToBounds = YES;
    smallView.center = backGroundView.center;
    [backGroundView addSubview:smallView];
    
    UIView * smallView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 120, 240)];
    smallView1.backgroundColor = [UIColor blackColor];
    smallView1.alpha = 0.5;
    [smallView addSubview:smallView1];
    
    UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 50, kScreenWidth - 120 - 50, 80)];
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.font = [UIFont systemFontOfSize:16];
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.text = @"这个昵称已经被人用了呢\n换一个更有创意的吧";
    [smallView addSubview:contentLabel];
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:backGroundView];
}
- (void)tapBackground:(UITapGestureRecognizer *)gesture
{
    [gesture.view removeFromSuperview];
}
- (IBAction)photoAction:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"修改头像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [sheet addButtonWithTitle:@"拍照"];
    }
    [sheet addButtonWithTitle:@"相册"];
    [sheet setCancelButtonIndex:[sheet addButtonWithTitle:@"取消"]];
    [sheet showInView:self.view];
}

#pragma action sheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"拍照"]) {
        [self presentImagePickerController];
    }else if ([title isEqualToString:@"相册"]){
        [self presentPhotoLibrary];
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
        [[NetHTTPClient shareInstance]uploadImage:editedImage type:HIUploadImageTypePortrait showToast:YES callback:^(ResponseData *responseData) {
            if ([responseData success]) {
                [weakSelf.headImage setImage:editedImage];
                [[[HIIProxy shareProxy]userProxy]getUserInfo:^(BOOL finished) {
                }];
            }
        }];
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController
{
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark text field delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (IS_SCREEN_35_INCH) {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y-70);
        }];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (IS_SCREEN_35_INCH) {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y+70);
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

@end
