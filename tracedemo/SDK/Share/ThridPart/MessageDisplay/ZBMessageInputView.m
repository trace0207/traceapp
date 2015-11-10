//
//  ZBMessageInputView.m
//  MessageDisplay
//
//  Created by zhoubin@moshi on 14-5-10.
//  Copyright (c) 2014年 Crius_ZB. All rights reserved.
//

#import "ZBMessageInputView.h"
#import "NSString+Message.h"

@interface ZBMessageInputView()<UITextViewDelegate>

@property (nonatomic, weak, readwrite) ZBMessageTextView *messageInputTextView;

@end

@implementation ZBMessageInputView

- (void)dealloc{
    _messageInputTextView.delegate = nil;
    _messageInputTextView = nil;
}

#pragma mark - Action
- (void)changeEmotion
{
    [self messageStyleButtonClicked];
}
- (void)messageStyleButtonClicked{
    self.emotionButton.selected = !self.emotionButton.selected;
    if (self.emotionButton.selected) {
        NSLog(@"表情被点击");
        [self.messageInputTextView resignFirstResponder];
    }else{
        NSLog(@"表情没被点击");
        [self.messageInputTextView becomeFirstResponder];
    }
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.messageInputTextView.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
    
    if ([self.delegate respondsToSelector:@selector(didSendFaceAction:)]) {
        [self.delegate didSendFaceAction:self.emotionButton.selected];
    }

}


#pragma mark - 添加控件
- (void)setupMessageInputViewBarWithStyle:(ZBMessageInputViewStyle)style textView:(ZBMessageTextView *)aTextView{
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundClick)];
    [self addGestureRecognizer:gesture];

    self.backgroundColor = [UIColor whiteColor];
    self.emotionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.emotionButton setBackgroundImage:IMG(@"smile1") forState:UIControlStateNormal];
    [self.emotionButton setBackgroundImage:IMG(@"smileClick") forState:UIControlStateSelected];
    [self.emotionButton addTarget:self
                            action:@selector(messageStyleButtonClicked)
                  forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.emotionButton];
     self.emotionButton.frame = CGRectMake(16, 16, 30, 30);

    if (!aTextView) {
        // 初始化输入框
        ZBMessageTextView *textView = [[ZBMessageTextView alloc] initWithFrame:CGRectMake(52, 16, self.frame.size.width - 80 - 32 - 30, 30)];
        textView.font = [UIFont systemFontOfSize:14.0f];
        textView.returnKeyType = UIReturnKeySend;
        textView.enablesReturnKeyAutomatically = YES; // UITextView内部判断send按钮是否可以用
        textView.delegate = self;
        [self addSubview:textView];
        self.messageInputTextView = textView;
        
        //初始化输入框下面的细线
        self.mInputLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(textView.frame), CGRectGetMaxY(textView.frame), CGRectGetWidth(textView.frame), 1)];
        self.mInputLine.backgroundColor = [UIColor HFColorStyle_6];
        [self addSubview:self.mInputLine];
        
        //发送按钮
        self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sendButton setTitle:@"发表" forState:UIControlStateNormal];
        [self.sendButton addTarget:self action:@selector(sendButtonDoClick) forControlEvents:UIControlEventTouchUpInside];
        self.sendButton.frame = CGRectMake(self.frame.size.width - 64 - 16, 16, 64, 30);
        [self addSubview:self.sendButton];
        self.sendButton.userInteractionEnabled = NO;
        self.sendButton.backgroundColor = [UIColor HFColorStyle_6];
    }else{
        self.messageInputTextView = aTextView;
    }
}

- (id)initWithFrame:(CGRect)frame textView:(ZBMessageTextView *)textView
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup:textView];
    }
    return self;
}


#pragma end

- (void)setup:(ZBMessageTextView *)textView {
    // 配置自适应
    self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
    self.opaque = YES;
    // 由于继承UIImageView，所以需要这个属性设置
    self.userInteractionEnabled = YES;
    [self setupMessageInputViewBarWithStyle:_messageInputViewStyle textView:textView];
}

#pragma mark - textViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(inputTextViewWillBeginEditing:)])
    {
        [self.delegate inputTextViewWillBeginEditing:self.messageInputTextView];
    }
    self.emotionButton.selected = NO;
    self.multiMediaSendButton.selected = NO;
   
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(inputTextViewDidChange:)]) {
        [self.delegate inputTextViewDidChange:self.messageInputTextView];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [textView becomeFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(inputTextViewDidBeginEditing:)]) {
        [self.delegate inputTextViewDidBeginEditing:self.messageInputTextView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        if ([self.delegate respondsToSelector:@selector(didSendTextAction:)]) {
            [self.delegate didSendTextAction:self.messageInputTextView];
        }
        return NO;
    }
    return YES;
}

#pragma end
- (void)sendButtonDoClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendCommentMessage:)]) {
        [self.delegate sendCommentMessage:self.messageInputTextView];
    }
}
- (void)backgroundClick
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
