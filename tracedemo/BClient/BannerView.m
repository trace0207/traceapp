//
//  BannerView.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "BannerView.h"

@interface BannerView ()

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *pagesLabel;

@end

@implementation BannerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setupMainView
{
    [super setupMainView];
    self.autoScrollTimeInterval = 4;
    self.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    UIView *alphaView = [[UIView alloc]init];
    alphaView.alpha = 0.4f;
    alphaView.backgroundColor = [UIColor blackColor];
    [backgroundView addSubview:alphaView];
    [alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.textColor = [UIColor whiteColor];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [backgroundView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _pagesLabel = [[UILabel alloc]init];
    _pagesLabel.textColor = [UIColor whiteColor];
    _pagesLabel.backgroundColor = [UIColor blackColor];
    _pagesLabel.alpha = 0.8f;
    _pagesLabel.font = [UIFont systemFontOfSize:8];
    _pagesLabel.textAlignment = NSTextAlignmentCenter;
    _pagesLabel.clipsToBounds = YES;
    [_pagesLabel.layer setCornerRadius:10];
    [backgroundView addSubview:_pagesLabel];
    [_pagesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView).with.offset(5);
        make.bottom.right.equalTo(backgroundView).with.offset(-5);
        make.width.mas_equalTo(40);
    }];
}

- (void)setCurrentIndex:(int)currentIndex
{
    NSUInteger pages = MAX(self.localizationImagesGroup.count, self.imageURLStringsGroup.count);
    self.pagesLabel.text = [NSString stringWithFormat:@"%i/%i",currentIndex+1,(int)pages];
}

- (void)setTitle:(NSString *)title
{
    self.priceLabel.attributedText = nil;
    self.priceLabel.text = title;
}

- (void)setAttributedString:(NSAttributedString *)attributedString
{
    self.priceLabel.text = nil;
    self.priceLabel.attributedText = attributedString;
}

@end
