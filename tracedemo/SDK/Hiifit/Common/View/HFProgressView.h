//
//  HFProgressView.h
//
//  Created by zhuxiaoxia on 15-07-31.
//  Copyright (c) 2014年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  设置ProgressView四个角的形式
 *
 *  HFProgressViewBorderStyleDefault为默认形式，圆角
 *  HFProgressViewBorderSquare方角
 *  HFProgressViewBorderHalfSquare半直角
 */
typedef enum : NSUInteger {
    HFProgressViewBorderStyleDefault,
    HFProgressViewBorderSquare,
    HFProgressViewBorderHalfSquare,
} HFProgressViewBorderStyle;

@interface HFProgressView : UIView
/**
 *  进度填充部分显示的图像,如果有渐变效果的图片，高度要求大于等于progressView的高度
 */
@property(nonatomic, strong) UIImage* progressImage;
/**
 *  进度未填充部分显示的图像,如果有渐变效果的图片，高度要求大于等于progressView的高度
 */
@property(nonatomic, strong) UIImage* trackImage;

@property(nonatomic, strong) UIColor* progressTintColor;//进度填充部分显示的颜色
@property(nonatomic, strong) UIColor* trackTintColor;//进度未填充部分显示的颜色
@property(nonatomic, strong) UIColor* separatorColor;//等分线的颜色

@property(nonatomic, assign) CGFloat separatorWidth;//等分线的宽度，默认2pix
@property(nonatomic, readonly) CGFloat currentProgress;//当前的进度值
@property(nonatomic, assign) NSInteger separatorNumber;//等分线的数量，默认0

@property(nonatomic, assign) HFProgressViewBorderStyle progressStyle;

/**
 *  设置进度条的进度
 *
 *  @param progress 进度值
 *  @param animated  是否动态变化
 */
-(void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
