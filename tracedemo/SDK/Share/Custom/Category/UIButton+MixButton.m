//
//  UIButton+MixButton.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "UIButton+MixButton.h"

@implementation UIButton (MixButton)

- (void)setImage:(UIImage *)image
        forState:(UIControlState)state
      withOffset:(CGFloat)offset
       direction:(buttonDirection)direction
{
    [self setImage:image forState:state];
    if (direction != button_verticalType)
    {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, offset, 0.0, 0.0)];
    }
    else
    {
        [self setImageEdgeInsets:UIEdgeInsetsMake(offset, 0.0, 0.0, 0.0)];
    }
}

- (void)setTitle:(NSString *)title
        forState:(UIControlState)state
      withOffset:(CGFloat)offset
       direction:(buttonDirection)direction
{
    [self setTitle:title forState:state];
    if (direction != button_verticalType)
    {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, offset)];
    }
    else
    {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(offset, 0.0, 0.0, 0.0)];
    }
    
}



@end
