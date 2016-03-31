//
//  TKUITools.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKUITools.h"
#import "MJPhotoBrowser.h"
#import "UIKitTool.h"
#import "MJPhoto.h"

@implementation TKUITools



+(void)showImageInBigScreen:(NSString *)picUrl withImageView:(UIImageView *)imageView
{
    NSString * rawPicUrl = [UIKitTool getRawImage:picUrl];
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0;
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.srcImageView = imageView;
    photo.url = [NSURL URLWithString:rawPicUrl];
    browser.photos = [NSArray arrayWithObjects:photo,nil];
    [browser show];
}


+(void)showImagesInBigScreen:(NSArray *)picUrls withImageViews:(NSArray *)imageViews currentIndex:(NSInteger)index
{
   
    NSMutableArray * mjPhotos = [[NSMutableArray alloc] init];
    
    for(int i =0 ;i<picUrls.count;i++)
    {
        NSString * rawPicUrl = [UIKitTool getRawImage:picUrls[i]];
        MJPhoto *photo = [[MJPhoto alloc] init];
        if(imageViews.count >i)
        {
            photo.srcImageView = (UIImageView *)imageViews[i];
        }else
        {
            photo.srcImageView = (UIImageView *)imageViews[imageViews.count -1];
        }
        photo.url = [NSURL URLWithString:rawPicUrl];
        [mjPhotos addObject:photo];
    }
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index;
    browser.photos = [NSArray arrayWithArray:mjPhotos];
    [browser show];
}


//计算纯文本高度
+ (CGFloat)getTextWidth:(NSString *)text withFontSize:(UIFont *)font
{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(10000, 2000)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes context:NULL];
    return rect.size.width;
}


//计算纯文本高度
+ (CGFloat)getTextHeight:(NSString *)text withFontSize:(UIFont *)font maxWidth:(CGFloat)maxWidth
{

    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(maxWidth, 2000)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes context:NULL];
    return rect.size.height;
}

+(void)removeAllChildViews:(UIView *)view
{

    NSArray  * array =   [view subviews];
    for(UIView *v in array)
    {
        [v removeFromSuperview];
    }
}


/**
 设置圆角border
 **/

+(void)setRoudBorderForView:(UIView *)view
                borderColor:(UIColor *)color
                     radius:(CGFloat)radius
                borderWidth:(CGFloat)width
{
    [view.layer setBorderColor:color.CGColor];
    [view.layer setBorderWidth:width];
    [view.layer setCornerRadius:radius];
}


+(UIView *)getListViewEmptyTip
{
    UILabel * l = [[UILabel alloc] init];
    l.textAlignment = NSTextAlignmentCenter;
    l.backgroundColor = [UIColor clearColor];
    l.text = @"无数据";
    return l;
}

@end
