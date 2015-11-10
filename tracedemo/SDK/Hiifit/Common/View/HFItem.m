//
//  HFItem.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFItem.h"

@implementation HFItem

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initUISetting];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initUISetting];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self initUISetting];
    }
    
    return self;
}

- (void)initUISetting
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)addTarget:(id)target selector:(SEL)selector withObject:(id)object
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        [self addSubview:_iconImageView];
        WS(weakSelf)
        CGFloat width = MIN(self.frame.size.width, self.frame.size.height);
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0.43*width, 0.43*width));
            make.top.equalTo(weakSelf.mas_top).with.offset(0.16*weakSelf.frame.size.height);
            make.centerX.equalTo(weakSelf.mas_centerX);
        }];
        
    }
    return _iconImageView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:12];
        _textLabel.textColor = [UIColor hexChangeFloat:@"333333" withAlpha:1];
        [self addSubview:_textLabel];
        WS(weakSelf)
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width, 0.16*weakSelf.frame.size.height));
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-0.145*weakSelf.frame.size.height);
        }];
    }
    return _textLabel;
}
- (UILabel *)tieBarUnreadLabel
{
    if (!_tieBarUnreadLabel) {
        _tieBarUnreadLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 12, 14, 14)];
        _tieBarUnreadLabel.textAlignment = NSTextAlignmentCenter;
        _tieBarUnreadLabel.font = [UIFont systemFontOfSize:7];
        _tieBarUnreadLabel.layer.cornerRadius = 7;
        _tieBarUnreadLabel.layer.masksToBounds = YES;
        _tieBarUnreadLabel.backgroundColor = [UIColor HFColorStyle_5];
        _tieBarUnreadLabel.textColor = [UIColor whiteColor];
        [self addSubview:_tieBarUnreadLabel];
        
    }
    return _tieBarUnreadLabel;
}
- (void)setItemWithImageUrl:(NSString *)imageUrl andText:(NSString *)text
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:IMG(@"default_habit")];
    [self.textLabel setText:text];
}

- (void)setLocalImage:(UIImage *)image andText:(NSString *)text
{
    [self.iconImageView setImage:image];
    self.textLabel.text = text;
}

- (void)setTextFont:(UIFont *)textFont
{
    [self.textLabel setFont:textFont];
}

- (void)setTextColor:(UIColor *)textColor
{
    [self.textLabel setTextColor:textColor];
}

@end
