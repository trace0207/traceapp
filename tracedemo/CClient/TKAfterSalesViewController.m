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

@end
