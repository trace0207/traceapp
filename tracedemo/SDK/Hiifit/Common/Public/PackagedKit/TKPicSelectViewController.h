//
//  TKPicSelectViewController.h
//  GuanHealth
//
//  Created by luotianjia on 15/7/22.
//  Copyright (c) 2015年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface TKPicSelectViewController : BaseViewController


@property (nonatomic,strong)NSString *  takePhotpTitle;
@property (nonatomic,strong)NSString *  chooseFromFileTitle;
@property (nonatomic,strong)NSString *  cancelTitle;



/**
 选择图片
 **/
-(void)doSelectPic:(NSString * )titleTex clipping:(BOOL)clipping maxSelect:(NSInteger)max;


/**
 **/
-(void)onOneImageBack:(UIImage *)image;

/**
 多张图片选择Ok
 **/
-(void)onImageArrayBack:(NSArray *)images;

@end
