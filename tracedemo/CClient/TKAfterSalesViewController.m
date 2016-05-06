//
//  TKAfterSalesViewController.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/4/6.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKAfterSalesViewController.h"
#import "TKPicSelectTool.h"
#import "UIView+Border.h"
#import "TKAlertView.h"
#import "TK_UploadImageAck.h"
#import "TK_ApplyRightArg.h"
#import "HF_HttpClient.h"
@interface TKAfterSalesViewController ()<TKPicSelectDelegate,TKTextViewDelegate>
@property (nonatomic, strong) TKPicSelectTool *picTool;
@property (nonatomic, strong) NSMutableArray *pictures;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@end
const int maxPicturesNumber = 3;
@implementation TKAfterSalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.submitBtn setDefaultBorder];
    _pictures = [[NSMutableArray alloc]init];
    self.photoViewHeight.constant = 100;
    self.textView.placehorderText = @"点击输入申诉理由";
    [self.textView setDefaultBorder];
    [self.photoView setDefaultBorder];
    [self.view addGestureRecognizer:self.tapGesture];
}

- (UITapGestureRecognizer *)tapGesture
{
    if (nil == _tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard:)];
    }
    return _tapGesture;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKaddNavigationTitle:@"申请售后"];
}

- (void)hideKeyboard:(UITapGestureRecognizer*)tap
{
    [self.textView resignFirstResponder];
}

- (TKPicSelectTool *)picTool
{
    if (nil == _picTool) {
        _picTool = [[TKPicSelectTool alloc]init];
        _picTool.selectDelegate = self;
        _picTool.viewController = self;
    }
    return _picTool;
}

- (IBAction)choosePicAction:(id)sender {
    [self.textView resignFirstResponder];
    if (self.pictures.count>=maxPicturesNumber) {
        
    }else {
        [self.picTool doSelectPic:@"添加图片" clipping:NO maxSelect:maxPicturesNumber-self.pictures.count];
    }
}

- (IBAction)submitAction:(id)sender {
    //申请售后

    if(self.textView.text.length == 0)
    {
        [[HFHUDView shareInstance] ShowTips:@"请输入申诉理由" delayTime:1.5 atView:nil];
        return ;
    }
    else if(self.pictures.count == 0)
    {
        [TKAlertView showAltertWithTitle:@"温馨提示" withMessage:@"为了能更好地处理问题，请上传有问题的照片" commpleteBlock:nil cancelTitle:nil determineTitle:@"确定"];
        return;
    }

    
    TKAlertView * loading = [TKAlertView showHUDWithText:@"正在提交..."];
    
    TK_ApplyRightArg * arg = [[TK_ApplyRightArg alloc] init];
    
    [[TKProxy proxy].mainProxy uploadMutableImages:self.pictures withtype:3 withBlock:^(NSArray<__kindof TK_JsonModelAck *> *ack) {
       
        BOOL anyFailed = NO;
        for (int i=0; i<ack.count; i++) {
            TK_UploadImageAck * imageAck = [ack objectAtIndex:i];
            if(!imageAck.sucess)
            {
                anyFailed = YES;
                break;
            }
            else
            {
                if(i == 0)
                {
                    arg.picAddr1 = imageAck.data.imgUrl;
                }else if(i == 1)
                {
                    arg.picAddr2 = imageAck.data.imgUrl;
                }
                else if(i == 2)
                {
                    arg.picAddr3 = imageAck.data.imgUrl;
                }
            }
        }
        
        
        if(anyFailed)
        {
            [loading removeFromSuperview];
            
            [[HFHUDView shareInstance] ShowTips:@"图片上传失败" delayTime:1.0 atView:nil];
            return;
        }
        
        arg.orderId = self.orderId;
        arg.reason = self.textView.text;
        
        [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:^(HF_BaseAck *ack) {
            [loading removeFromSuperview];
            if(ack.sucess)
            {
                [HFAlertView showAltertWithTitle:@"提交成功" withMessage:@"您的申诉已提交，我们会尽快处理你的问题，请耐心等待回复"
                                  commpleteBlock:^(NSInteger buttonIndex){
                                      
                                      [[AppDelegate getMainNavigation] popViewControllerAnimated:YES];
                
                }
                                     cancelTitle:nil
                                  determineTitle:@"确定"];
                
            }
            else
            {
                [[HFHUDView shareInstance] ShowTips:ack.msg delayTime:1.0 atView:nil];
            }
            
        }];
    }];
    
    
    
    
    
}

-(void)onImagesSelect:(NSArray *)images
{
    [self.pictures addObjectsFromArray:images];
    [self setPicturesToPhotoView];
}

-(void)onImageSelect:(UIImage *)image
{
    [self.pictures addObject:image];
    [self setPicturesToPhotoView];
}

- (void)setPicturesToPhotoView
{
    for (NSUInteger i = 0; i < maxPicturesNumber; i++) {
        UIImageView *imageView = [self.photoView viewWithTag:1000+i];
        if (nil == imageView) {
            imageView = [[UIImageView alloc]init];
            imageView.tag = 1000+i;
            [self.photoView addSubview:imageView];
        }
        if (i < self.pictures.count) {
            UIImage *image = [self.pictures objectAtIndex:i];
            imageView.hidden = NO;
            [imageView setImage:image];
            imageView.frame = CGRectMake(8+i*93, 35, 90, 90);
        }else{
            imageView.hidden = YES;
        }
    }
    if (self.pictures.count == 0) {
        self.photoViewHeight.constant = 100;
    }else{
        self.photoViewHeight.constant = 150;
    }
    if (self.pictures.count < maxPicturesNumber && self.pictures.count>0) {
        self.goOnLabel.hidden = NO;
    }else{
        self.goOnLabel.hidden = YES;
    }
}


+(void)showAfterSalesView:(NSString *)orderId
{
    TKAfterSalesViewController * vc = [[TKAfterSalesViewController alloc] init];
    vc.orderId = orderId;
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
}

@end
