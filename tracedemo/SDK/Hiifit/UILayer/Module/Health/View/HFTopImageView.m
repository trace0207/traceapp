//
//  HFTopImageView.m
//  UIButtonExtension
//
//  Created by 朱伟特 on 15/9/6.
//  Copyright (c) 2015年 朱伟特. All rights reserved.
//

#import "HFTopImageView.h"

#define kImageViewWidth 30
@interface HFTopImageView()
{
    CGFloat origionX;
    CGFloat add;
}
@property (nonatomic, strong) NSMutableArray * imageArray;
@property (nonatomic, strong) UIImageView * lineView;
@property (nonatomic, strong) NSMutableArray * upImageArray;

@end
@implementation HFTopImageView
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self loadUI];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadUI];
    }
    return self;
}
#pragma mark - privateFunction
- (void)loadUI
{
    
}
- (void)changeFinishImage:(NSInteger)index
{
    if (index == self.imageArray.count){
        return;
    }
    if (index <= 3 && index >= 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.lineView.frame = CGRectMake(5, 14, (origionX + add) * (index + 1), 3);
        } completion:^(BOOL finished) {
            UIButton * imageView = [self.imageArray objectAtIndex:index + 1];
            imageView.highlighted = YES;
            UIImageView * currImageView = [self.upImageArray objectAtIndex:index];
            currImageView.hidden = NO;
        }];
    }
}
- (void)changeFormerImage:(NSInteger)index
{
    if (index == 0) {
        return;
    }
    if (index >= self.imageArray.count) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.lineView.frame = CGRectMake(5, 14, (origionX + add) * (index - 1), 3);
    } completion:^(BOOL finished) {
        UIImageView * imageView = [self.upImageArray objectAtIndex:index - 1];
        imageView.hidden = YES;
        UIButton * currImageView = [self.imageArray objectAtIndex:index];
        currImageView.highlighted = NO;
    }];
}
#pragma mark - settinfFunction
- (void)setNumberOfImages:(NSInteger)numberOfImages
{
    self.lineView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 14, 0, 3)];
    self.lineView.image = IMG(@"line-1");
    [self addSubview:self.lineView];
    
    origionX = (kScreenWidth - 30) / numberOfImages;
    add = (origionX - kImageViewWidth) / (numberOfImages - 1);
    for (int i = 0; i < numberOfImages; i++) {
        UIButton * imageView = [UIButton buttonWithType:UIButtonTypeCustom];
        imageView.frame = CGRectMake(origionX * i + add * i, 0, kImageViewWidth, kImageViewWidth);
        imageView.layer.cornerRadius = kImageViewWidth / 2;
        imageView.layer.masksToBounds = YES;
        [imageView setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
        [imageView setTitleColor:[UIColor HFColorStyle_5] forState:UIControlStateNormal];
        [imageView setBackgroundImage:IMG(@"undone") forState:UIControlStateNormal];
        [imageView setBackgroundImage:IMG(@"current") forState:UIControlStateHighlighted];
        
        UIImageView * upImageView = [[UIImageView alloc] initWithFrame:imageView.frame];
        upImageView.image = IMG(@"done1");
        upImageView.layer.cornerRadius = kImageViewWidth / 2;
        upImageView.layer.masksToBounds = YES;
        upImageView.hidden = YES;
        
        if (i < 4) {
            UIImageView * intervalLine = [[UIImageView alloc] initWithFrame:CGRectMake((origionX + add) * i + kImageViewWidth, 14, (origionX - kImageViewWidth + add), 3)];
            intervalLine.image = IMG(@"line-2");
            [self addSubview:intervalLine];
        }
        if (i == 0) {
            imageView.highlighted = YES;
        }
        [self addSubview:imageView];
        [self addSubview:upImageView];
        [self.imageArray addObject:imageView];
        [self.upImageArray addObject:upImageView];
    }
}
#pragma mark - lazyLoading
- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        self.imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
- (NSMutableArray *)upImageArray
{
    if (!_upImageArray) {
        self.upImageArray = [NSMutableArray array];
    }
    return _upImageArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
