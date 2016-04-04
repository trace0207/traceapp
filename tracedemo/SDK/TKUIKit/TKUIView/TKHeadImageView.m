//
//  TKHeadImageView.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/16.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKHeadImageView.h"



@interface TKHeadImageView()
{
    UITapGestureRecognizer * mTap;
}
@end

@implementation TKHeadImageView



- (instancetype)init
{
    self = [super init];
    _roundValue =  - 1;
    self.image = IMG(@"head_default");
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.userInteractionEnabled = YES;
    return self;
}
    
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _roundValue =  - 1;
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.userInteractionEnabled = YES;
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    _roundValue =  - 1;
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.userInteractionEnabled = YES;
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.clipsToBounds = YES;
    [self.layer setCornerRadius:self.roundValue]; // 设置圆形头
    self.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)layoutSubviews
{
    [self.layer setCornerRadius:self.roundValue];
}


-(CGFloat)roundValue
{
    if(_roundValue == -1)
    {
        _roundValue = 2.0f;
    }
    return _roundValue;
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
