//
//  TKPublishShowGoodsVC.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/26.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKPublishShowGoodsVC.h"
#import "PictureCell.h"
#import "TK_PicAddView.h"
#import "CycleScrollView.h"
#import "ZYQAssetPickerController.h"
#import "ZHPickView.h"


static const NSInteger publishMaxPicSize =9;


@interface TKPublishShowGoodsVC ()<TK_PicAddDelegate,CycleScrollViewDelegate,UINavigationControllerDelegate,ZHPickViewDelegate,
UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate,UITextFieldDelegate,UITextViewDelegate,TKClearViewDelegate>
{
    
    CGFloat pictureWidth;
    TK_PicAddView * picAddView;
}

@end

@implementation TKPublishShowGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect  screenSize =  CGRectMake(0,0,TKScreenWidth, TKScreenHeight);
    
    _rootScrollView = [[UIScrollView alloc] initWithFrame:screenSize];
    [_rootScrollView setContentSize:screenSize.size];
    _mainContentView.frame = CGRectMake(0, 0, TKScreenWidth,TKScreenHeight);
    [_rootScrollView addSubview:_mainContentView];
    _rootScrollView.directionalLockEnabled = YES;
    _rootScrollView.alwaysBounceVertical = YES;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_rootScrollView];
    [_rootScrollView addSubview:_mainContentView];
    [self loadImageViewField];
    _picturesArr = [[NSMutableArray alloc] init];
    
    _tabViewForCloseKeybord.clearDelegate = self;
    
//    self.inputTextView.placeHolder = @"请输入内容";
    
    self.inputTextView.delegate = self;
    self.inputTextView.font = [UIFont systemFontOfSize:16];
    
    
}


///**
// *  输入框
// *
// *  @return <#return value description#>
// */
//- (UITextField *)titleField
//{
//    if (!_titleField) {
//        _titleField = [[UITextField alloc] init];
//        self.titleField.placeholder = @" 请输入标题(20个字符)";
//        self.titleField.delegate = self;
//        self.titleField.font = [UIFont systemFontOfSize:16];
//        [_headerView addSubview:self.titleField];
//    }
//    return _titleField;
//}



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self TKI_setBarRightDefaultText:@"发布"];
}


-(NSString *)TK_getBarTitle{
    
    return @"发布晒单";
}

-(void)TKI_rightBarAction{
    
    [[HFHUDView shareInstance] ShowTips:@"发布晒单成功" delayTime:1.0 atView:NULL];
    [self TKI_leftBarAction];
}

-(void)TKI_leftBarAction{
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromBottom;//可更改为其他方式 [self.navigationController.view.layeraddAnimation:transition forKey:kCATransition];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
}

/**
 *  加载图片
 */
-(void)tkReloadePic
{
    
    [picAddView tkReloadWithDefaultPic:_picturesArr];
    
    
    // 更新 容器高度和 scrollView的 contentsize
    [self resetContentSize];
    
}


/**
 *  更新 容器高度和 scrollView的 contentsize
 */
-(void)resetContentSize
{
    CGFloat newHeight = [picAddView tkGetViewsHeight];
    CGRect frame = CGRectMake(picAddView.frame.origin.x
                              , picAddView.frame.origin.y
                              , picAddView.frame.size.width, newHeight);
    picAddView.frame = frame;
    [picAddView layoutIfNeeded];
    _picHeight.constant = newHeight;

    [_rootScrollView setContentSize:CGSizeMake(TKScreenWidth,TKScreenHeight +  newHeight - 80 * TKScreenScale)];
    
}




-(void)loadImageViewField{
    picAddView = [[TK_PicAddView alloc]initDefaultAdd];
    picAddView.tkAddDelegate = self;
    [_picContainer addSubview:picAddView];
//    [self resetContentSize];
}


#pragma  mark ---------  addPick delegate
-(void)onAddBtnAction
{
    if (_picturesArr.count >= 9) {
        HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:_T(@"HF_Common_More_Pictures") commpleteBlock:^(NSInteger buttonIndex) {
            
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [alter show];
        return;
    }
    //    [self.keyBoard tapBackgroud];
    //    [self.titleField resignFirstResponder];
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:_T(@"HF_Common_Add_Pictures") delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [sheet addButtonWithTitle:_T(@"HF_Common_Take_Picture")];
    }
    [sheet addButtonWithTitle:_T(@"HF_Common_Photo_Album")];
    [sheet setCancelButtonIndex:[sheet addButtonWithTitle:_T(@"HF_Common_Cancel")]];
    [sheet showInView:self.view];
    
}

