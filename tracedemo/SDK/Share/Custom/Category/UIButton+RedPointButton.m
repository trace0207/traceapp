//
//  UIButton+RedPointButton.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/20.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "UIButton+RedPointButton.h"

#define kBaseRedPointTag  199

@implementation UIButton (RedPointButton)

- (void)addRedPoint
{
    UIView * view = [self viewWithTag:kBaseRedPointTag];
    
    if (!view)
    {
        CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{ NSFontAttributeName : self.titleLabel.font}];
        UIView * redView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width + textSize.width) / 2, (self.frame.size.height - textSize.height) / 2, 10, 10)];
        redView.backgroundColor = [UIColor redColor];
        redView.tag = kBaseRedPointTag;
        redView.layer.cornerRadius = 5;
        [self addSubview:redView];
    }
    else
    {
        view.hidden = NO;
    }
}

- (void)dismissRedPoint
{
    UIView * view = [self viewWithTag:kBaseRedPointTag];
    
    if (view && view.hidden == NO) {
        view.hidden = YES;
    }
}

@end
