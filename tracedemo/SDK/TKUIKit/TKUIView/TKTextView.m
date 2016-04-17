//
//  TKTextView.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/4/6.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKTextView.h"
#import "UIView+Border.h"
#import "UIColor+TK_Color.h"
@interface TKTextView ()<UITextViewDelegate>


@end

@implementation TKTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultSettings];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self defaultSettings];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSettings];
    }
    return self;
}

- (void)defaultSettings
{
    self.backgroundColor = [UIColor whiteColor];
    _placehorderFont = [UIFont systemFontOfSize:14];
    _textViewFont = [UIFont systemFontOfSize:14];
    _placehorderColor = [UIColor lightGrayColor];
    _textViewColor = [UIColor hexChangeFloat:TKColorBlack];
    _borderColor = [UIColor hexChangeFloat:@"bbbbbb"];
    _borderWidth = 1;
    _cornerRadius = 2;
    //[self setDefaultBorder];
}

- (void)layoutSubviews
{
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    if (_placehorder) {
        [self.placehorder mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(5);
            make.top.equalTo(self).with.offset(6);
            make.height.mas_equalTo(20);
            make.width.mas_greaterThanOrEqualTo(0);
        }];
    }
}

#pragma mark - 懒加载
- (UILabel *)placehorder
{
    if (_placehorder == nil) {
        _placehorder = [[UILabel alloc]init];
        _placehorder.font = self.placehorderFont;
        _placehorder.textColor = self.placehorderColor;
        [self addSubview:_placehorder];
    }
    return _placehorder;
}

- (UITextView *)textView
{
    if (nil == _textView) {
        _textView = [[UITextView alloc]init];
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = self.textViewColor;
        _textView.font = self.textViewFont;
        [self addSubview:_textView];
    }
    return _textView;
}

#pragma mark - 属性设置
- (void)setPlacehorderText:(NSString *)placehorderText
{
    _placehorderText = placehorderText;
    self.placehorder.text = placehorderText;
}

- (void)setPlacehorderFont:(UIFont *)placehorderFont
{
    _placehorderFont = placehorderFont;
    self.placehorder.font = placehorderFont;
}

- (void)setPlacehorderColor:(UIColor *)placehorderColor
{
    _placehorderColor = placehorderColor;
    self.placehorder.textColor = placehorderColor;
}

- (void)setTextViewFont:(UIFont *)textViewFont
{
    _textViewFont = textViewFont;
    self.textView.font = textViewFont;
}

- (void)setTextViewColor:(UIColor *)textViewColor
{
    _textViewColor = textViewColor;
    self.textView.textColor = textViewColor;
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.textView.text = text;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.borderColor = borderColor;
    [self setBorderColor:self.borderColor borderWidth:self.borderWidth];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.borderWidth = borderWidth;
    [self setBorderColor:self.borderColor borderWidth:self.borderWidth];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.cornerRadius = cornerRadius;
    [self.layer setCornerRadius:self.cornerRadius];
}

- (BOOL)resignFirstResponder
{
    return [self.textView resignFirstResponder];
}

#pragma mark - text view delegate

- (void)textViewDidChange:(UITextView *)textView
{
    _text = textView.text;
    if (textView.text.length==0) {
        if (_placehorder) {
            self.placehorder.hidden = NO;
        }
    }else{
        if (_placehorder) {
            self.placehorder.hidden = YES;
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.delegate textViewDidChange:self];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (_delegate && [_delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.delegate textViewShouldBeginEditing:self];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (_delegate && [_delegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.delegate textViewShouldEndEditing:self];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _isEditing = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.delegate textViewDidBeginEditing:self];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    _isEditing = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.delegate textViewDidEndEditing:self];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (_delegate && [_delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        [self.delegate textView:self shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}

@end