-(void)tkPreviewPicturesAtIndex:(NSInteger)index
{
    CycleScrollView *cycle = [[CycleScrollView alloc]initWithFrame:kScreenBounds cycleDirection:CycleDirectionLandscape pictures:_picturesArr startIndex:(int)index];
    cycle.alpha = 0;
    cycle.delegate = self;
    [[UIKitTool getAppdelegate].window addSubview:cycle];
    [UIView animateWithDuration:0.12f animations:^{
        cycle.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma  mark  ActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_picturesArr.count>= publishMaxPicSize) {
        HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"不能一次上传多于9张图片" commpleteBlock:^(NSInteger buttonIndex) {
            
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [alter show];
        return;
    }
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
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)presentPhotoLibrary
{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 9 - _picturesArr.count;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
        {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    [self presentViewController:picker animated:YES completion:NULL];
}


#pragma mark - ZYQAssetPickerControllerDelegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    
    for (int i=0; i<assets.count; i++) {
        ALAsset *asset = [assets objectAtIndexedSubscript:i];
        
        ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
        CGImageRef fullResImage = [assetRepresentation fullResolutionImage];
        NSString *adjustment = [[assetRepresentation metadata] objectForKey:@"AdjustmentXMP"];
        if (adjustment) {
            NSData *xmpData = [adjustment dataUsingEncoding:NSUTF8StringEncoding];
            CIImage *image = [CIImage imageWithCGImage:fullResImage];
            
            NSError *error = nil;
            NSArray *filterArray = [CIFilter filterArrayFromSerializedXMP:xmpData
                                                         inputImageExtent:image.extent
                                                                    error:&error];
            CIContext *context = [CIContext contextWithOptions:nil];
            if (filterArray && !error) {
                for (CIFilter *filter in filterArray) {
                    [filter setValue:image forKey:kCIInputImageKey];
                    image = [filter outputImage];
                }
                fullResImage = [context createCGImage:image fromRect:[image extent]];
            }
        }
        UIImage *result = [UIImage imageWithCGImage:fullResImage
                                              scale:[assetRepresentation scale]
                                        orientation:(UIImageOrientation)[assetRepresentation orientation]];
        
        [_picturesArr addObject:[UIKitTool fixOrientation:result]];
    }
    [self tkReloadePic];
}

#pragma UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    [picker.view addSubview:indicatorView];
    [indicatorView startAnimating];
    [self dismissViewControllerAnimated:YES completion:^{
        [indicatorView removeFromSuperview];
    }];
    
    UIImage *image = [info objectForKeyedSubscript:UIImagePickerControllerOriginalImage];
    UIImage *configImage = [UIKitTool fixOrientation:image];
    [_picturesArr addObject:configImage];
    [self tkReloadePic];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma CycleScrollViewDelegate

- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didSelectImageView:(NSMutableArray *)index
{
    [UIView animateKeyframesWithDuration:0.2f delay:0.0f options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        cycleScrollView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [cycleScrollView removeFromSuperview];
        }
    }];
    int flag = 0;
    for (int i = 0; i < index.count; i++) {
        NSString *str = [index objectAtIndex:i];
        if ([str isEqualToString:@"0"]) {
            [_picturesArr removeObjectAtIndex:i-flag];
            flag = flag + 1;
        }
    }
    if (flag) {
        [self tkReloadePic];
    }
}


#pragma  mark clearDelegate

-(void)onClearViewEvent
{
     [self.inputTextView resignFirstResponder];
}


#pragma mark - text view delegate
- (void)textViewDidChange:(UITextView *)textView
{
//    if (textView.text.length>0) {
//        [self.textView scrollRectToVisible:CGRectMake(0, textView.contentSize.height-15, textView.contentSize.width, 10) animated:NO];
//    }
    if (400-(int)textView.text.length>=0) {
        self.textCountView.text = [NSString stringWithFormat:@"还能输入%i个字符",400-(int)textView.text.length];
    }else{
        self.textCountView.text = [NSString stringWithFormat:@"还能输入0个字符"];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (textView.text.length>=400 && text.length>0) {
        return NO;
    }
    return YES;
}


- (IBAction)typeBtnEvent:(UIButton *)sender {
    
    CGFloat weight = [[[GlobInfo shareInstance] usr] weight];
    ZHPickView * picker = [[ZHPickView alloc] initWithStyle:TK_GoodsType isHaveNavController:NO parameter:weight];
    picker.delegate = self;
    picker.cell = nil;
    [picker show];

    
}
@end