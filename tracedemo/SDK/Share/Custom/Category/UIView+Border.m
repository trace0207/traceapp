//
//  UIView+Border.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/21.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (Border)

- (void)setDefaultBorder
{
    [self setBorderColor:[UIColor hexChangeFloat:@"bbbbbb"] borderWidth:1];
}

- (void)setBorderColor:(UIColor  *)color borderWidth:(CGFloat)width
{
    self.clipsToBounds = YES;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    [self.layer setCornerRadius:2];
}
@end
