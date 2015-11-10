//
//  HFActionView.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/21.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFActionView.h"

@interface HFActionView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation HFActionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setActionData:(SchemeActionsData *)data
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:data.picAddr] placeholderImage:IMG(@"main_banner")];
    self.titleLable.text = data.title;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _imageView;
}

- (UILabel *)titleLable
{
    if (!_titleLable) {
        WS(weakSelf)
        UIImageView *textBgView = [[UIImageView alloc]init];
        [textBgView setImage:IMG(@"text_bg")];
        [self addSubview:textBgView];
        [textBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.bottom.equalTo(weakSelf.mas_bottom);
            make.right.equalTo(weakSelf.mas_right);
            make.height.mas_greaterThanOrEqualTo(@19);
        }];
        _titleLable = [[UILabel alloc]init];
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLable];
        
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.bottom.equalTo(weakSelf.mas_bottom);
            make.height.mas_greaterThanOrEqualTo(@2);
            make.width.mas_lessThanOrEqualTo(@100);
        }];
        
        UIImageView *arrow = [[UIImageView alloc]init];
        arrow.image = IMG(@"jiantou");
        [self addSubview:arrow];
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(8, 14));
            make.left.equalTo(_titleLable.mas_right).with.offset(3);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-1);
        }];
    }
    return _titleLable;
}

- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc]init];
        [self addSubview:_selectBtn];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _selectBtn;
}

- (void)selectedItemSelector:(SEL)selector withTarget:(id)target
{
    self.selectBtn.tag = self.tag - BASETAG;
    [self.selectBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

@end
