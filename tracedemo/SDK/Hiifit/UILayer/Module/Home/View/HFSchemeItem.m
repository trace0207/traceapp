//
//  HFSchemeItem.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/9/16.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFSchemeItem.h"

@interface HFSchemeItem()
{
    NSInteger  subSchemeID;
    NSString *schemeName;
}
@property(nonatomic,strong)UIImageView * bgImageView;
@property(nonatomic,strong)UILabel * mtitleLabel;
@property(nonatomic,strong)UILabel * mNameLabel;
@property(nonatomic,strong)UILabel * mdayLabel;
@end

@implementation HFSchemeItem

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self addGesture];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self addGesture];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addGesture];
    }
    return self;
}

#pragma mark -
#pragma mark private

- (void)addGesture
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self addGestureRecognizer:tap];
}

- (void)tapClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(itemClick:subSchemeName:)])
    {
        [_delegate itemClick:subSchemeID subSchemeName:schemeName];
    }
}

#pragma mark -
#pragma mark public
- (void)setContentTitle:(NSString *)title
                bgImage:(NSString *)imageStr
               withName:(NSString *)name
             withtypeID:(NSInteger)schemeID
{
    
//    NSString * day = [title substringWithRange:NSMakeRange(0, [title length] - 1)];
    
//    CGFloat fontSize;
//    
//    if ([day intValue] > 999)
//    {
//        title = @"999⁺";
//        
//        fontSize = 18.0;
//    }
//    else
//    {
//        fontSize = 24.0;
//    }
//    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:title];
//    [attributedStr addAttribute:NSFontAttributeName
//                          value:[UIFont systemFontOfSize:fontSize]
//                          range:NSMakeRange(0, [title length] - 1)];
    
    subSchemeID = schemeID;
    schemeName = name;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:IMG(@"heabit")];
    self.mtitleLabel.text = title;
    self.mNameLabel.text = name;
    self.mdayLabel.text = @"天";
}

#pragma mark -
#pragma mark getter
- (UIImageView *)bgImageView
{
    WS(weakSelf)
    if (!_bgImageView)
    {
        _bgImageView = [[UIImageView alloc] init];
        [self addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(weakSelf).with.offset(0);
            make.height.mas_equalTo(83);
        }];
    }
    [self sendSubviewToBack:_bgImageView];
    return _bgImageView;
}

- (UILabel *)mtitleLabel
{
    WS(weakSelf)
    if (!_mtitleLabel)
    {
        _mtitleLabel = [[UILabel alloc] init];
        _mtitleLabel.textAlignment = NSTextAlignmentCenter;
        _mtitleLabel.textColor = [UIColor whiteColor];
        _mtitleLabel.font = [UIFont boldSystemFontOfSize:32.0];
        [self addSubview:_mtitleLabel];
        [_mtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf).with.offset(0);
            make.top.equalTo(weakSelf).with.offset(5);
            make.height.mas_equalTo(50);
        }];
    }
    [self bringSubviewToFront:_mtitleLabel];
    return _mtitleLabel;
}

- (UILabel *)mdayLabel
{
    WS(weakSelf)
    if (!_mdayLabel)
    {
        _mdayLabel = [[UILabel alloc] init];
        _mdayLabel.textAlignment = NSTextAlignmentCenter;
        _mdayLabel.textColor = [UIColor whiteColor];
        _mdayLabel.font = [UIFont systemFontOfSize:18.0];
        
        [self addSubview:_mdayLabel];
        [_mdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf).with.offset(0);
            make.top.equalTo(weakSelf.mtitleLabel.mas_bottom).with.offset(0);
            make.height.mas_equalTo(20);
        }];
    }
    [self bringSubviewToFront:_mdayLabel];
    return _mdayLabel;
}


- (UILabel *)mNameLabel
{
    WS(weakSelf)
    if (!_mNameLabel)
    {
        _mNameLabel = [[UILabel alloc] init];
        _mNameLabel.font = [UIFont systemFontOfSize:13.0];
        _mNameLabel.textAlignment = NSTextAlignmentCenter;
        _mNameLabel.textColor = [UIColor HFColorStyle_3];
        [self addSubview:_mNameLabel];
        [_mNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(weakSelf).with.offset(0);
            make.height.mas_equalTo(20);
        }];
    }
    return _mNameLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
