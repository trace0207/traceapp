//
//  HFControl.m
//  SDCycleScrollView
//
//  Created by 朱伟特 on 15/7/30.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "HFControl.h"

@interface HFControl()

@property (nonatomic, strong) UIButton * mImageButton;

@end
@implementation HFControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI
{
    self.mIconImage.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.mIconImage.layer.cornerRadius = self.mIconImage.frame.size.height / 2;
    self.mImageButton.frame = self.mIconImage.frame;
}

#pragma mark -
#pragma mark lazyLoading
- (UIButton *)mImageButton
{
    if (!_mImageButton) {
        _mImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_mImageButton];
    }
    return _mImageButton;
}
- (UIImageView *)mIconImage
{
    if (!_mIconImage) {
        _mIconImage = [[UIImageView alloc] init];
        _mIconImage.backgroundColor = [UIColor redColor];
        [self addSubview:_mIconImage];
    }
    return _mIconImage;
}
- (void)addTargetSelector:(NSString *)selector
{
    SEL sel = NSSelectorFromString(selector);
    [self.mImageButton addTarget:self.nextResponder.nextResponder action:sel forControlEvents:UIControlEventTouchUpInside];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
