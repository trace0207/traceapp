//
//  HFAnimationView.m
//  SDCycleScrollView
//
//  Created by 朱伟特 on 15/7/30.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "HFAnimationView.h"

@interface HFAnimationView()

@property (nonatomic, strong) UIImageView * animationView;
@property (nonatomic, strong) UIImageView * backGroundImageView;
@property (nonatomic, assign) CGFloat timeInterval;
@property (nonatomic, assign) NSInteger repeatCounts;

@end
@implementation HFAnimationView

- (id)initWithFrame:(CGRect)frame timeInterval:(CGFloat)interval repeatCounts:(NSInteger)repeatCounts
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        self.timeInterval = interval;
        self.repeatCounts = repeatCounts;
    }
    return self;
}
- (void)initUI
{
    self.backGroundImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.animationView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
#pragma mark -
#pragma mark lazyLoading
- (UIImageView *)animationView
{
    if (!_animationView) {
        _animationView = [[UIImageView alloc] init];
        [self addSubview:_animationView];
    }
    return _animationView;
}
- (UIImageView *)backGroundImageView
{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc] init];
        [self addSubview:_backGroundImageView];
    }
    return _backGroundImageView;
}
- (void)setImageArray:(NSArray *)imageArray
{
    self.backGroundImageView.image = [imageArray lastObject];
    self.animationView.animationImages = imageArray;
    self.animationView.animationDuration = self.timeInterval;
    self.animationView.animationRepeatCount = self.repeatCounts;
    [self.animationView startAnimating];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
