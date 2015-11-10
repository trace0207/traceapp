//
//  HFEditInfoHeaderView.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/26.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFEditInfoHeaderView.h"

@interface HFEditInfoHeaderView()

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIButton * selectPicBtn;
@property (nonatomic, strong) UIButton * girlBtn;
@property (nonatomic, strong) UIButton * boyBtn;
@property (nonatomic, strong) UIView * smallView;
@property (nonatomic, strong) UIImageView * smallImageView;

@end
@implementation HFEditInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}
- (void)loadUI
{
    self.frame = CGRectMake(0, 0, kScreenWidth, 220);
    WS(weakSelf)
    [self addSubview:self.imageView];
    self.imageView.layer.cornerRadius = 45;
    self.imageView.layer.masksToBounds = YES;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(20);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    [self.imageView addSubview:self.smallImageView];
    [self.smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.imageView.mas_right).with.offset(-30);
        make.bottom.equalTo(weakSelf.imageView.mas_bottom).with.offset(-30);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}
#pragma mark - lazyLoading
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
- (UIButton *)selectPicBtn
{
    if (!_selectPicBtn) {
        _selectPicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _selectPicBtn;
}
- (UIButton *)girlBtn
{
    if (!_girlBtn) {
        _girlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _girlBtn;
}
- (UIButton *)boyBtn
{
    if (!_boyBtn) {
        _boyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _boyBtn;
}
- (UIImageView *)smallImageView
{
    if (!_smallImageView) {
        _smallImageView = [[UIImageView alloc] init];
    }
    return _smallImageView;
}
- (UIView *)smallView
{
    if (!_smallView) {
        _smallView = [[UIView alloc] init];
    }
    return _smallView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
