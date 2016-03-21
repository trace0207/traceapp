//
//  UIButton+TitleImage.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/21.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "UIButton+TitleImage.h"

@implementation UIButton (TitleImage)
- (void)setLeftTitle:(NSString *)title rightImage:(UIImage *)image
{
    
    NSDictionary *attributed = @{NSFontAttributeName:self.titleLabel.font};
    CGRect titleRect = [title boundingRectWithSize:CGSizeMake(300, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributed context:NULL];
    CGSize imageSize = image.size;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width, 0, imageSize.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleRect.size.width, 0, -titleRect.size.width)];
    
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateNormal];
}
@end
