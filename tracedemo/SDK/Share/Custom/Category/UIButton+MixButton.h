//
//  UIButton+MixButton.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, buttonDirection) {
    button_horizontalType = 0,
    button_verticalType,
};

@interface UIButton (MixButton)

- (void)setImage:(UIImage *)image
        forState:(UIControlState)state
      withOffset:(CGFloat)offset
       direction:(buttonDirection)direction;


- (void)setTitle:(NSString *)title
        forState:(UIControlState)state
      withOffset:(CGFloat)offset
       direction:(buttonDirection)direction;
@end
