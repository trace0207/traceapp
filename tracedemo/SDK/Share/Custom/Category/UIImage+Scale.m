//
//  UIImage+Scale.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/15.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)
+ (UIImage *)scaleWithImage:(NSString *)image
{
    UIImage *img = [UIImage imageNamed:image];
    UIImage *strImage = [img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
    
    return strImage;
}
@end
