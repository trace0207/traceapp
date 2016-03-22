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

- (void)setDefaultBackgroundView
{
    self.clipsToBounds = YES;
    self.layer.masksToBounds = NO;
    self.backgroundColor = [UIColor whiteColor];
    [[self layer] setCornerRadius:5];
    [[self layer] setShadowOffset:CGSizeMake(3, 3)];
    [[self layer] setShadowRadius:5];
    [[self layer] setShadowOpacity:0.8];
    [[self layer] setShadowColor:[UIColor blackColor].CGColor];
}
@end
