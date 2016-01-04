//
//  TKHeadImageView.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/16.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKHeadImageView.h"

static const CGFloat roundValue = 5.0f;

@interface TKHeadImageView()
{
    UITapGestureRecognizer * mTap;
}
@end

@implementation TKHeadImageView



- (instancetype)init
{
    self = [super init];
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.userInteractionEnabled = YES;
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.userInteractionEnabled = YES;
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.userInteractionEnabled = YES;
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.clipsToBounds = YES;
    [self.layer setCornerRadius:roundValue]; // 设置圆形头
    self.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)layoutSubviews
{
    [self.layer setCornerRadius:roundValue];
}


- (void)tkAddTapAction:(SEL)selector forTarget:(id)target
{
    if (!mTap)
    {
        mTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    }
    [self addGestureRecognizer:mTap];
}

@end
