//
//  UIImageView+TKI_ImageFill.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/24.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "UIImageView+TKI_ImageFill.h"
#import "UIKitTool.h"

@implementation UIImageView (TKI_ImageFill)


-(void)TK_fillWithUrl:(NSURL *) url withDefult:(UIImage *)image{

    [self sd_setImageWithURL:url placeholderImage:image options:0 progress:nil completed:nil];
}


-(void)TK_fillWithStrUrl:(NSString *)str withDefaultImageResouceName:(NSString *)imageName{
    
   [self sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:str]] placeholderImage:[UIImage imageNamed:imageName]];
}


-(void)TK_fillDefaultHeadImage:(NSString *)url{
    [self sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:url]] placeholderImage:[UIImage imageNamed:@"default_head"]];
}

@end
