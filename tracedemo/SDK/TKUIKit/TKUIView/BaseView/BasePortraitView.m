//
//  PortraitView.m
//  test
//
//  Created by hermit on 15/5/15.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "BasePortraitView.h"

@interface BasePortraitView()
{
    UITapGestureRecognizer * mTap;
}
@end


@implementation BasePortraitView

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
//    [self.layer setCornerRadius:frame.size.height/2]; // 设置圆形头 
    self.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)layoutSubviews
{
//    [self.layer setCornerRadius:self.frame.size.height/2];
}

- (void)addAction:(SEL)selector forTarget:(id)target
{
    if (!mTap)
    {
        mTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    }
    [self addGestureRecognizer:mTap];
}

- (void)removeAction
{
    [self removeGestureRecognizer:mTap];
}

@end
