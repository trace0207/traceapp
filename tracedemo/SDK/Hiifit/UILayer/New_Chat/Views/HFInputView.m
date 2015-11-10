//
//  HFInputView.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/7/17.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFInputView.h"
#import "ZBMessageTextView.h"

@interface HFInputView()<UITextViewDelegate>

//@property(nonatomic,strong)UIButton * mSendBtn;
//@property(nonatomic,strong)UIView  * mLine;
@property (nonatomic, strong) UIImageView * backgroundView;
@end

@implementation HFInputView

#pragma mark -
#pragma mark private
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self resetFrame];
    }
    return self;
}

#pragma mark -
#pragma mark public
- (void)clearTextView
{
    [self initPlaceholder:@"评论一下吧"];
}

- (void)initPlaceholder:(NSString *)placerholder
{
    self.mTextView.text = @"";
    self.mTextView.placeHolder = placerholder;
    self.mTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.mTextView.layer.cornerRadius = 10;
    self.mTextView.layer.masksToBounds = YES;
    self.mSendBtn.backgroundColor = [UIColor hexChangeFloat:@"CCCCCC" withAlpha:1];
    self.mSendBtn.userInteractionEnabled = NO;
}

#pragma mark -
#pragma mark private
- (void)sendButtonClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(sendAction)])
    {
        [_delegate sendAction];
    }
}

- (void)resetFrame
{
    self.backgroundView.frame = CGRectMake(0, 10, self.frame.size.width - 66, 42);
    self.mTextView.frame = CGRectMake(3, 11, self.frame.size.width - 72, 40);
    self.mSendBtn.frame = CGRectMake(CGRectGetMaxX(self.mTextView.frame) + 10, 10, 70, 42);
}
- (void)TextViewBecomeFirstResponder
{
    [self.mTextView becomeFirstResponder];
}
- (ZBMessageTextView *)mTextView
{
    if (!_mTextView)
    {
        _mTextView = [[ZBMessageTextView alloc] init];
        _mTextView.delegate  = self;
        _mTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _mTextView.placeHolderFont = [UIFont systemFontOfSize:16.0];
        _mTextView.placeHolderCenter = 10.0;
        _mTextView.placeHolder = @"评论一下吧";
        [self addSubview:_mTextView];
    }
    return _mTextView;
}



- (UIButton *)mSendBtn
{
    if (!_mSendBtn)
    {
        _mSendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mSendBtn addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _mSendBtn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
        [_mSendBtn setTitle:@"发表" forState:UIControlStateNormal];
        _mSendBtn.layer.cornerRadius = 7.0;
        [_mSendBtn setBackgroundColor:[UIColor hexChangeFloat:@"CCCCCC" withAlpha:1.0]];
        _mSendBtn.userInteractionEnabled = NO;
        [self addSubview:_mSendBtn];
    }
    return _mSendBtn;
}

- (UIImageView * )backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIImageView alloc] init];
        _backgroundView.image = IMG(@"typingBg");
        [self addSubview:_backgroundView];
    }
    return _backgroundView;
}
#pragma mark -
#pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if ([self replaceString:textView.text].length != 0) {
        self.mSendBtn.backgroundColor = [UIColor HFColorStyle_5];
        self.mSendBtn.userInteractionEnabled = YES;
        [textView scrollRectToVisible:CGRectMake(0, textView.contentSize.height-15, textView.contentSize.width, 10) animated:NO];
    }else{
        self.mSendBtn.backgroundColor = [UIColor hexChangeFloat:@"CCCCCC" withAlpha:1.0];
        self.mSendBtn.userInteractionEnabled = NO;
    }
}
- (NSString *)replaceString:(NSString *)string
{
    NSString * str = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return str;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
