//
//  TKPicSelectViewController.m
//  GuanHealth
//
//  Created by luotianjia on 15/7/22.
//  Copyright (c) 2015年 cmcc. All rights reserved.
//

#import "TKPicSelectViewController.h"
#import "ZYQAssetPickerController.h"
#import "VPImageCropperViewController.h"
#import "UIKitTool.h"

@interface TKPicSelectViewController ()<ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,VPImageCropperDelegate>

@property (nonatomic ,assign) NSInteger selectMax; // 最大的选择数

@property (nonatomic ,assign) BOOL clipping;// 是否剪裁

@end



@implementation TKPicSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _takePhotpTitle = @"拍照";
    _chooseFromFileTitle = @"从相册选取";
    _cancelTitle = @"取消";
    _selectMax  = 1;
    _clipping = false;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


/**
 选择图片
 **/
-(void)doSelectPic:(NSString * )titleTex clipping:(BOOL)clipping maxSelect:(NSInteger)max{
    
    _clipping = clipping;
    _selectMax = max;
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:titleTex delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [sheet addButtonWithTitle:_takePhotpTitle];
    }
    [sheet addButtonWithTitle:_chooseFromFileTitle];
    [sheet setCancelButtonIndex:[sheet addButtonWithTitle:_cancelTitle]];
    [sheet showInView:self.view];
    
}


/**
 从自定义相册选择多张图片
 **/
-(void)chooseArrayFromPhotoLibary{
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = _selectMax;
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

/**
 从系统相册选择一张图片
 **/
- (void)chooseOneFormPhotoLibrary
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

/**
 
 一张图片选择完成 需要根据情况判定是否需要 剪裁
 **/

-(void)onOneImageSelect:(UIImage *)image{
    
    if(_clipping){
        
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:[UIKitTool fixOrientation:image] cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{}];
    }else{
        [self onOneImageBack:image];
        
    }
}

/**
 **/
-(void)onOneImageBack:(UIImage *)image{
    DDLogInfo(@"select image  %@",image);
    
}
/**
 多张图片选择Ok
 **/

-(void)onImageArrayBack:(NSArray *)images{
    
    DDLogInfo(@"select image multiple  count  %ld",(unsigned long)images.count);
}



#pragma mark --------
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL camera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
   
    if(!camera){
    
        buttonIndex = buttonIndex +1;
    }
    if(buttonIndex == 0){
        [self chooseFromCamera];
    }
    else if(buttonIndex == 1){
        [self chooseArrayFromPhotoLibary];
    }
}

- (void)chooseFromCamera
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:YES completion:nil];
}



#pragma mark --------
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    WS(weakSelf)
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKeyedSubscript:UIImagePickerControllerOriginalImage];
        [weakSelf onOneImageSelect:image];
        
    }];
    
    
}

- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage
{
    WS(weakSelf)
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        [weakSelf onOneImageBack:editedImage];
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController
{
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark --------
#pragma mark ZYQAssetPickerControllerDelegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    NSMutableArray * imageArray = [[NSMutableArray alloc] init];
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
        
        [imageArray addObject:[UIKitTool fixOrientation:result]];
        
    }
    if(_selectMax == 1){
        [self onOneImageBack:imageArray.firstObject];
    }else{
        [self onImageArrayBack:imageArray];
    }
}



@end
