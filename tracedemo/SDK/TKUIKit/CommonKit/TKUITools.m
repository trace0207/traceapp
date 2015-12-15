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


@end
