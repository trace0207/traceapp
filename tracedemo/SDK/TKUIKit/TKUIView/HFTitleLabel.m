//
//  HFTitleLabel.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/15.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HFTitleLabel.h"
#import "UIColor+TK_Color.h"
@interface HFTitleLabel ()
{
    NSInteger _number;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@end

@implementation HFTitleLabel

- (UIFont *)textFont
{
    if (_textFont == nil) {
        _textFont = [UIFont systemFontOfSize:14];
    }
    return _textFont;
}

- (UIColor *)textColor
{
    if (_textColor == nil) {
        _textColor = [UIColor tkThemeColor1];
    }
    return _textColor;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = self.textColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = self.textFont;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)numberLabel
{
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.backgroundColor = [UIColor tkThemeColor1];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = [UIFont systemFontOfSize:7];
        _numberLabel.clipsToBounds = YES;
        [_numberLabel.layer setCornerRadius:6];
        [self addSubview:_numberLabel];
    }
    return _numberLabel;
}

- (void)setTitle:(NSString *)title number:(NSInteger)number
{
    _number = number;
    self.titleLabel.text = title;
    if (number>0) {
        
        if (number>99) {
            self.numberLabel.font = [UIFont systemFontOfSize:6];
            self.numberLabel.text = [NSString stringWithFormat:@"99⁺"];
        }else {
            self.numberLabel.text = [@(number)stringValue];
        }
    }
    [self updateConstraints];
}

- (void)layoutSubviews
{
    WS(weakSelf)
    if (_number > 0) {
        
        [self.numberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).with.offset(-10);
            make.size.mas_equalTo(CGSizeMake(12, 12));
            make.centerY.equalTo(weakSelf.mas_centerY);
            
        }];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(10);
            make.top.bottom.equalTo(weakSelf);
            make.right.equalTo(weakSelf.numberLabel.mas_left).with.offset(-5);
        }];
    }else {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(10);
            make.top.bottom.equalTo(weakSelf);
            make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        }];
    }
}

@end
